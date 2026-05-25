package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import repository.CheatSheetRepository;

@WebServlet("/SearchByTagServlet")
public class SearchByTagServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        String keyword = request.getParameter("keyword");

        if (keyword == null || keyword.trim().isEmpty()) {
            response.sendRedirect("CheatSheetListServlet");
            return;
        }

        keyword = keyword.trim().toLowerCase();

        CheatSheetRepository repo = new CheatSheetRepository();

        request.setAttribute(
                "cheatList",
                repo.searchPublicCheatSheetsByTagPrefix(keyword)
        );

        request.setAttribute(
                "pageTitle",
                "Search results for #" + keyword
        );

        request.setAttribute(
                "pageSubtitle",
                "Showing approved public cheat sheets with tags starting with \"" + keyword + "\"."
        );

        request.getRequestDispatcher("cheatsheets.jsp")
               .forward(request, response);
    }
}