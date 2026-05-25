package controller;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import model.CheatSheetBean;
import model.UserBean;
import repository.CheatSheetRepository;

@WebServlet("/CreateCheatSheetServlet")
public class CreateCheatSheetServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        UserBean user = (UserBean) request.getSession().getAttribute("user");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        CheatSheetBean c = new CheatSheetBean();

        c.setTitle(request.getParameter("title"));
        c.setDescription(request.getParameter("description"));
        c.setCode_content(request.getParameter("code_content"));
        c.setLanguage(request.getParameter("language"));
        c.setCategories_id(Long.parseLong(request.getParameter("categories_id")));
        c.setUsers_id(user.getId());

        String tags = request.getParameter("tags");

        CheatSheetRepository repo = new CheatSheetRepository();

        long cheatId = repo.createCheatSheet(c);

        if (cheatId > 0) {
            repo.saveTags(cheatId, tags);
            response.sendRedirect("MyCheatSheetsServlet");
        } else {
            request.setAttribute("msg", "Create cheat sheet failed!");
            request.getRequestDispatcher("CreateCheatSheetPageServlet").forward(request, response);
        }
    }
}