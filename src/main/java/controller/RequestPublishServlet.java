package controller;

import java.io.IOException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import model.UserBean;
import repository.CheatSheetRepository;

@WebServlet("/RequestPublishServlet")
public class RequestPublishServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        UserBean user = (UserBean) request.getSession().getAttribute("user");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        long id = Long.parseLong(request.getParameter("id"));

        new CheatSheetRepository().requestPublish(id, user.getId());

        response.sendRedirect("MyCheatSheetsServlet");
    }
}