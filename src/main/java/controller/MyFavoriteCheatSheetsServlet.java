package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import model.UserBean;
import repository.FavoriteRepository;

@WebServlet("/MyFavoriteCheatSheetsServlet")
public class MyFavoriteCheatSheetsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        UserBean user = (UserBean) request.getSession().getAttribute("user");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        FavoriteRepository repo = new FavoriteRepository();

        request.setAttribute(
                "favoriteCheatList",
                repo.getMyFavoriteCheatSheets(user.getId())
        );

        request.getRequestDispatcher("myFavoriteCheatSheets.jsp")
               .forward(request, response);
    }
}