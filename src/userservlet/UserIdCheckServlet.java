package userservlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import user.MemberMgr;

@WebServlet("/UIdCheck")
public class UserIdCheckServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
 
    public UserIdCheckServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		String id = request.getParameter("id");
		String msg = "";
		
		
		MemberMgr mmgr = new MemberMgr();
		boolean result = mmgr.checkId(id);
		
		if (result) {
			msg="yes";
		} else {
			msg="no";
		}
		response.getWriter().write(msg);
	}

}
