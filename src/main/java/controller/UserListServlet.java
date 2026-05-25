package controller;

import java.io.IOException;
import java.util.List;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import model.UserBean;
import repository.UserRepository;


@WebServlet("/UserListServlet")
public class UserListServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserRepository repo = new UserRepository();
    private static final int PAGE_SIZE = 5;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int page = 1;
        if (request.getParameter("page") != null) {
            page = Integer.parseInt(request.getParameter("page"));
        }

        String keyword = request.getParameter("keyword");
        if (keyword == null) keyword = "";

        List<UserBean> users = repo.searchActiveUsers(keyword, page, PAGE_SIZE);
        int totalUsers = repo.countSearchActiveUsers(keyword);
        int totalPages = (int) Math.ceil((double) totalUsers / PAGE_SIZE);

        request.setAttribute("userList", users);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("keyword", keyword);
        request.getRequestDispatcher("userList.jsp").forward(request, response);
    }
}
