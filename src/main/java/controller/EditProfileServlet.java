package controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import model.UserBean;
import repository.UserRepository;
import util.PasswordUtil;

@WebServlet("/EditProfileServlet")
@MultipartConfig
public class EditProfileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        UserBean loginUser = (UserBean) session.getAttribute("user");

        if (loginUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        long id = Long.parseLong(request.getParameter("uid"));
        String name = request.getParameter("uname");
        String email = request.getParameter("uemail");
        String password = request.getParameter("upass");

        Part imagePart = request.getPart("uimg");

        String newFileName = null;
        String finalImageName = loginUser.getProfile_img();

        if (imagePart != null && imagePart.getSize() > 0) {

            newFileName = Paths.get(imagePart.getSubmittedFileName())
                    .getFileName()
                    .toString();

            String uploadPath = getServletContext().getRealPath("")
                    + File.separator + "uploads";

            File uploadDir = new File(uploadPath);

            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            imagePart.write(uploadPath + File.separator + newFileName);

            String oldImage = loginUser.getProfile_img();

            if (oldImage != null && !oldImage.equals("default.png")) {

                File oldFile = new File(uploadPath + File.separator + oldImage);

                if (oldFile.exists()) {
                    oldFile.delete();
                }
            }

            finalImageName = newFileName;
        }

        UserBean user = new UserBean();

        user.setId(id);
        user.setName(name);
        user.setEmail(email);
        user.setProfile_img(finalImageName);

        if (password != null && !password.trim().isEmpty()) {
            user.setPassword(PasswordUtil.hashPassword(password));
        } else {
            user.setPassword(loginUser.getPassword());
        }

        user.setRole(loginUser.getRole());
        user.setStatus(loginUser.getStatus());
        user.setCreated_at(loginUser.getCreated_at());

        UserRepository repo = new UserRepository();

        boolean status = repo.updateProfile(user);

        if (status) {
            session.setAttribute("user", user);
            request.setAttribute("msg", "Profile updated successfully!");
        } else {
            request.setAttribute("msg", "Profile update failed!");
        }

        request.getRequestDispatcher("editProfile.jsp").forward(request, response);
    }
}