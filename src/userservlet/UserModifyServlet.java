package userservlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import user.MemberBean;
import user.MemberMgr;

/**
 * Servlet implementation class UserModifyServlet
 */
@WebServlet("/UModifyS")
public class UserModifyServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UserModifyServlet() {
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
		
		
		String admin = request.getParameter("admin");
		   String id = request.getParameter("id");
			String pw = request.getParameter("pw");
			String nickname = request.getParameter("nickname");
			String phon = request.getParameter("phon");
			String email = request.getParameter("email");
			String zipcode = request.getParameter("zipcode");
			String address = request.getParameter("address");
			
			HttpSession session = request.getSession();
			PrintWriter out = response.getWriter();
	
			MemberBean bean = new MemberBean();
			bean.setId(id);
			bean.setPw(pw);
			bean.setNickname(nickname);
			bean.setPhon(phon);
			bean.setEmail(email);
			bean.setZipcode(zipcode);
			bean.setAddress(address);
			
			
		boolean result = new MemberMgr().updateMember(bean);
		if (result) {
			if (admin.equals("n")) {
				out.println("<script type='text/javascript'>");
				out.println("alert('회원수정 성공 !!! ');");
				out.println("location.href = '/proj_01_01/user/mypage.jsp';");
				out.println("</script>");
				out.flush();
				return;
			} else if (admin.equals("y")) {
				out.println("<script type='text/javascript'>");
				out.println("alert('회원수정 성공 !!! ');");
				out.println("location.href = '/proj_01_01/admin/adminpage.jsp';");
				out.println("</script>");
				out.flush();
				return;
			}			
				
	}else{
		out.print("회원가입 실패");
		out.println("<script type='text/javascript'>");
		out.println("alert('회원수정 실패ㅠㅠ');");
		out.println("history.back();");
		out.println("</script>");
		out.flush();
		return;
	}
			 }
	
}
