package controller;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import model.UserBean;
import repository.UserRepository;
import util.PasswordUtil;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("uemail");
        String password = request.getParameter("upass");

        UserRepository repo = new UserRepository();
        // find user by email only
        UserBean user = repo.findByEmail(email);

        if (user != null && PasswordUtil.checkPassword(password, user.getPassword())) {
            HttpSession session = request.getSession();
            session.setAttribute("user", user);

            // Role check
            String role = user.getRole();
            if ("ADMIN".equalsIgnoreCase(role)) {
                // Admin login success
                response.sendRedirect("adminview.jsp");
            } else if ("USER".equalsIgnoreCase(role)) {
                // Normal user login success
                response.sendRedirect("HomeServlet");
            } else {
                // Unknown role
                request.setAttribute("msg", "Unknown role!");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
        } else {
            request.setAttribute("msg", "Invalid email or password!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}
