package controller;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import model.CheatSheetBean;
import model.UserBean;
import repository.CategoryRepository;
import repository.CheatSheetRepository;

@WebServlet("/EditCheatSheetPageServlet")
public class EditCheatSheetPageServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        UserBean user = (UserBean) request.getSession().getAttribute("user");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        long id = Long.parseLong(request.getParameter("id"));

        CheatSheetBean cheat = new CheatSheetRepository().getCheatSheetById(id);

        if (cheat == null || cheat.getUsers_id() != user.getId()) {
            response.sendRedirect("MyCheatSheetsServlet");
            return;
        }

        request.setAttribute("cheat", cheat);
        request.setAttribute("categoryList", new CategoryRepository().getAllCategories());
        request.getRequestDispatcher("editCheatSheet.jsp").forward(request, response);
    }
}