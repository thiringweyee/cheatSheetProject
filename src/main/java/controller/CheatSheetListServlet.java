package controller;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import repository.CheatSheetRepository;

@WebServlet("/CheatSheetListServlet")
public class CheatSheetListServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setAttribute("cheatList", new CheatSheetRepository().getPublicCheatSheets());
        request.getRequestDispatcher("cheatsheets.jsp").forward(request, response);
    }
}