package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import model.UserBean;
import repository.CheatSheetRepository;

@WebServlet("/MakePrivateServlet")
public class MakePrivateServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        UserBean user = (UserBean) session.getAttribute("user");

        if(user == null){
            response.sendRedirect("login.jsp");
            return;
        }

        long id = Long.parseLong(request.getParameter("id"));

        CheatSheetRepository repo = new CheatSheetRepository();

        repo.makePrivate(id, user.getId());

        response.sendRedirect("MyCheatSheetsServlet");
    }
}