package controller;

import java.io.File;
import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import model.UserBean;
import repository.UserRepository;
import util.ValidationUtil;
import util.PasswordUtil;

@WebServlet("/RegisterServlet")
@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 5 * 1024 * 1024)
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("uname");
        String email = request.getParameter("uemail");
        String password = request.getParameter("upass");
        String confirmPassword = request.getParameter("ucpass");
        Part imgPart = request.getPart("uimg");

        String fileName = null;
        if (imgPart != null && imgPart.getSize() > 0) {
            fileName = System.currentTimeMillis() + "_" + imgPart.getSubmittedFileName();

            String uploadPath = System.getProperty("user.home") + "/DevNoteUploads";
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdirs();
            imgPart.write(uploadPath + File.separator + fileName);

        }

        // Validation checks
        if (name.isEmpty() || email.isEmpty() || password.isEmpty() || confirmPassword.isEmpty()) {
            request.setAttribute("msg", "Please fill all fields!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        if (!ValidationUtil.isValidEmail(email)) {
            request.setAttribute("msg", "Invalid email format!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        if (!ValidationUtil.isStrongPassword(password)) {
            request.setAttribute("msg", "Password must be at least 8 chars with upper, lower, digit & special char!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        if (!password.equals(confirmPassword)) {
            request.setAttribute("msg", "Passwords do not match!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        UserRepository repo = new UserRepository();
        if (repo.isEmailExists(email)) {
            request.setAttribute("msg", "Email already exists!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // Hash password with BCrypt before saving
        String hashedPassword = PasswordUtil.hashPassword(password);

        UserBean user = new UserBean();
        user.setName(name);
        user.setEmail(email);
        user.setPassword(hashedPassword);
        user.setProfile_img(fileName); // only filename saved in DB
        user.setRole("USER");

        int result = repo.insertUser(user);
        if (result != 0) {
            response.sendRedirect("login.jsp");
        } else {
            request.setAttribute("msg", "Registration failed!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }
}
