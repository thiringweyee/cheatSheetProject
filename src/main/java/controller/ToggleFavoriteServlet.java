package controller;

import java.io.IOException;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import model.UserBean;
import repository.FavoriteRepository;

@WebServlet("/ToggleFavoriteServlet")
public class ToggleFavoriteServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws IOException {

        HttpSession session = request.getSession();

        UserBean user = (UserBean) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        long cheatId = Long.parseLong(request.getParameter("id"));

        FavoriteRepository repo = new FavoriteRepository();

        repo.toggleFavorite(user.getId(), cheatId);

        response.sendRedirect("CheatSheetDetailServlet?id=" + cheatId);
    }
}