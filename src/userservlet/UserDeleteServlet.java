package userservlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Vector;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import user.MemberBean;
import user.MemberMgr;

/**
 * Servlet implementation class UserLogoutServlet
 */
@WebServlet("/UDeleteS")
public class UserDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UserDeleteServlet() {
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
		
	    String id = request.getParameter("Oid");
	    String pw = request.getParameter("Opw");
	    
	    HttpSession session = request.getSession();
	  
	    
		String id2 = (String) session.getAttribute("id");
		 String pw2 =  (String) session.getAttribute("pw");

		// 세션에서 아이디를, DeleteForm.jsp에서 입력받은 비밀번호를 가져온다.
		// 가져온 결과를 가지고 회원정보를 삭제한다. - 삭제결과를 반환
		  PrintWriter out = response.getWriter();
		  
		  
		if(id.equals(id2) &&pw.equals(pw2)){
		
		
			
		boolean result = new MemberMgr().mtdOut(id2);
		
		if (result) {
			
			session.invalidate();
			out.println("<script type='text/javascript'>");
      	  out.println("alert('회원탈퇴 성공 !!!');");
      	  out.println("location.href = '/proj_01_01/main/main.jsp';");
      	  out.println("</script>");
      	  out.flush();
      	     return;
			
			
		} else {
	
		out.println("<script type='text/javascript'>");
      	  out.println("alert('회원탈퇴 실패 !!!');");
      	  out.println("history.back();");
      	  out.println("</script>");
      	  out.flush();
      	     return;
		
		}
		}
		}

}
