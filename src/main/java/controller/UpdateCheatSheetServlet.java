package controller;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import model.CheatSheetBean;
import model.UserBean;
import repository.CheatSheetRepository;

@WebServlet("/UpdateCheatSheetServlet")
public class UpdateCheatSheetServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        UserBean user = (UserBean) request.getSession().getAttribute("user");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        CheatSheetBean c = new CheatSheetBean();
        c.setId(Long.parseLong(request.getParameter("id")));
        c.setTitle(request.getParameter("title"));
        c.setDescription(request.getParameter("description"));
        c.setCode_content(request.getParameter("code_content"));
        c.setLanguage(request.getParameter("language"));
        c.setCategories_id(Long.parseLong(request.getParameter("categories_id")));
        c.setTagsText(request.getParameter("tags"));
        c.setUsers_id(user.getId());

        boolean ok = new CheatSheetRepository().updateCheatSheet(c);

        if (ok) {
            response.sendRedirect("MyCheatSheetsServlet");
        } else {
            request.setAttribute("msg", "Update failed!");
            request.getRequestDispatcher("EditCheatSheetPageServlet?id=" + c.getId()).forward(request, response);
        }
    }
}