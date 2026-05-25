package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import model.CheatSheetBean;
import model.UserBean;
import repository.CheatSheetRepository;

@WebServlet("/AdminCheatSheetDetailServlet")
public class AdminCheatSheetDetailServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        UserBean admin = (UserBean) request.getSession().getAttribute("user");

        if (admin == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        if (!"ADMIN".equalsIgnoreCase(admin.getRole())) {
            response.sendRedirect("userview.jsp");
            return;
        }

        String idParam = request.getParameter("id");

        if (idParam == null || idParam.trim().isEmpty()) {
            response.sendRedirect("CheatSheetRecordServlet");
            return;
        }

        long id = Long.parseLong(idParam);

        CheatSheetRepository repo = new CheatSheetRepository();

        CheatSheetBean cheat = repo.getCheatSheetByIdForAdmin(id);

        if (cheat == null) {
            response.sendRedirect("CheatSheetRecordServlet");
            return;
        }

        request.setAttribute("cheat", cheat);

        request.getRequestDispatcher("cheatsheetDetail.jsp")
               .forward(request, response);
    }
}