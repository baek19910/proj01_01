<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    
<%@ include file="../main/top.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

    <title>MVC 게시판</title>
    <script language="javascript">
    function addboard(){
    	postFrm.submit();
    }
    </script>
</head>
<body>
	<div align="center">
		<br />
		<br />
		<table width="80%" cellspacing="0" cellpadding="3">
			<tr>
				<td bgcolor="84F399" height="25" align="center">글쓰기</td>
			</tr>
		</table>
		<br />
		<form name="postFrm" method="post" action="/proj_01_02/BoardAddAction.bo" enctype="multipart/form-data" >
			<table width="80%" cellspacing="0" cellpadding="3" align="center">
				<tr>
					<td align=center>
						<table border="0" width="100%" align="center">
							<tr>
								<td width="10%">글쓴이</td>
								<td width="90%"><input type="text" name="name"
									value="<%=nickname %>" size="10" maxlength="8"></td>
							</tr>
							<tr>
								<td width="10%">제 목</td>
								<td width="90%"><input type="text" name="subject" size="50"
									maxlength="30"></td>
							</tr>
							<tr>
								<td width="10%">내 용</td>
								<td width="90%"><textarea name="content" rows="10"
										cols="50"></textarea></td>
							</tr>
							<tr>
								<td width="10%">비밀 번호</td>
								<td width="90%"><input type="password" name="pass"
									size="15" maxlength="15"></td>
							</tr>
							<tr>

								<tr>
     			<td width="10%">파일찾기</td> 
     			<td width="90%"><input type="file" name="filename"
									size="50" maxlength="50"></td>
    		</tr>
 			<tr>
 				<td>내용타입</td>
 				<td> HTML<input type=radio name="contentType" value="HTTP">&nbsp;&nbsp;&nbsp;
  			 	TEXT<input type=radio name="contentType" value="TEXT" checked>
  			 	</td>
 			</tr>
			<tr>
				<td colspan="2"><hr /></td>
			</tr>
			<tr>
				<td colspan="2">
					<a href="javascript:addboard()"><input type="button" value="등록" ></a>
					 <input type="reset" value="다시쓰기">
					 <input type="button" value="리스트"
									onClick="javascript:location.href='list.jsp'">
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<input type="hidden" name="ip" value="<%=request.getRemoteAddr()%>">
<input type="hidden" name="writerid" value="<%=S_id%>">
<input type="hidden" name="nickname" value="<%=nickname%>">
</form>
</div>
<!-- 게시판 등록 -->
<%@ include file="../main/footer.jsp"%>
</body>
</html>