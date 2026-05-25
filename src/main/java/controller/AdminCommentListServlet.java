package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import model.CommentBean;
import model.UserBean;
import repository.CommentRepository;

@WebServlet("/AdminCommentListServlet")
public class AdminCommentListServlet extends HttpServlet {
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

        CommentRepository repo =
                new CommentRepository();

        List<CommentBean> list =
                repo.getAllComments();

        request.setAttribute("commentList", list);

        request.getRequestDispatcher(
                "adminCommentList.jsp"
        ).forward(request, response);
    }
}