package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import model.CheatSheetBean;
import model.UserBean;
import repository.CheatSheetRepository;
import repository.CommentRepository;
import repository.FavoriteRepository;

@WebServlet("/CheatSheetDetailServlet")
public class CheatSheetDetailServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        String idParam = request.getParameter("id");

        if (idParam == null || idParam.trim().isEmpty()) {
            response.sendRedirect("CheatSheetListServlet");
            return;
        }

        long id = Long.parseLong(idParam);

        CheatSheetRepository cheatRepo = new CheatSheetRepository();

        CheatSheetBean cheat = cheatRepo.getCheatSheetById(id);

        if (cheat == null) {
            response.sendRedirect("CheatSheetListServlet");
            return;
        }

        if ("PUBLIC".equalsIgnoreCase(cheat.getVisibility())
                && "APPROVED".equalsIgnoreCase(cheat.getPublish_status())) {

            cheatRepo.increaseViewCount(id);
            cheat.setView_count(cheat.getView_count() + 1);
        }

        HttpSession session = request.getSession();

        UserBean user = (UserBean) session.getAttribute("user");

        FavoriteRepository favRepo = new FavoriteRepository();

        boolean isFavorited = false;

        if (user != null) {
            isFavorited = favRepo.isFavorited(user.getId(), id);
        }

        int favoriteCount = favRepo.getFavoriteCount(id);

        CommentRepository commentRepo = new CommentRepository();

        request.setAttribute("cheat", cheat);
        request.setAttribute(
        	    "commentCount",
        	    commentRepo.getCommentsByCheatSheetId(id).size()
        	);
        request.setAttribute("isFavorited", isFavorited);
        request.setAttribute("favoriteCount", favoriteCount);
        request.setAttribute(
                "commentList",
                commentRepo.getCommentsByCheatSheetId(id)
        );

        request.getRequestDispatcher("cheatsheetDetail.jsp")
               .forward(request, response);
    }
}