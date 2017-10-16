<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../main/top.jsp"%>
    <%@page import="board.BoardBean"%>
<%
request.setCharacterEncoding("UTF-8");
int num = (int) request.getAttribute("num");
String V_name = (String) request.getAttribute("V_name");
String V_nickname = (String) request.getAttribute("V_nickname");
String subject = (String) request.getAttribute("subject");
String regdate = (String) request.getAttribute("regdate");
String content = (String) request.getAttribute("content");
String filename = (String) request.getAttribute("filename");
int filesize = (int) request.getAttribute("filesize");
String ip = (String) request.getAttribute("ip");
int count = (int) request.getAttribute("count");
String nowPage = (String) request.getAttribute("nowPage");
String keyField = (String) request.getAttribute("keyField");
String keyWord = (String) request.getAttribute("keyWord");
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width"  initial-scale="1" >
<link rel="stylesheet" href="/proj_01_01/boot/css/bootstrap.css">
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
<title>글읽기</title>
</head>

<script src="/proj_01_01/boot/js/bootstrap.js"></script>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
	function list(){
	 	document.listFrm.action="/proj_01_01/BoardListAction.bo";
	    document.listFrm.submit();
	 } 
	
	function down(filename){
		 document.downFrm.filename.value=filename;
		 document.downFrm.submit();
	}
	
	// 댓글 등록
	function writeCmt()
	{
		var form = document.getElementById("writeCommentForm");
		
		var board = form.comment_board.value
		var id = form.comment_id.value
		var content = form.comment_content.value;
		
		if(!content)
		{
			alert("내용을 입력하세요.");
			return false;
		}
		else
		{	
			var param="comment_board="+board+"&comment_id="+id+"&comment_content="+content;
				
			httpRequest = getXMLHttpRequest();
			httpRequest.onreadystatechange = checkFunc;
			httpRequest.open("POST", "CommentWriteAction.co", true);	
			httpRequest.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded;charset=UTF-8'); 
			httpRequest.send(param);
		}
	}
	
</script>


<body>
<div class="container" >
<br>
<div class="table-responsive" id="table-responsive">
<div class="row">
<div class="col-xs-12" id="M_title">글읽기</div>
</div>
<br><br>
<table class="table" id="List_table">
<tr>
<td >제목</td>
<td colspan="5" ><%=subject%></td>
</tr>

<tr>
<td>글쓴이</td>
<td colspan="2"><%=V_nickname%></td>
<td>작성일</td>
<td colspan="2"><%=regdate%></td>
</tr>
<tr>
<td>첨부파일</td>
<% if( filename !=null && !filename.equals("")) {%>
  		<td colspan="5"><a href="javascript:down('<%=filename%>')"><%=filename%></a>
  		 &nbsp;&nbsp;<font color="blue">(<%=filesize%>KBytes)</font></td>
  		 <%} else{%> <td colspan="5">등록된 파일이 없습니다.</td><%}%>
</tr>
 <tr> 
    <td colspan="6"><%=content%></td>
   </tr>
  <tr>
  <td colspan="6" style="text-align: right;">조회수  <%=count%></td>
   </tr>
   
</table>
</div>
<br><br>
<%if( S_id != null){ %>
<div class="row">
<div class=".col-md-4" ></div>
<div class=".col-md-4" style="text-align: center;"> [ <a href="javascript:list()" >리스트</a> | 
 <a href="update.jsp?nowPage=<%=nowPage%>&no=<%=num%>" >수 정</a> |
 <a href="reply.jsp?nowPage=<%=nowPage%>&no=<%=num%>">답 변</a> |
 <a href="/proj_01_01/board/boarddelete.jsp?nowPage=<%=nowPage%>&no=<%=num%>">삭 제</a> ]<br>
 </div>
<div class=".col-md-4"></div>
</div>
<%}else{ %>
<div class="row">
<div class="col-md-4"></div>
<div class="col-md-4"  style="text-align: center;"><a href="javascript:list()" >리스트</a><br>
 </div>
<div class="col-md-4"></div>
</div>


<%} %>
</div>

<br>
 	
<form name="downFrm" action="download.jsp" method="post">
	<input type="hidden" name="filename">
</form>
<form name="listFrm" method="post">
	<input type="hidden" name="nowPage" value="<%=nowPage%>">
	<%if(!(keyWord==null || keyWord.equals("null"))){ %>
	<input type="hidden" name="keyField" value="<%=keyField%>">
	<input type="hidden" name="keyWord" value="<%=keyWord%>">
	<%}%>
</form>

<%@ include file="../main/footer.jsp"%>
</body>
</html>