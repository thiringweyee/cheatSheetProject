package controller;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import model.UserBean;
import repository.CheatSheetRepository;

@WebServlet("/MyCheatSheetsServlet")
public class MyCheatSheetsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        UserBean user = (UserBean) request.getSession().getAttribute("user");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        request.setAttribute("myCheatList", new CheatSheetRepository().getMyCheatSheets(user.getId()));
        request.getRequestDispatcher("myCheatSheets.jsp").forward(request, response);
    }
}