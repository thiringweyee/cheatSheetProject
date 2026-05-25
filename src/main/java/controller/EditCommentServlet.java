package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import model.UserBean;
import repository.CommentRepository;

@WebServlet("/EditCommentServlet")
public class EditCommentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        UserBean user = (UserBean) request.getSession().getAttribute("user");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        long commentId = Long.parseLong(request.getParameter("comment_id"));
        long cheatId = Long.parseLong(request.getParameter("cheatsheets_id"));
        String content = request.getParameter("content");

        if (content == null || content.trim().isEmpty()) {
            response.sendRedirect(
                    request.getContextPath()
                    + "/CheatSheetDetailServlet?id="
                    + cheatId
                    + "#comment-area"
            );
            return;
        }

        CommentRepository repo = new CommentRepository();
        repo.updateOwnComment(commentId, user.getId(), content.trim());

        response.sendRedirect(
                request.getContextPath()
                + "/CheatSheetDetailServlet?id="
                + cheatId
                + "#comment-area"
        );
    }
}