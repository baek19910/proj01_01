package b_Action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import board.BoardBean;
import board.BoardDAO;
 
 
public class BoardDetailAction implements Action {
	
     public ActionForward execute(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	 
      	  request.setCharacterEncoding("UTF-8");
        
        BoardDAO bMgr=new BoardDAO();
         //BoardBean boarddata=new BoardBean();
         HttpSession session = request.getSession();

   	  int num = Integer.parseInt(request.getParameter("no"));
   	  
   	  String nowPage = request.getParameter("nowPage");
   	  String keyField = request.getParameter("keyField");
   	  String keyWord = request.getParameter("keyWord");
   	  
   	    bMgr.upCount(num);//조회수 증가
   	  
   	  
   	  BoardBean bean = bMgr.getBoard(num);//게시물 가져오기
   	  
   	  String name = bean.getName();
   	  String subject = bean.getSubject();
         String regdate = bean.getRegdate();
   	  String content = bean.getContent();
   	  String filename = bean.getFilename();
   	  String V_nickname = bean.getNickname();
   	  int filesize = bean.getFilesize();
   	  String ip = bean.getIp();
   	  int count = bean.getIpcount();
   	  
   	  session.setAttribute("bean", bean);//게시물을 세션에 저장
  
       	request.setAttribute("num", num);
         request.setAttribute("V_name", name);
         request.setAttribute("V_nickname", V_nickname);
         request.setAttribute("subject", subject);
         request.setAttribute("regdate", regdate);
         request.setAttribute("content", content);
         request.setAttribute("filename", filename);
         request.setAttribute("filesize", filesize);
         request.setAttribute("ip", ip);
         request.setAttribute("count", count);
         request.setAttribute("nowPage", nowPage);
         request.setAttribute("keyField", keyField);
         request.setAttribute("keyWord", keyWord);
         
         ActionForward forward = new ActionForward();
         forward.setRedirect(false);
        forward.setPath("./board/boardView.jsp");
        return forward;
 
     }
}
