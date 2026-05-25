package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import repository.CheatSheetRepository;

@WebServlet("/PopularCheatSheetsServlet")
public class PopularCheatSheetsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        CheatSheetRepository repo = new CheatSheetRepository();

        request.setAttribute("cheatList", repo.getPopularCheatSheets());

        request.setAttribute("pageTitle", "Popular Cheat Sheets");

        request.setAttribute(
                "pageSubtitle",
                "Top 20 most viewed and downloaded approved public cheat sheets."
        );

        request.getRequestDispatcher("cheatsheets.jsp")
               .forward(request, response);
    }
}