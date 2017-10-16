package userservlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import user.MemberMgr;

@WebServlet("/UjoinS")
public class UserjoinServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public UserjoinServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		
        String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		String name = request.getParameter("name");
		String nickname = request.getParameter("nickname");
		String gender = request.getParameter("gender");
		String phon = request.getParameter("phon");
		String email = request.getParameter("email");
		String zipcode = request.getParameter("zipcode");
		String address = request.getParameter("address");
		
		HttpSession session = request.getSession();
		PrintWriter out = response.getWriter();
		
		
		
        if(id != null || !id.equals("") || pw != null || !pw.equals("") 
            || name != null || !name.equals("") || nickname != null || !nickname.equals("") 
            || gender != null || !gender.equals("") || phon != null || !phon.equals("") 
            ||email != null || !email.equals("") || zipcode != null || !zipcode.equals("")
            ||address != null || !address.equals("")){

			boolean result = new MemberMgr().insertMember(id, pw, name, nickname, gender, phon, email, zipcode,
					address);

			//String msg = null;
			if (result) {
				// msg = "true";
				out.println("<script type='text/javascript'>");
				out.println("alert('회원가입 성공 !!!');");
				out.println("location.href = '/proj_01_01/main/main.jsp';");
				out.println("</script>");
				out.flush();
				return;
			} else {
				// msg = "false";
				// out.println("회원가입 실패!!");
				out.println("<script type='text/javascript'>");
				out.println("alert('회원가입 실패ㅠㅠ');");
				out.println("history.back();");
				out.println("</script>");
				out.flush();
				return;
			}
		}
	}
}
