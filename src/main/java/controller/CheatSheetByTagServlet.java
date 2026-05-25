package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import repository.CheatSheetRepository;

@WebServlet("/CheatSheetByTagServlet")
public class CheatSheetByTagServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        String tagName = request.getParameter("tag");

        if (tagName == null || tagName.trim().isEmpty()) {
            response.sendRedirect("CheatSheetListServlet");
            return;
        }

        tagName = tagName.trim().toLowerCase();

        CheatSheetRepository repo = new CheatSheetRepository();

        request.setAttribute(
                "cheatList",
                repo.getPublicCheatSheetsByTag(tagName)
        );

        request.setAttribute(
                "pageTitle",
                "#" + tagName + " Cheat Sheets"
        );

        request.setAttribute(
                "pageSubtitle",
                "Browse approved public cheat sheets tagged with #" + tagName + "."
        );

        request.getRequestDispatcher("cheatsheets.jsp")
               .forward(request, response);
    }
}