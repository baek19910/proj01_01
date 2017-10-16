<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
 <%@ include file="../main/top.jsp"%>
 
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width"  initial-scale="1" >
<link rel="stylesheet" href="/proj_01_01/boot/css/bootstrap.css">
<link rel="stylesheet" href="/proj_01_01/boot/css/deleteform.css">

<title>회원가입</title>
</head> 
<script src="/proj_01_01/boot/js/bootstrap.js"></script>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<body>

<div class="container">
    	<div class="row">
			<div class="col-md-6 col-md-offset-3">
				<div class="panel panel-login">
					<div class="panel-heading">
						<div class="row">
							<div class="col-xs-12">
								<a href="#" class="active" id="login-form-link">ID,PW확인</a>
							</div>
						</div>
						<hr>
					</div>
					<div class="panel-body">
						<div class="row">
							<div class="col-lg-12">
								<form id="login-form" action="/proj_01_01/UDeleteS" method="post" role="form" style="display: block;">
									<div class="form-group">
										<input type="text" name="Oid" id="Oid" tabindex="1" class="form-control" placeholder="ID" value="">
									</div>
									<div class="form-group">
										<input type="password" name="Opw" id="Opw" tabindex="2" class="form-control" placeholder="PW">
									</div>
									<input type="hidden" name="L_id" value=<%= S_id %>>
									<input type="hidden" name="L_pw" value=<%= S_pw %>>
									<div class="form-group">
										<div class="row">
											<div class="col-sm-6 col-sm-offset-3">
												<input type="submit" name="login-submit" id="login-submit" tabindex="4" class="form-control btn btn-login" value="탈퇴하기">
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


</body>

<%@ include file="../main/footer.jsp"%>
</body>
</html>