package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.CategoryBean;
import repository.CategoryRepository;

@WebServlet("/CategoryListServlet")
public class CategoryListServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        CategoryRepository repo = new CategoryRepository();

        List<CategoryBean> list = repo.getAllCategories();

        request.setAttribute("categoryList", list);

        request.getRequestDispatcher("categoryList.jsp")
               .forward(request, response);
    }
}