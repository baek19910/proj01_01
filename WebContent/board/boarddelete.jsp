<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../main/top.jsp"%>

<%@page import="board.BoardBean"%>
<%@page import="java.util.Vector"%>

<%    
request.setCharacterEncoding("UTF-8");
	int B_num = Integer.parseInt(request.getParameter("no"));
	 String B_nowPage = request.getParameter("nowPage");
//데이터가 전송이 되면서 문자로 바뀌어 전송이 되기 때문에 받을때 숫자로 파싱해줘야 한다.\\
%>  

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width"  initial-scale="1" >
<link rel="stylesheet" href="/proj_01_01/boot/css/bootstrap.css">
<link rel="stylesheet" href="/proj_01_01/boot/css/deleteform.css">

<title>게시판 삭제</title>
</head>

<script src="/proj_01_01/boot/js/bootstrap.js"></script>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script type="text/javascript">


</script>

<body>
<div class="container">
    	<div class="row">
			<div class="col-md-6 col-md-offset-3">
				<div class="panel panel-login">
					<div class="panel-heading">
						<div class="row">
							<div class="col-xs-12">
								<a href="#" class="active" id="login-form-link">게시판 PW확인</a>
								<%= B_num %>
										<%= B_nowPage %>
							</div>
						</div>
						<hr>
					</div>
					<div class="panel-body">
						<div class="row">
							<div class="col-lg-12">
								<form id="B_delete" action="/proj_01_02/BoardDeleteAction.bo" method="post" role="form" style="display: block;">
									<div class="form-group">
										<input type="password" name="B_pw" id="B_pw" tabindex="2" class="form-control" placeholder="PW">
									</div>
									<input type="hidden" name="B_num" value="<%= B_num %>">
									
									<div class="form-group">
										<div class="row">
										<div class="col-sm-3">
										</div>
											<div class="col-sm-3">
												<input type="submit" name="delete-submit" id="delete-submit"  class="form-control btn btn-login" value="삭제하기">
												
											</div>
												<div class="col-sm-3">
												<input type="submit" name="cancel-submit" id="cancel-submit"  class="form-control btn btn-login" value="취소하기">
											</div>
										</div>
									</div>
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	

		
<%@ include file="../main/footer.jsp"%>
</body>
</html>