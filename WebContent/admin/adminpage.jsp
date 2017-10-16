<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ include file="../main/top.jsp"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width"  initial-scale="1" >
<link rel="stylesheet" href="../boot/css/bootstrap.css">
<style type="text/css">
#M_title{
text-align: center;
font-size: 40px;
border-bottom: 2px solid purple;
}
#M_ic{
padding-top: 10px;
text-align: center;
font-size: 30px;

}
strong{color: #ed8e30;}

img {display: block;max-width: 100%; height: auto;}
</style>
<title>관리자페이지</title>
</head>

<script src="../boot/js/bootstrap.js"></script>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>

<body>
<div class="container" id="container_m">


<div class="row">
<div class="col-xs-12" id="M_title">관리자페이지</div>
<hr>
<br>
</div>
<br><br>
<div class="row">
<div class="col-xs-1"></div>
<div class="col-xs-3"><img alt="" src="../images/user_ic.png" style="width: 200px;" class="img-responsive" ></div>
<div class="col-xs-6" id="M_ic"><strong><%= nickname %></strong>님 환영합니다.!!!<br><br>
<a href="../user/modify.jsp"  ><button class="btn btn-default"><img alt="" src="../images/pencil.png" style="width: 90px;" class="img-responsive">
<span><br>정보수정</span></button></a>
<a href="../admin/memberList.jsp"  ><button class="btn btn-default" ><img alt="" src="../images/join_script.png" style="width: 90px;" class="img-responsive">
<span><br>회원목록</span></button></a>
<a href="../admin/leaveMemList.jsp" ><button class="btn btn-default" ><img alt="" src="../images/delete_script.png" style="width: 90px;" class="img-responsive">
<span><br>탈퇴회원목록</span></button></a>
<a href="../user/deleteform.jsp" ><button class="btn btn-default" ><img alt="" src="../images/log-out.png" style="width: 90px;" class="img-responsive">
<span><br>탈퇴</span></button></a>
</div>
</div>
<br><br>

</div>

		
<%@ include file="../main/footer.jsp"%>
</body>
</html>
<!-- 
<td><div class="btn-group" role="group" aria-label="...">
<span class="glyphicon glyphicon-pencil">수정</span></div></td> -->