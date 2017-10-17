<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../main/top.jsp"%> 

 <%@page import="board.BoardBean"%>
<%@page import="java.util.Vector"%>

<jsp:useBean id="B_Mgr" class="board.BoardDAO"></jsp:useBean>

<!DOCTYPE html>
<html  lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width"  initial-scale="1" >
<title>코딩연습</title>
<link rel="stylesheet" href="/proj_01_02/boot/css/bootstrap.css"> 
</head>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="/proj_01_02/boot/js/bootstrap.js"></script>

<script type="text/javascript">
	
	function read(no, nowPage){
		document.readFrm2.no.value=no;
		document.readFrm2.nowPage.value=1;
		document.readFrm2.action="/proj_01_02/BoardDetailAction.bo";
		document.readFrm2.submit();
	}

</script>

<body>

<div class="container">

  <div class="jumbotron">
    <h1 class="text conter">홈페이지를 소개합니다.</h1>
    <p class="text conter">저희 홈페이지에서는 꽃을 소개하고 있습니다.</p>
    <p class="text conter"><a class="btn btn-primary btn-lg" href="#" role="button">꽃 갤러리 게시판 가기</a></p>
  </div>
<div class="row">
<div class="col-md-6" style="margin-left: 20px;">
<div class="row">
<div class="col-md-1"></div>
<div class="col-md-9" style="font-size: 20px; color: olive;">자유게시판</div>
<div class="col-md-2"><a href="/proj_01_02/BoardListAction.bo"><button class="btn btn-default">+더보기</button></a></div>
</div>


<table class="table table-hover" id="List_table">

<thead id="List_thead">
      <tr id="List_tr">
				<th>번 호</th>
				<th>제 목</th>
				<th>이 름</th>
      </tr>
    </thead>
      
    <%
    request.setCharacterEncoding("UTF-8");

	Vector<BoardBean> vlistfree = null;
    vlistfree = B_Mgr.getBoardList2();
	
    for (int i = 0; i < 3; i++) {
		
		BoardBean B_bean =(BoardBean)vlistfree.get(i);
				  if (vlistfree.isEmpty()) {%>
					  <tr>
						<td colspan="10">등록된 게시물이 없습니다.</td>			
					</tr>
				  <%} else { %>
			<tr>
				<td><%=B_bean.getNo()%></td>		
					<td><a href="javascript:read('<%=B_bean.getNo()%>')"><%=B_bean.getSubject()%></a></td>		
				<td><%=B_bean.getName() %></td>
			</tr>
	<% } %>
			<% } %>
</table>
</div>

<div class="col-md-5" style="margin-left: 20px;">
<div class="row">
<div class="col-md-1"></div>
<div class="col-md-9" style="font-size: 20px; color: purple;;">최근가입한회원</div>
</div>
<table class="table table-hover" id="List_table">

<thead id="List_thead">
      <tr id="List_tr">
				<th>닉네임</th>
				<th>가입날짜</th>
      </tr>
    </thead>
<%    
request.setCharacterEncoding("UTF-8");

	 Vector<MemberBean> List_vlist = null;
	 List_vlist = mMgr.mtdList();	 
	 
%>  
<% if(List_vlist.isEmpty()) {%>
			<tr>
				<td colspan="10">회원목록 자료가 없습니다.</td>			
			</tr>
<% } else { %>

			<% 
			for (int i=0; i<3; i++) {
			
					MemberBean bean = List_vlist.get(i);
					String List_nickname = bean.getNickname();
					String List_joinTime = bean.getJointime();
			%>

              
				<tr>
	<td><%=List_nickname%></td>
					<td><%=List_joinTime%></td>
              </tr>
					<% } %>
   <% } %>
</table>

</div>

</div><!--row끝   -->

<form name="readFrm2" method="post">
		<input type="hidden" name="no"> <!-- db의 num값을 전달받아 벨류가 없음 -->
		<input type="hidden" name="nowPage">
	</form>
</div>


<%@ include file="../main/footer.jsp"%> 

</body>
</html>