package b_Action;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import board.BoardBean;
import board.BoardDAO;
 
public class BoardListAction implements Action {
     public ActionForward execute(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	   request.setCharacterEncoding("UTF-8");
    	 
    	 BoardDAO bMgr=new BoardDAO();
    	Vector<BoardBean> vlistfree=new Vector<BoardBean>();
        request.setCharacterEncoding("utf-8");
  	  
        int totalRecord=0; //전체레코드수
  	  int numPerPage=10; // 페이지당 레코드 수 
  	  int pagePerBlock=15;  //블럭당 페이지수 
  	  
  	  int totalPage=0; //전체 페이지 수
  	  int totalBlock=0;  //전체 블럭수 

  	  int nowPage=1; // 현재페이지
  	  int nowBlock=1;  //현재블럭
  	  
  	  int start=0; //디비의 select 시작번호
  	  int end=10; //시작번호로 부터 가져올 select 갯수
  	  
  	  int listSize=0; //현재 읽어온 게시물의 수

  	String keyWord = "", keyField = "";
  	
  	if (request.getParameter("keyWord") != null) {
  		keyWord = request.getParameter("keyWord");
  		keyField = request.getParameter("keyField");
  	}

  	if (request.getParameter("reload") != null){
  		if(request.getParameter("reload").equals("true")) {
  			//keyWord, keyField 찾기 버튼을 눌렀을 때 값을 가진다.
  			keyWord = ""; //찾기할때 검색할 내용 입력하는 곳
  			keyField = ""; // 찾기할 때 필드 선택하는 변수
  		}
  	}
  	
  	if (request.getParameter("nowPage") != null) {
  		nowPage = Integer.parseInt(request.getParameter("nowPage"));
  	}
  	 start=(nowPage * numPerPage)-numPerPage;
  	 end= start+numPerPage;
  	 
  	totalRecord = bMgr.getTotalCount(keyField, keyWord);
  	
  	totalPage =(int)Math.ceil((double)totalRecord / numPerPage);  //전체페이지수
  	nowBlock= (int)Math.ceil((double)nowPage/pagePerBlock); //현재블럭 계산
  	  
  	totalBlock =(int)Math.ceil((double)totalPage / pagePerBlock);  //전체블럭계산
  	
  	vlistfree = bMgr.getBoardList(keyField, keyWord, start, end);
  	

        request.setAttribute("nowPage", nowPage);         //현재 페이지 수.
        request.setAttribute("totalBlock", totalBlock); //최대 페이지 수.
        request.setAttribute("start", start); //현재 페이지에 표시할 첫 페이지 수.
        request.setAttribute("end", end); //현재 페이지에 표시할 끝 페이지 수.
        request.setAttribute("listSize",listSize); //글 수.
        request.setAttribute("nowBlock", nowBlock);
        request.setAttribute("totalPage", totalPage);
        request.setAttribute("vlistfree", vlistfree);
        request.setAttribute("pagePerBlock", pagePerBlock);
        request.setAttribute("numPerPage", numPerPage);
        request.setAttribute("keyWord", keyWord);
        request.setAttribute("keyField", keyField);
        
        ActionForward forward= new ActionForward();
         forward.setRedirect(false);
        forward.setPath("./board/boardList.jsp");
        return forward;
     }
}