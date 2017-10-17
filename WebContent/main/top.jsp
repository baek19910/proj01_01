<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"  import="java.util.Vector"%>
<%@ page import="user.MemberMgr" %>    
<%@ page import="user.MemberBean" %>

<jsp:useBean id="mMgr" class="user.MemberMgr"/>

 <%
request.setCharacterEncoding("UTF-8");
//-----------세션에 저장된 값 가져오기-----------------------------
	String S_id = (String) session.getAttribute("id");
	String S_pw = (String) session.getAttribute("pw");
	String S_nickname = (String) session.getAttribute("nickname");
	String S_admin = (String) session.getAttribute("admin"); 
//-----------세션에 저장된 값 가져오기 끝-----------------------------

//-----------MemberBean에 있는 데이터 세션id로 조회 후 변수에 저장----------------
Vector<MemberBean> vlist = mMgr.getMember(S_id);

String id = null;
String name = null;
String nickname = null;
String email  = null;
String zipcode  = null;
String address  = null;
String phon  = null;
String gender = null;

for (int i = 0; i < vlist.size(); i++) {
	MemberBean M_bean = vlist.get(i);
		 id = M_bean.getId();
		 name = M_bean.getName();
		 nickname = M_bean.getNickname();
		 gender = M_bean.getGender();
		 email  = M_bean.getEmail();
		 zipcode  = M_bean.getZipcode();
		 address  = M_bean.getAddress(); 
		 phon  = M_bean.getPhon();
}
//-----------MemberBean에 있는 데이터 세션id로 조회 후 변수에 저장 끝----------------
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width"  initial-scale="1" >
<title>코딩연습</title>

<link rel="stylesheet" href="/proj_01_02/boot/css/bootstrap.css">
<link rel="stylesheet" href="/proj_01_02/boot/css/top.css">
<link rel="stylesheet" href="/proj_01_02/boot/css/login.css">
<style>
#logout{
margin-top: 15px;
padding: 0px;
}
</style>
</head>
<body>

<script src="/proj_01_02/boot/js/jquery-3.2.1.min.js"></script>
<script src="/proj_01_02/boot/js/bootstrap.js"></script>

<script type="text/javascript">
//------------로그인 부트스트랩 모달창 띄우는 소스 -----------------------
$(document).ready(function(){
    $("#mylogin").click(function(){
        $("#myModal").modal();
    });
}); 
//------------로그인 부트스트랩 모달창 띄우는 소스 끝-----------------------	
</script>

<!-- ---------------------             비회원에게 보여지는 네비 부분  시작          -------------------------->	

<% if(S_id == null) {%><!-- 세션에 id값이 없다면 실행 -->
<nav class="navbar navbar-default" role="navigation">
	  <div class="container-fluid">
	  
	    <div class="navbar-header">
	      <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar-collapse-1" aria-expanded="false">
		<span class="sr-only"></span>
		<span class="icon-bar"></span>
		<span class="icon-bar"></span>
		<span class="icon-bar"></span>
	      </button>
	      <a class="navbar-brand" href="/proj_01_02/main/main.jsp">B.gahui</a>
	    </div>
	     <div class="navbar-collapse collapse" id="navbar-collapse-1">
	      <ul class="nav navbar-nav">
		<li class="active"><a href="#">Main<span class="sr-only">(current)</span></a></li>
		<li><a href="#">개발자 소개</a></li>
		<li class="dropdown">
		  <a href="#" class="dropdown-toggle" data-toggle="dropdown" 
		  role="button" aria-expanded="false" aria-haspopup="true">게시판 <span class="caret"></span></a>
		  
		  <ul class="dropdown-menu" role="menu">
		    <li><a href="#">공지사항</a></li>
		    <li><a href="/proj_01_02/BoardListAction.bo">자유게시판</a></li>
		    <li><a href="#">갤러리게시판</a></li>
		  </ul>
		</li>
	      </ul>
	      <form class="navbar-form navbar-left" role="search">
		<div class="form-group">
		  <input type="text" class="form-control" placeholder="내용을 입력하세요.">
		</div>
		<button type="submit" class="btn btn-default">Submit</button>
	      </form>
	      
	      
	       <ul class="nav navbar-nav navbar-right">
		<li class="dropdown">
		  <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">접속하기 <span class="caret"></span></a>
		  <ul class="dropdown-menu" role="menu">
		    <li><a id="mylogin" data-toggle="modal">로그인</a></li>
		    <li><a href="/proj_01_02/user/member.jsp">회원가입</a></li>
		  </ul>
		</li>
	      </ul>
	    </div><!-- /.navbar-collapse -->
	  </div><!-- /.container-fluid -->
	</nav>
	<%} //------------------------------------------비회원에게 보여지는 네비 부분  끝 -------------------------------------------

//-------------------------------------------- 회원 & 관리자 권한 주기 시작  ---------------------------------------
else if(S_id != null){%><!-- 세션에 id값이 있으면 실행 -->

       <nav class="navbar navbar-default" role="navigation">
	  <div class="container-fluid">
	  
	    <div class="navbar-header">
	      <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar-collapse-1" aria-expanded="false">
		<span class="sr-only"></span>
		<span class="icon-bar"></span>
		<span class="icon-bar"></span>
		<span class="icon-bar"></span>
	      </button>
	      <a class="navbar-brand" href="/proj_01_02/main/main.jsp">B.gahui</a>
	    </div>
	     <div class="navbar-collapse collapse" id="navbar-collapse-1">
	      <ul class="nav navbar-nav">
		<li class="active"><a href="#">Main<span class="sr-only">(current)</span></a></li>
		<li><a href="#">개발자 소개</a></li>
		<li class="dropdown">
		  <a href="#" class="dropdown-toggle" data-toggle="dropdown" 
		  role="button" aria-expanded="false" aria-haspopup="true">게시판 <span class="caret"></span></a>
		  
		  <ul class="dropdown-menu" role="menu">
		    <li><a href="#">공지사항</a></li>
		    <li><a href="/proj_01_02/BoardListAction.bo">자유게시판</a></li>
		    <li><a href="#">갤러리게시판</a></li>
		  </ul>
		</li>
	      </ul>
	      <form class="navbar-form navbar-left" role="search">
		<div class="form-group">
		  <input type="text" class="form-control" placeholder="내용을 입력하세요.">
		</div>
		<button type="submit" class="btn btn-default">Submit</button>
	      </form>
	   
	  <% if(S_admin.equals("n")) {%><!-- 일반회원에게 보여지는 네비부분 -->
	       <ul class="nav navbar-nav navbar-right">
	         <li class="navbar-text">
	       <%=nickname %>님 환영합니다.
            </li>
		<li style="text-align: center;">
		<form action="/proj_01_02/ULogoutS" method="post">
		<input type="hidden" name="L_id" value=<%= S_id %>>
		<input type="hidden" name="L_id" value=<%= S_pw %>>
		<button  type="submit" class="btn btn-link"  id="logout">로그아웃</button>
		</form>
		</li>
		<li>
		<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">메뉴 <span class="caret"></span></a>
		  <ul class="dropdown-menu" role="menu">
		    <li><a href="/proj_01_02/user/mypage.jsp">마이페이지</a></li>
		  </ul>
		</li>
	      </ul>
	     
<%}//------------- 일반회원에게 보여지는 네비부분 끝 -----------------
	  
//-------------------- 관리자에게 보여지는 네비부분 ---------------------
	  else if(S_admin.equals("y")) {%>

	       <ul class="nav navbar-nav navbar-right">
	         <li class="navbar-text">
	       <%=nickname %>님 환영합니다.
            </li>
		<li style="text-align: center;">
		<form action="/proj_01_02/ULogoutS" method="post">
		<input type="hidden" name="L_id" value=<%= S_id %>>
		<input type="hidden" name="L_id" value=<%= S_pw %>>
		<button  type="submit" class="btn btn-link"  id="logout">로그아웃</button>
		</form>
		</li>
		<li>
		<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">메뉴 <span class="caret"></span></a>
		  <ul class="dropdown-menu" role="menu">
		    <li><a href="/proj_01_02/admin/adminpage.jsp">관리자페이지</a></li>
		  </ul>
		</li>
	      </ul>
	     
<%}//--------------------관리자에게 보여지는 네비부분 끝--------------------- %>

	    </div><!-- /.navbar-collapse -->
	  </div><!-- /.container-fluid -->
	</nav>
<%}//--------------------------- 회원 & 관리자 권한 주기 끝  --------------------------- %>	

<!------------------------------------- 부트스트랩 모달창 소스 시작   ------------------------------------>

<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
  
    <div class="loginmodal-container">

    <script type="text/javascript">
    
//---------로그인시 성공여부 실시간 안내멘트로 띄우는 소스(ajax이용함)-------------------    

    $(document).ready(function() {
	$("#login").click(function() {//로그인버튼 누르면
	
		$.ajax({
			type: "POST",
			url: "/proj_01_02/ULogin",
			data: {
				"id" : $("#id").val(),
				"pw": $("#pw").val()
			},
			success: function(data) {
				if(data == "yes") {
					$("#message").html("<p style='color:green;font-weight:bold'>로그인 성공!</p>");
					var url = "/proj_01_02/main/main.jsp"; 
					$(location).attr('href',url);
				}
				else if(data == "no"){
					$("#message").html("<p style='color:red'>아이디 또는 비밀번호가 잘못되었습니다.</p>");	
				}
				else if(data == "idno"){
					$("#message").html("<p style='color:blue'>아이디를 입력해주세요.</p>");	
				}
				else if(data == "pwno"){
					$("#message").html("<p style='color:blue'>비밀번호를 입력해주세요.</p>");	
				}
			}
		});
	});
});
//---------로그인시 성공여부 실시간 안내멘트로 띄우는 소스(ajax이용함) 끝------------
    </script>
	<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
					</button>
					<h1>로그인</h1><br>
				  <form  id="loginFrm" name="loginFrm" method="post">
					<input type="text" id="id" value=""  placeholder="ID">
					<input type="password" id="pw" value=""  placeholder="Password">
					<input type="button"  id ="login" class="login loginmodal-button" value="로그인">
				  </form>
				  <br>
				  <div id="message"></div>
			</div>
  	</div>
  </div>
  
  <!------------------------------------------  부트스트랩 모달창 소스 끝   ----------------------------------------------->

</body>
</html>