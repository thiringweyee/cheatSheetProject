package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import model.UserBean;
import repository.CheatSheetRepository;

@WebServlet("/CheatSheetRecordServlet")
public class CheatSheetRecordServlet extends HttpServlet {
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

        CheatSheetRepository repo = new CheatSheetRepository();

        request.setAttribute("recordList", repo.getAllCheatSheetRecords());

        request.getRequestDispatcher("cheatSheetRecord.jsp")
               .forward(request, response);
    }
}