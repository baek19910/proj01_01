package boardservlet;

import java.io.IOException;
 
import javax.servlet.RequestDispatcher;
import javax.servlet.Servlet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import b_Action.Action;
import b_Action.ActionForward;
import b_Action.BoardAddAction;
import b_Action.BoardDeleteAction;
import b_Action.BoardDetailAction;
import b_Action.BoardListAction;
import b_Action.BoardModifyAction;
import b_Action.BoardModifyViewAction;
import b_Action.BoardReplayView;
import b_Action.BoardReplyAction;

public class BoardFrontController extends HttpServlet implements Servlet {
	
	 // doGet(), doPost() 메서드 대신 doProcess() 정의
		protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
			
			 // 전체 URL 중에서 포트번호 다음부터의 내용 리턴
	        // http://localhost:8080/MVCBoard/BoardList.bo
	        // => /MVCBoard/BoardList.bo
			String requestURI = request.getRequestURI(); 
			
			// 컨텍스트 경로 리턴
	        // => /MVCBoard
			String contextPath = request.getContextPath();
			
			// requestURI 
			// => /BoardList.bo
			String command = requestURI.substring(contextPath.length());
			
			Action action = null;
			ActionForward forward = null;
			
			 // 잘라낸 command 문자열의 내용 비교(주소 매핑)
			if(command.equals("/BoardWrite.bo")){
				   // 글 작성 페이지(board_write.jsp) 호출
				forward = new ActionForward();
				forward.setRedirect(false);
				forward.setPath("./board/board_write.jsp");
			} else if(command.equals("/BoardAddAction.bo")){
				// BoardAddAction.java 
				action = new BoardAddAction();
				try{
					forward = action.execute(request, response);
				}catch(Exception e){
					e.printStackTrace();
				}
			}else if(command.equals("/BoardListAction.bo")){
				// BoardListAction.java 
				action = new BoardListAction();
				try{
					forward = action.execute(request, response);
				}catch(Exception e){
					e.printStackTrace();
				}
			}else if(command.equals("/BoardDetailAction.bo")){
				// BoardListAction.java 
				action = new BoardDetailAction();
				try{
					forward = action.execute(request, response);
				}catch(Exception e){
					e.printStackTrace();
				}
			}else if(command.equals("/BoardModifyAction.bo")){
				// BoardListAction.java 
				action = new BoardModifyAction();
				try{
					forward = action.execute(request, response);
				}catch(Exception e){
					e.printStackTrace();
				}
			}else if(command.equals("/BoardModifyView.bo")){
				// BoardListAction.java 
				action = new BoardModifyViewAction();
				try{
					forward = action.execute(request, response);
				}catch(Exception e){
					e.printStackTrace();
				}
			}else if(command.equals("/BoardReplyAction.bo")){
				// BoardListAction.java 
				action = new BoardReplyAction();
				try{
					forward = action.execute(request, response);
				}catch(Exception e){
					e.printStackTrace();
				}
			}else if(command.equals("/BoardReplayView.bo")){
				// BoardListAction.java 
				action = new BoardReplayView();
				try{
					forward = action.execute(request, response);
				}catch(Exception e){
					e.printStackTrace();
				}
			}else if(command.equals("/BoardDeleteAction.bo")){
				// BoardListAction.java 
				action = new BoardDeleteAction();
				try{
					forward = action.execute(request, response);
				}catch(Exception e){
					e.printStackTrace();
				}
			}else if(command.equals("/BoardDeleteAction.bo")){
				   // 글 삭제 페이지(board_write.jsp) 호출
				forward = new ActionForward();
				forward.setRedirect(false);
				forward.setPath("./board/board_delete.jsp");
			}
			
			if(forward != null){
				if(forward.isRedirect()){ // true
					response.sendRedirect(forward.getPath()); //  // Redirect 방식 포워딩
				}else{  // false
					// Dispatch 방식 포워딩
					RequestDispatcher dispatcher = request.getRequestDispatcher(forward.getPath());
					dispatcher.forward(request, response);
				}
			}
		}
			
		

		@Override
		protected void doGet(HttpServletRequest request, HttpServletResponse response)
				throws ServletException, IOException {
			doProcess(request, response);
		}

		@Override
		protected void doPost(HttpServletRequest request, HttpServletResponse response)
				throws ServletException, IOException {
			doProcess(request, response);
		}
}
