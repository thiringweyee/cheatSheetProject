package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import model.UserBean;
import repository.CommentRepository;

@WebServlet("/ToggleCommentVisibilityServlet")
public class ToggleCommentVisibilityServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        UserBean user = (UserBean) request.getSession().getAttribute("user");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        long commentId = Long.parseLong(request.getParameter("id"));
        long cheatId = Long.parseLong(request.getParameter("cheatId"));

        CommentRepository repo = new CommentRepository();

        repo.toggleOwnCommentVisibility(commentId, user.getId());

        response.sendRedirect(
                request.getContextPath()
                + "/CheatSheetDetailServlet?id="
                + cheatId
                + "#comment-area"
        );
    }
}