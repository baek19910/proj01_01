package userservlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class UserLogoutServlet
 */
@WebServlet("/ULogoutS")
public class UserLogoutServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UserLogoutServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		
		HttpSession session = request.getSession();
		PrintWriter out = response.getWriter();
		
		String id = (String) session.getAttribute("id");
		
		
		if (!id.equals("") && id != null) {
			session.invalidate();

			out.println("<script type='text/javascript'>");
			out.println("alert('로그아웃 되었습니다.');");
			out.println("location.href = '/proj_01_01/main/main.jsp';");
			out.println("</script>");
			out.flush();

			return;
		} else {
			out.println("<script type='text/javascript'>");
			out.println("alert('로그아웃 실패.');");
			out.println("location.href = '/proj_01_01/main/main.jsp';");
			out.println("</script>");
			out.flush();

			return;
		}
	}

}
