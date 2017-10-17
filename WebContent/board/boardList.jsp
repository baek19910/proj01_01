<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../main/top.jsp"%>

<%@page import="board.BoardBean"%>
<%@page import="java.util.Vector"%>

<%    
request.setCharacterEncoding("UTF-8");


int nowPage = (int) request.getAttribute("nowPage");         //현재 페이지 수.
int totalBlock = (int) request.getAttribute("totalBlock");       //최대 페이지 수.
int start = (int) request.getAttribute("start");        //현재 페이지에 표시할 첫 페이지 수.
int end = (int) request.getAttribute("end");       //현재 페이지에 표시할 끝 페이지 수.
int listSize = (int) request.getAttribute("listSize");       //글 수.
int nowBlock = (int) request.getAttribute("nowBlock"); 
int totalPage = (int) request.getAttribute("totalPage"); 
Vector vlistfree = (Vector) request.getAttribute("vlistfree");
int pagePerBlock = (int) request.getAttribute("pagePerBlock");
int numPerPage = (int) request.getAttribute("numPerPage");
String keyWord = (String) request.getAttribute("keyWord");
String keyField = (String) request.getAttribute("keyField");
%>  

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width"  initial-scale="1" >
<link rel="stylesheet" href="/proj_01_02/boot/css/bootstrap.css">
<style type="text/css">
#List_table{
text-align: center;

}
#List_tr th{
text-align: center;
}
#M_title{
text-align: center;
font-size: 40px;
border-bottom: 2px solid purple;
}
</style>
<title>회원목록</title>
</head>

<script src="/proj_01_02/boot/js/bootstrap.js"></script>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script type="text/javascript">

	function pageing(page) {
		document.readFrm.nowPage.value = page;
		document.readFrm.submit();
	}
	
	function block(value){
		 document.readFrm.nowPage.value=<%=pagePerBlock%>*(value-1)+1;
		 document.readFrm.submit();
	} 
	
	function read(no){
		document.readFrm.no.value=no;
		document.readFrm.action="./BoardDetailAction.bo";
		document.readFrm.submit();
	}
	
	function check() {
	     if (document.searchFrm.keyWord.value == "") {
	   alert("검색어를 입력하세요.");
	   document.searchFrm.keyWord.focus();
	   return;
	     }
	  document.searchFrm.submit();
	 }
</script>

<body>
<div class="container" >
<br>
<div class="table-responsive">
<div class="row">
<div class="col-xs-12" id="M_title">자유게시판</div>
</div>
<br><br>
<table class="table table-hover" id="List_table">

<thead id="List_thead">
      <tr id="List_tr">
				<th>번 호</th>
				<th>제 목</th>
				<th>이 름</th>
				<th>날 짜</th>
				<th>조회수</th>
      </tr>
    </thead>
    
    
    <%
                  listSize = vlistfree.size();//브라우저 화면에 보여질 게시물갯수
				  if (vlistfree.isEmpty()) {%>
					  <tr>
						<td colspan="10">등록된 게시물이 없습니다.</td>			
					</tr>
				  <%} else { %>
			
<%
						  for (int i = 0;i<numPerPage; i++) {
							if (i == listSize) break;
							BoardBean B_bean =(BoardBean)vlistfree.get(i);
					
					%>
					
			<tr>
				<td><%=B_bean.getNo()%></td>		
				<td><a href="javascript:read('<%=B_bean.getNo()%>')"><%=B_bean.getSubject()%></a></td>		
				<td><%=B_bean.getName() %></td>
				<td><%=B_bean.getRegdate() %></td>				
				<td><%=B_bean.getIpcount() %></td>
			</tr>

			<% } %>
			<% } %>
</table>
</div>

					
<div class="row">
<div class="col-md-4"></div>
<div class="col-md-4" style="text-align: center;">
					<a href="./board/boardWrite.jsp">[글쓰기]</a> 
					<a href="javascript:list()">[처음으로]</a>
				</div>
<div class="col-md-4" style="text-align: right;">
<%
int pageStart = (nowBlock -1)*pagePerBlock + 1 ; //하단 페이지 시작번호
	  int pageEnd = ((pageStart + pagePerBlock ) < totalPage) ?  (pageStart + pagePerBlock): totalPage+1; 
	  //하단 페이지 끝번호
   				  if(totalPage !=0){
    			  	if (nowBlock > 1) {%>
    			  		<a href="javascript:block('<%=nowBlock-1%>')">prev...</a><%}%>&nbsp; 
    			  		<%for ( ; pageStart < pageEnd; pageStart++){%>
     			     	<a href="javascript:pageing('<%=pageStart %>')"> 
     					<%if(pageStart==nowPage) {%><font color="blue"> <%}%>
     					[<%=pageStart %>] 
     					<%if(pageStart==nowPage) {%></font> <%}%></a> 
    					<%}//for%>&nbsp; 
    					<%if (totalBlock > nowBlock ) {%>
    					<a href="javascript:block('<%=nowBlock+1%>')">.....next</a>
    				<%}%>&nbsp;  
   				<%}%>
</div>
</div>

	<form name="listFrm" method="post">
		<input type="hidden" name="reload" value="true"> 
		<input type="hidden" name="nowPage" value="1">
	</form>
	<form name="readFrm" method="post">
		<input type="hidden" name="no"> <!-- db의 num값을 전달받아 벨류가 없음 -->
		<input type="hidden" name="nowPage" value="<%=nowPage%>"> 
		<input type="hidden" name="keyField" value="<%=keyField%>"> 
		<input type="hidden" name="keyWord" value="<%=keyWord%>">
		<input type="hidden" name="keyWord" value="<%=id%>">
	</form>
</div>
<br><br>
		
<%@ include file="../main/footer.jsp"%>
</body>
</html>