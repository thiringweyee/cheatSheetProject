package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.CategoryBean;
import repository.CategoryRepository;

@WebServlet("/EditCategoryServlet")
public class EditCategoryServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        long id = Long.parseLong(request.getParameter("id"));

        CategoryRepository repo = new CategoryRepository();

        CategoryBean c = repo.findById(id);

        request.setAttribute("category", c);

        request.getRequestDispatcher("editCategory.jsp")
               .forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        long id = Long.parseLong(request.getParameter("id"));
        String name = request.getParameter("name");

        CategoryBean c = new CategoryBean();

        c.setId(id);
        c.setName(name);

        CategoryRepository repo = new CategoryRepository();

        boolean result = repo.updateCategory(c);

        if(result) {
            response.sendRedirect("CategoryListServlet");
        } else {
            response.getWriter().println("Update Failed");
        }
    }
}