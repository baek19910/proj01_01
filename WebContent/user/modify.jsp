<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"  import="java.util.Vector"%>
<%@ include file="../main/top.jsp"%>
<%@ page import="user.MemberMgr" %>    
<%@ page import="user.MemberBean" %>
<jsp:useBean id="mMgrup" class="user.MemberMgr"/>
 <%
request.setCharacterEncoding("UTF-8");

String idp = (String)session.getAttribute("id");

Vector<MemberBean> M_vlist = mMgrup.getMember(idp);


String M_gender = null;

for (int i = 0; i < M_vlist.size(); i++) {
	MemberBean M_bean = M_vlist.get(i);
		 M_gender = M_bean.getGender();
}

String str = "";
if(M_gender.equals("1")){
	str = "남자";
}else{
	str = "여자";
}
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width"  initial-scale="1" >
<link rel="stylesheet" href="../boot/css/bootstrap.css">
<link rel="stylesheet" href="../boot/css/join.css">
<style type="text/css">
#IdCheck, #pw, #pw2, #name, #nickname,
#phon, #email, #zipcode, #address, #address2 {
  margin-bottom: 7px;
}
form.col-sm-1 .col-sm-2 .col-sm-3 .col-sm-4 .col-sm-5 
.col-sm-6 .col-sm-7 .col-sm-8 .col-sm-9 .col-sm-10 .col-sm-11 .col-sm-12{
  position: relative;
  min-height: 1px;
  padding-left: 15px;
}
.form-control[type="password"]{
	height: 34px;
}/* 회원가입 비밀번호 input높이  */
</style>
<title>회원가입</title>
</head>

<script type="text/javascript" src="script.js"></script> 
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script><!-- 다음 주소 API 링크 -->
<script src="../boot/js/bootstrap.js"></script>

<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script>
jQuery.noConflict();
var js$ = jQuery;

	js$(document)
			.ready(
					function() {//id중복체크 소스 시작
						js$("#IdCheck")
								.click(
										function() {//id중복체크 버튼 누르면

											if (js$("#idjoin").val() == "") {
												alert('ID를 입력해주세요.');
												return false;
											}

											js$
													.ajax({
														type : "POST",
														url : "/proj_01_02/UIdCheck",
														data : {
															"id" : js$(
																	"#idjoin")
																	.val()
														},
														success : function(
																result) {
															if (result == "yes") {
																js$("#message2")
																		.html(
																				"<p style='color:red;font-weight:bold'>사용중인 아이디입니다.</p>");
															} else if (result == "no") {
																js$("#message2")
																		.html(
																				"<p style='color:green'>사용가능한 아이디 입니다.</p>");
															}
														}
													});
										});
					});//id중복체크 소스 끝

	js$(document)
			.ready(
					function() {//닉네임 중복검사 소스
						js$("#nickCheck")
								.click(
										function() {//닉네임 중복체크 버튼 누르면

											if (js$("#nickname").val() == "") {
												alert('닉네임을 입력해주세요.');
												return false;
											}

											js$
													.ajax({
														type : "POST",
														url : "/proj_01_02/UNickCheck",
														data : {
															"nickname" : js$(
																	"#nickname")
																	.val()
														},
														success : function(
																result) {
															if (result == "yes") {
																js$(
																		"#nickmessage")
																		.html(
																				"<p style='color:red;font-weight:bold'>사용중인 닉네임입니다.</p>");
															} else if (result == "no") {
																js$(
																		"#nickmessage")
																		.html(
																				"<p style='color:green'>사용가능한 닉네임 입니다.</p>");
															}
														}
													});
										});
					});//닉네임 중복검사 소스 끝

	function pwCheck() {//비밀번호 일치확인 소스 시작

		var pw = js$('#Upw').val();
		var pw2 = js$('#Upw2').val();

		if (pw != pw2) {
			js$('#pwmessage').html(
					"<p style='color:red'>비밀번호가 서로 일치하지 않습니다.</p>");
		} else {
			js$('#pwmessage').html("<p style='color:green'>비밀번호가 일치합니다.</p>");
		}
	}//비밀번호 일치확인 소스 끝

	function zipcodeCheck() {/*주소찾기 소스 시작  */
		new daum.Postcode(
				{
					oncomplete : function(data) {
						// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

						// 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
						// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
						var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
						alert(fullRoadAddr);
						var extraRoadAddr = ''; // 도로명 조합형 주소 변수

						// 법정동명이 있을 경우 추가한다. (법정리는 제외)
						// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
						if (data.bname !== '' && /[동|로|가]js$/g.test(data.bname)) {
							extraRoadAddr += data.bname;
						}
						// 건물명이 있고, 공동주택일 경우 추가한다.
						if (data.buildingName !== '' && data.apartment === 'Y') {
							extraRoadAddr += (extraRoadAddr !== '' ? ', '
									+ data.buildingName : data.buildingName);
						}
						// 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
						if (extraRoadAddr !== '') {
							extraRoadAddr = ' (' + extraRoadAddr + ')';
						}
						// 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
						if (fullRoadAddr !== '') {
							fullRoadAddr += extraRoadAddr;
						}

						// 우편번호와 주소 정보를 해당 필드에 넣는다.
						document.getElementById('zipcode').value = data.zonecode; //5자리 새우편번호 사용
						document.getElementById('address').value = fullRoadAddr;

						// 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
						if (data.autoRoadAddress) {
							//예상되는 도로명 주소에 조합형 주소를 추가한다.
							var expRoadAddr = data.autoRoadAddress
									+ extraRoadAddr;
							document.getElementById('guide').innerHTML = '(예상 도로명 주소 : '
									+ expRoadAddr + ')';

						} else if (data.autoJibunAddress) {
							var expJibunAddr = data.autoJibunAddress;
							document.getElementById('guide').innerHTML = '(예상 지번 주소 : '
									+ expJibunAddr + ')';

						} else {
							document.getElementById('guide').innerHTML = '';
						}
					}
				}).open();

	}/*주소찾기 소스 끝  */
</script>

<body>
<div class="container">

<form class="form-horizontal" id="modifyform" role="form" method="post" name="regFrm" action="/proj_01_02/UModifyS">
 <fieldset>
                <legend style="text-align: center;">정보수정</legend>
               
<div class="form-group">
    <label class="col-sm-4 control-label" for="input-Id">아이디</label>
    <div class="col-sm-3">
	  <input type="text" id="idjoin" name="id" class="form-control" value="<%= id %>"  readonly="readonly">
	  <div id="message2"></div>
    </div>
    <div class="col-sm-2">
    <input type="button" id="IdCheck" class="btn btn-defalut" value="중복확인" disabled="disabled">
    </div>
  </div>
  
  <div class="form-group">
    <label class="col-sm-4 control-label" for="input-pw">비밀번호</label>
    <div class="col-sm-4">
	  <input type="password" id="Upw" name="pw"  class="form-control" placeholder="비밀번호" >
    </div>
 </div>

  <div class="form-group">
    <label class="col-sm-4 control-label" for="inputp-w2">비밀번호 확인</label>
    <div class="col-sm-4">
	  <input type="password" id="Upw2" name="pw2" onkeyup="pwCheck();" class="form-control" placeholder="비밀번호" >
	<span id="pwmessage"></span>
    </div>
 </div>
 
   <div class="form-group">
    <label class="col-sm-4 control-label" for="input-name">이름</label>
    <div class="col-sm-4">
	  <input type="text" id="name" name="name" class="form-control"  value="<%=name %>" readonly="readonly">
    </div>
 </div>
 
   <div class="form-group">
    <label class="col-sm-4 control-label" for="input-nickname">닉네임</label>
    <div class="col-sm-3">
	  <input type="text" id="nickname" name="nickname" class="form-control"  value="<%= nickname %>">
	  <span id="nickmessage"></span>
    </div>
    <div class="col-sm-2">
    <input type="button" id="nickCheck" class="btn btn-defalut" value="중복확인">
    </div>
 </div>
 
  <div class="form-group">
    <label class="col-sm-4 control-label" for="input-nickname">성별</label>
    <div class="col-sm-4" style="text-align: center;">
	  <div class="btn-group" data-toggle="buttons" >
<label class="btn btn-large active">
<%=str  %>
</label>
</div>
    </div>
 </div>
 
  <div class="form-group">
    <label class="col-sm-4 control-label" for="input-phon">연락처</label>
    <div class="col-sm-4">
	  <input type="number" id="phon" name="phon" class="form-control"  value="<%= phon %>">
    </div>
 </div>

  <div class="form-group">
    <label class="col-sm-4 control-label" for="input-email">E-mail</label>
    <div class="col-sm-4">
	  <input type="text" id="email" name="email" class="form-control"  value="<%= email %>">
    </div>
 </div>

<div class="form-group">
    <label class="col-sm-4 control-label" for="input-zipcode">우편번호</label>
    <div class="col-sm-3">
	  <input type="text" id="zipcode" name="zipcode" class="form-control"  value="<%= zipcode %>">
    </div>
    <div class="col-sm-2">
	  <input type="button" id="zipcode2" name="zipcode2" onclick="zipcodeCheck()" class="btn btn-defalut" value="주소검색">
    </div>
 </div>

 <div class="form-group">
    <label class="col-sm-4 control-label" for="input-address">주소</label>
    <div class="col-sm-4">
	  <input type="text" id="address" name="address" class="form-control"  value="<%= address %>">
    </div>
 </div>
 <input type="hidden"  name="admin" value="<%= S_admin%>">
 
 <div class="form-group">
 <div class="col-sm-5">
	  <input type="hidden" >
    </div>
    <div class="col-sm-1">
	<input type="button" id="modifybtn" name="joinbtn"  onclick="inputCheck()" class="btn btn-defalut" value="정보수정" >
    </div>
    <div class="col-sm-1">
	  <input type="reset" class="btn btn-defalut" value="다시쓰기">

    </div>
 </div>

  </fieldset>
  </form>
  </div>

	<br>


<%@ include file="../main/footer.jsp"%>
</body>
</html>