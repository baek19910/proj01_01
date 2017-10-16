package b_Action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import board.BoardBean;
import board.BoardDAO;
 
public class BoardModifyViewAction implements Action {
     public ActionForward execute(HttpServletRequest request,HttpServletResponse response) throws Exception{
         ActionForward forward = new ActionForward();
         request.setCharacterEncoding("euc-kr");
      
        BoardDAO boarddao=new BoardDAO();
         BoardBean boarddata=new BoardBean();
         
        int num=Integer.parseInt(request.getParameter("num"));
         boarddata=boarddao.getDetail(num);
           
         if(boarddata==null){
             System.out.println("(수정)상세보기 실패");
             return null;
         }
         System.out.println("(수정)상세보기 성공");
           
         request.setAttribute("boarddata", boarddata);
         forward.setRedirect(false);
        forward.setPath("./board/qna_board_modify.jsp");
        return forward;
     }
}