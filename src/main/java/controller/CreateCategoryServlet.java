package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.CategoryBean;
import repository.CategoryRepository;

@WebServlet("/CreateCategoryServlet")
public class CreateCategoryServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");

        CategoryBean c = new CategoryBean();
        c.setName(name);

        CategoryRepository repo = new CategoryRepository();

        int result = repo.insertCategory(c);

        if(result > 0) {
            response.sendRedirect("CategoryListServlet");
        } else {
            request.setAttribute("msg", "Category Create Failed!");
            request.getRequestDispatcher("createCategory.jsp")
                   .forward(request, response);
        }
    }
}