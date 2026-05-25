package controller;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import model.UserBean;
import repository.CheatSheetRepository;

@WebServlet("/PendingCheatSheetsServlet")
public class PendingCheatSheetsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
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

        request.setAttribute("pendingList", new CheatSheetRepository().getPendingCheatSheets());
        request.getRequestDispatcher("pendingCheatSheets.jsp").forward(request, response);
    }
}