package userservlet;

import java.io.IOException;
import java.util.Vector;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import user.MemberBean;
import user.MemberMgr;


@WebServlet("/ULogin")
public class UserLoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
  
	
    public UserLoginServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		String msg = "";
		MemberMgr mmgr = new MemberMgr();
		
		
		 if(id==null || id.equals("")){
	    	 
	    	 
			 msg = "idno";
	    	 
	    	 
	    	 
	     }else if( pw==null || pw.equals("")){
	    	 
	    	 msg = "pwno";
	    	 
	     }else if(id!=null || !id.equals("")||pw!=null || !pw.equals("")){
		
		Vector<MemberBean> vlist2 = mmgr.getMember(id);
		  String id2 = null;
		  String pw2 = null;
		  String name2 = null;
		  String admin2  = null;
		  String nickname2 = null;
		  
		  for (int i = 0; i < vlist2.size(); i++) {
		  	MemberBean bean = vlist2.get(i);
		  	id2 = bean.getId();
		  	pw2 = bean.getPw();
		  	name2 = bean.getName();
		  	nickname2 = bean.getNickname();
		  	admin2  = bean.getAdmin();
		  }
    
		  if(id.equals(id2) &&pw.equals(pw2)){
			  
			  HttpSession session = request.getSession();
			  
		   session.setAttribute("id", id2);
		   session.setAttribute("pw", pw2);
		   session.setAttribute("name", name2);
		   session.setAttribute("nickname", nickname2);
		   session.setAttribute("admin", admin2);
		  msg= "yes";
		  }else{
			  msg = "no";
		  }

		
	}
		 response.getWriter().write(msg);
	}
}
