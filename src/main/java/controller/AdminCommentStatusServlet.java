package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import model.UserBean;
import repository.CommentRepository;

@WebServlet("/AdminCommentStatusServlet")
public class AdminCommentStatusServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        UserBean user =
                (UserBean) request.getSession()
                .getAttribute("user");

        if(user == null){
            response.sendRedirect("login.jsp");
            return;
        }

        if(!"ADMIN".equalsIgnoreCase(user.getRole())){
            response.sendRedirect("HomeServlet");
            return;
        }

        long id = Long.parseLong(
                request.getParameter("id")
        );

        String status =
                request.getParameter("status");

        CommentRepository repo =
                new CommentRepository();

        repo.adminUpdateCommentStatus(
                id,
                status
        );

        response.sendRedirect(
                "AdminCommentListServlet"
        );
    }
}