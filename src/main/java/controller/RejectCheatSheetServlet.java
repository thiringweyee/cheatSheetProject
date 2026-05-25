package controller;

import java.io.IOException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import model.UserBean;
import repository.CheatSheetRepository;

@WebServlet("/RejectCheatSheetServlet")
public class RejectCheatSheetServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        UserBean admin = (UserBean) request.getSession().getAttribute("user");

        if (admin == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        if (!"ADMIN".equalsIgnoreCase(admin.getRole())) {
            response.sendRedirect("userview.jsp");
            return;
        }

        long id = Long.parseLong(request.getParameter("id"));

        new CheatSheetRepository().rejectCheatSheet(id);

        response.sendRedirect("PendingCheatSheetsServlet");
    }
}