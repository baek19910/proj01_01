<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
 <%@ include file="../main/top.jsp"%>
 
 
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

<script type="text/javascript" src="script.js"></script> 
<script src="../boot/js/bootstrap.js"></script>
</head>


<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script src="https://spi.maps.daum.net/imap/map_js_init/postcode.v2.js"></script>
<script>
jQuery.noConflict();
var js$ = jQuery;

//---------------------------------------------id중복체크 소스 시작-------------------------------------	
	
	js$(document)	.ready(function() {
						js$("#IdCheck").click(function() {//id중복체크 버튼 누르면

											if (js$("#idjoin").val() == "") {
												alert('ID를 입력해주세요.');
												return false;
											}

											js$.ajax({
														type : "POST",
														url : "/proj_01_01/UIdCheck",
														data : {"id" : js$("#idjoin").val()},
															
														success : function(result) {
															
															if (result == "yes") {
																js$("#message2").html("<p style='color:red;font-weight:bold'>사용중인 아이디입니다.</p>");
															} 
															else if (result == "no") {
																js$("#message2").html("<p style='color:green'>사용가능한 아이디 입니다.</p>");
															}
														}
													});
										});
					});
//--------------------------------------id중복체크 소스 끝---------------------------------------------
					
					
//-------------------------------------닉네임 중복검사 소스---------------------------------------------
	js$(document).ready(function() {
						js$("#nickCheck").click(function() {//닉네임 중복체크 버튼 누르면

											if (js$("#nickname").val() == "") {
												alert('닉네임을 입력해주세요.');
												return false;
											}

											js$.ajax({
														type : "POST",
														url : "/proj_01_01/UNickCheck",
														data : {
															"nickname" : js$("#nickname").val()},
															
														success : function(result) {
															if (result == "yes") {
																js$("#nickmessage").html("<p style='color:red;font-weight:bold'>사용중인 닉네임입니다.</p>");
															} 
															else if (result == "no") {
																js$("#nickmessage").html("<p style='color:green'>사용가능한 닉네임 입니다.</p>");
															}
														}
													});
										});
					});
//---------------------------------------------닉네임 중복검사 소스 끝--------------------------------

//------------------------------------------비밀번호 일치확인 소스 시작------------------------------
	function pwCheck() {
		var pw = js$('#Upw').val();
		var pw2 = js$('#Upw2').val();

		if (pw != pw2) {
			js$('#pwmessage').html(
					"<p style='color:red'>비밀번호가 서로 일치하지 않습니다.</p>");
		} else {
			js$('#pwmessage').html("<p style='color:green'>비밀번호가 일치합니다.</p>");
		}
	}
//----------------------------------------비밀번호 일치확인 소스 끝------------------------------------
	
</script>

<body>
<div class="container">

<form class="form-horizontal" id="joinform" role="form" method="post" name="regFrm" action="/proj_01_01/UjoinS">
 <fieldset>
                <legend style="text-align: center;">회원가입</legend>
               
<div class="form-group">
    <label class="col-sm-4 control-label" for="input-Id">아이디</label>
    <div class="col-sm-3">
	  <input type="text" id="idjoin" name="id" class="form-control" placeholder="아이디">
	  <div id="message2"></div>
    </div>
    <div class="col-sm-2">
    <input type="button" id="IdCheck" class="btn btn-defalut" value="중복확인">
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
	  <input type="password" id="Upw2" name="pw2" onkeyup="pwCheck();" class="form-control">
	<span id="pwmessage"></span>
    </div>
 </div>
 
   <div class="form-group">
    <label class="col-sm-4 control-label" for="input-name">이름</label>
    <div class="col-sm-4">
	  <input type="text" id="name" name="name" class="form-control"  placeholder="이름">
    </div>
 </div>
 
   <div class="form-group">
    <label class="col-sm-4 control-label" for="input-nickname">닉네임</label>
    <div class="col-sm-3">
	  <input type="text" id="nickname" name="nickname" class="form-control" placeholder="닉네임">
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
<input type="radio" id="gender" name="gender" autocomplete="off" value="1" checked="checked">남자
</label>
<label class="btn btn-large">
<input type="radio" id="gender" name="gender" autocomplete="off" value="2">여자
</label>
</div>
    </div>
 </div>
 
  <div class="form-group">
    <label class="col-sm-4 control-label" for="input-phon">연락처</label>
    <div class="col-sm-4">
	  <input type="number" id="phon" name="phon" class="form-control" placeholder="숫자만 입력해주세요.">
    </div>
 </div>

  <div class="form-group">
    <label class="col-sm-4 control-label" for="input-email">E-mail</label>
    <div class="col-sm-4">
	  <input type="email" id="email" name="email" class="form-control" placeholder="email" required="required">
    </div>
 </div>

<div class="form-group">
    <label class="col-sm-4 control-label" for="input-zipcode">우편번호</label>
    <div class="col-sm-3">
	  <input type="text" id="zipcode" name="zipcode" class="form-control" placeholder="우편번호">
    </div>
    <div class="col-sm-2">
	  <input type="button" id="zipcode2" name="zipcode2" onClick="sample4_execDaumPostcode()" class="btn btn-defalut" value="주소검색">
    </div>
 </div>
 
<!-- iOS에서는 position:fixed 버그가 있음, 적용하는 사이트에 맞게 position:absolute 등을 이용하여 top,left값 조정 필요 -->
<div id="layer" style="display:none;position:fixed;overflow:hidden;z-index:1;-webkit-overflow-scrolling:touch;">
<img src="//t1.daumcdn.net/localimg/localimages/07/postcode/320/close.png" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1" onclick="closeDaumPostcode()" alt="닫기 버튼">
</div>

 
 <div class="form-group">
    <label class="col-sm-4 control-label" for="input-address">주소</label>
    <div class="col-sm-4">
	  <input type="text" id="address" name="address" class="form-control" placeholder="주소">
    </div>
 </div>
 
 <script>
//---------------------------------다음 우편번호 검색 API 시작---------------------------------------

 // 우편번호 찾기 화면을 넣을 element
var element_layer = document.getElementById('layer');

function closeDaumPostcode() {
   // iframe을 넣은 element를 안보이게 한다.
   element_layer.style.display = 'none';
}



function sample4_execDaumPostcode(){
// 현재 scroll 위치를 저장해놓는다.
       new daum.Postcode({
           oncomplete: function(data) {
               // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
               

               // 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
               // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
               var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
               var extraRoadAddr = ''; // 도로명 조합형 주소 변수

               // 법정동명이 있을 경우 추가한다. (법정리는 제외)
               // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
               if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                   extraRoadAddr += data.bname;
               }
               // 건물명이 있고, 공동주택일 경우 추가한다.
               if(data.buildingName !== '' && data.apartment === 'Y'){
                  extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
               }
               // 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
               if(extraRoadAddr !== ''){
                   extraRoadAddr = ' (' + extraRoadAddr + ')';
               }
               // 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
               if(fullRoadAddr !== ''){
                   fullRoadAddr += extraRoadAddr;
               }

               // 우편번호와 주소 정보를 해당 필드에 넣는다.
               document.getElementById('zipcode').value = data.zonecode; //5자리 새우편번호 사용
               document.getElementById('address').value = fullRoadAddr;
             //  alert(document.getElementById('address').value);
           
               // 우편번호 찾기 화면이 보이기 이전으로 scroll 위치를 되돌린다.
               element_layer.style.display = 'none';
           },
           width : '100%',
           height : '100%',
           maxSuggestItems : 5
       }).embed(element_layer);

       // iframe을 넣은 element를 보이게 한다.
       element_layer.style.display = 'block';

       // iframe을 넣은 element의 위치를 화면의 가운데로 이동시킨다.
       initLayerPosition();
   }

   // 브라우저의 크기 변경에 따라 레이어를 가운데로 이동시키고자 하실때에는
   // resize이벤트나, orientationchange이벤트를 이용하여 값이 변경될때마다 아래 함수를 실행 시켜 주시거나,
   // 직접 element_layer의 top,left값을 수정해 주시면 됩니다.
   function initLayerPosition(){
       var width = 300; //우편번호서비스가 들어갈 element의 width
       var height = 400; //우편번호서비스가 들어갈 element의 height
       var borderWidth = 5; //샘플에서 사용하는 border의 두께

       // 위에서 선언한 값들을 실제 element에 넣는다.
       element_layer.style.width = width + 'px';
       element_layer.style.height = height + 'px';
       element_layer.style.border = borderWidth + 'px solid';
       // 실행되는 순간의 화면 너비와 높이 값을 가져와서 중앙에 뜰 수 있도록 위치를 계산한다.
       element_layer.style.left = (((window.innerWidth || document.documentElement.clientWidth) - width)/2 - borderWidth) + 'px';
       element_layer.style.top = (((window.innerHeight || document.documentElement.clientHeight) - height)/2 - borderWidth) + 'px';
   } 
//-------------------------------------------------다음 API 소스 끝---------------------------------------------------------------

</script>

	
 <div class="form-group">
 <div class="col-sm-5">
	  <input type="hidden" >
    </div>
    <div class="col-sm-1">
	<input type="button" id="joinbtn" name="joinbtn"  onclick="inputCheck()" class="btn btn-defalut" value="회원가입" >
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