package controller;

import java.io.IOException;
import java.io.OutputStream;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.itextpdf.text.Document;
import com.itextpdf.text.Font;
import com.itextpdf.text.FontFactory;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.Phrase;
import com.itextpdf.text.BaseColor;
import com.itextpdf.text.pdf.PdfWriter;

import model.CheatSheetBean;
import model.DownloadBean;
import model.UserBean;
import repository.CheatSheetRepository;
import repository.DownloadRepository;

@WebServlet("/DownloadCheatSheetServlet")
public class DownloadCheatSheetServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        String idParam = request.getParameter("id");

        if (idParam == null || idParam.trim().isEmpty()) {
            response.sendRedirect("CheatSheetListServlet");
            return;
        }

        long cheatId = Long.parseLong(idParam);

        CheatSheetRepository cheatRepo = new CheatSheetRepository();
        CheatSheetBean cheat = cheatRepo.getCheatSheetById(cheatId);

        if (cheat == null) {
            response.sendRedirect("CheatSheetListServlet");
            return;
        }

        cheatRepo.increaseDownloadCount(cheatId);

        UserBean user = (UserBean) request.getSession().getAttribute("user");

        if (user != null) {
            DownloadBean d = new DownloadBean();
            d.setUsers_id(user.getId());
            d.setCheatsheets_id(cheatId);

            DownloadRepository downloadRepo = new DownloadRepository();
            downloadRepo.saveDownload(d);
        }

        String fileName = cheat.getTitle()
                .replaceAll("[^a-zA-Z0-9-_]", "_")
                + ".pdf";

        response.setContentType("application/pdf");
        response.setHeader(
                "Content-Disposition",
                "attachment; filename=\"" + fileName + "\""
        );

        try {
            OutputStream out = response.getOutputStream();

            Document document = new Document();
            PdfWriter.getInstance(document, out);

            document.open();

            Font titleFont = FontFactory.getFont(
                    FontFactory.HELVETICA_BOLD,
                    22,
                    BaseColor.BLACK
            );

            Font headingFont = FontFactory.getFont(
                    FontFactory.HELVETICA_BOLD,
                    14,
                    BaseColor.BLACK
            );

            Font normalFont = FontFactory.getFont(
                    FontFactory.HELVETICA,
                    11,
                    BaseColor.DARK_GRAY
            );

            Font codeFont = FontFactory.getFont(
                    FontFactory.COURIER,
                    10,
                    BaseColor.BLACK
            );

            document.add(new Paragraph(cheat.getTitle(), titleFont));
            document.add(new Paragraph("By " + cheat.getAuthorName(), normalFont));
            document.add(new Paragraph("Category: " + cheat.getCategoryName(), normalFont));
            document.add(new Paragraph("Language: " + cheat.getLanguage(), normalFont));
            document.add(new Paragraph(" "));

            document.add(new Paragraph("Description", headingFont));
            document.add(new Paragraph(cheat.getDescription(), normalFont));
            document.add(new Paragraph(" "));

            document.add(new Paragraph("Code Content", headingFont));
            document.add(new Paragraph(" "));

            Paragraph codeParagraph = new Paragraph();
            codeParagraph.setFont(codeFont);
            codeParagraph.add(new Phrase(cheat.getCode_content(), codeFont));

            document.add(codeParagraph);

            document.close();
            out.flush();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}