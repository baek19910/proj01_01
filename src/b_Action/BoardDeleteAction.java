package b_Action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import board.BoardBean;
import board.BoardDAO;
 
public class BoardDeleteAction implements Action {
     public ActionForward execute(HttpServletRequest request,HttpServletResponse response)
         throws Exception{
        
        ActionForward forward = new ActionForward();
        request.setCharacterEncoding("UTF-8");
          
        String nowPage = request.getParameter("B_nowPage");
    	int num = Integer.parseInt(request.getParameter("B_num"));
    	String pass =request.getParameter("B_pw");
    	
    	
    	if (pass != null) {
    		//비번을 입력을 해서 세션에 있는 pass 비교요청
    		
    		 BoardDAO bMgr=new BoardDAO();
    	   	  BoardBean bean = bMgr.getBoard(num);//게시물 가져오기
    	   	  
    		String dbPass = bean.getPass();
    		if (pass.equals(dbPass)) {
    			bMgr.deleteBoard(num);
    			  response.setContentType("text/html;charset=UTF-8");
    	             PrintWriter out=response.getWriter();
    	             out.println("<script>");
    	             out.println("alert('삭제가 완료 되었습니다.');");
    	             out.println("location.href='./BoardListAction.bo';");
    	             out.println("</script>");
    	             out.close();
    			//String url = "./BoardListAction.bo?nowPage=" + nowPage;//이게 멀까?? ㅠㅠ
    			//response.sendRedirect(url);
    		} else {
             response.setContentType("text/html;charset=UTF-8");
             PrintWriter out=response.getWriter();
             out.println("<script>");
             out.println("alert('삭제할 권한이 없습니다.');");
             out.println("location.href='./BoardListAction.bo';");
             out.println("</script>");
             out.close();
             return null;
         }
           
             System.out.println("게시판 삭제 실패");
             return null;
         }
           
         System.out.println("게시판 삭제 성공");
         forward.setRedirect(true);
        forward.setPath("./BoardListAction.bo");
        return forward;
     }
}