package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.CommentBean;
import model.UserBean;
import repository.CommentRepository;

@WebServlet("/AddCommentServlet")
public class AddCommentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request,
	                      HttpServletResponse response)
	        throws ServletException, IOException {

		UserBean user =
				(UserBean) request.getSession().getAttribute("user");

		if(user == null) {

			response.sendRedirect("login.jsp");
			return;
		}

		String content = request.getParameter("content");

		long cheatsheetId =
				Long.parseLong(
						request.getParameter("cheatsheets_id")
				);

		String parentIdStr =
				request.getParameter("parent_comment_id");

		CommentBean comment = new CommentBean();

		comment.setContent(content);

		comment.setUsers_id(user.getId());

		comment.setCheatsheets_id(cheatsheetId);

		if(parentIdStr != null &&
		   !parentIdStr.trim().isEmpty()) {

			comment.setParent_comment_id(
					Long.parseLong(parentIdStr)
			);
		}

		CommentRepository repo =
				new CommentRepository();

		repo.addComment(comment);

		response.sendRedirect(
				request.getContextPath()
				+ "/CheatSheetDetailServlet?id="
				+ cheatsheetId
				+ "#comment-area"
		);
	}
}