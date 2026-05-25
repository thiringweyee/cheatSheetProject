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

@WebServlet("/HomeServlet")
public class HomeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private CategoryRepository repo = new CategoryRepository();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<CategoryBean> categoryList = repo.getAllCategories();

        request.setAttribute("categoryList", categoryList);

        request.getRequestDispatcher("home.jsp")
               .forward(request, response);
    }
}