package b_Action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import board.BoardBean;
import board.BoardDAO;
 
 
public class BoardAddAction implements Action {
     public ActionForward execute(HttpServletRequest request,HttpServletResponse response) throws Exception{
        
    	 BoardDAO bMgr=new BoardDAO();
         BoardBean boarddata=new BoardBean();
         ActionForward forward=new ActionForward();
         
   	  bMgr.insertBoard(request);
             
             forward.setRedirect(true);
             forward.setPath("./BoardListAction.bo");
             return forward;
             
    }     
}