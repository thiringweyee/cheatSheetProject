package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import repository.CategoryRepository;

@WebServlet("/DeleteCategoryServlet")
public class DeleteCategoryServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        long id = Long.parseLong(request.getParameter("id"));

        CategoryRepository repo = new CategoryRepository();

        boolean result = repo.deleteCategory(id);

        if(result) {
            response.sendRedirect("CategoryListServlet");
        } else {
            response.getWriter().println("Delete Failed");
        }
    }
}