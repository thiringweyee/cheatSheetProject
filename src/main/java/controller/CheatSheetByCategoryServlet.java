package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import repository.CategoryRepository;
import repository.CheatSheetRepository;

@WebServlet("/CheatSheetByCategoryServlet")
public class CheatSheetByCategoryServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        long categoryId = Long.parseLong(request.getParameter("id"));

        CheatSheetRepository cheatRepo = new CheatSheetRepository();
        CategoryRepository categoryRepo = new CategoryRepository();

        String categoryName = categoryRepo.getCategoryNameById(categoryId);

        if (categoryName == null) {
            response.sendRedirect("HomeServlet");
            return;
        }

        request.setAttribute(
                "cheatList",
                cheatRepo.getPublicCheatSheetsByCategory(categoryId)
        );

        request.setAttribute(
                "pageTitle",
                categoryName
        );

        request.setAttribute(
                "pageSubtitle",
                "Browse approved public cheat sheets from " + categoryName + "."
        );

        request.getRequestDispatcher("cheatsheets.jsp")
               .forward(request, response);
    }
}