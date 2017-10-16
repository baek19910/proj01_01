
function inputCheck(){
    
	
	if(document.regFrm.id.value==""){
		alert("아이디를 입력해 주세요.");
		document.regFrm.id.focus();
		return;
	}
	 for (i = 0; i < document.regFrm.id.value.length; i++) {
         ch = document.regFrm.id.value.charAt(i)
         if (!(ch >= '0' && ch <= '9') && !(ch >= 'a' && ch <= 'z')&&!(ch >= 'A' && ch <= 'Z')) {
             alert("아이디는 대소문자, 숫자만 입력가능합니다.")
             document.regFrm.id.focus()
             return false;
         }
	 }
     //아이디에 공백 사용하지 않기
     if (document.regFrm.id.value.indexOf(" ") >= 0) {
         alert("아이디에 공백을 사용할 수 없습니다.")
         document.regFrm.id.focus()
         return false;
     }
  /*   //아이디 길이 체크 (4~12자)
     if (document.regFrm.id.value.length<4 || document.regFrm.id.value.length>12) {
         alert("아이디를 4~12자까지 입력해주세요.")
         document.regFrm.id.focus()
         return false;
     }*/
	if(document.regFrm.pw.value==""){
		alert("비밀번호를 입력해 주세요.");
		document.regFrm.pw.focus();
		return;
	}
	   //비밀번호 길이 체크(4~8자 까지 허용)
    if (document.regFrm.pw.value.length<4 || document.regFrm.pw.value.length>12) {
        alert("비밀번호를 4~12자까지 입력해주세요.")
        document.regFrm.pw.focus()
        return false;
    }
	if(document.regFrm.pw.value != document.regFrm.pw2.value){
		alert("비밀번호가 일치하지 않습니다.");
		document.regFrm.pw2.value="";
		document.regFrm.pw2.focus();
		return;
	}
	if(document.regFrm.name.value==""){
		alert("이름을 입력해 주세요.");
		document.regFrm.name.focus();
		return;
	}
	  if(document.regFrm.name.value.length<2){
          alert("이름을 2자 이상 입력해주십시오.")
          document.regFrm.name.focus()
          return false;
      }
	if(document.regFrm.nickname.value==""){
		alert("닉네임을 입력해 주세요");
		document.regFrm.nickname.focus();
		return;
	}
	if(document.regFrm.phon.value==""){
		alert("번호를 입력해 주세요.");
		document.regFrm.phon.focus();
		return;
	}
	var email = document.getElementById("email").value;
	var exptext = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/;
	
	if(document.regFrm.email.value==""){
		alert("이메일을 입력해 주세요.");
		document.regFrm.email.focus();
		return;
	}else if(exptext.test(email) == false){
	
		//이메일 형식이 알파벳+숫자@알파벳+숫자.알파벳+숫자 형식이 아닐경우			
		alert("이 메일형식이 올바르지 않습니다.");
		document.regFrm.email.focus();
		return false;
	
	}
	/*
	 if (regex.test(email) === false) {
         alert("잘못된 이메일 형식입니다.");
         document.regFrm.email.value=""
         document.regFrm.email.focus()
         return false;
     }*/
	/*
    var str=document.regFrm.email.value;	   
    var atPos = str.indexOf('@');
    var atLastPos = str.lastIndexOf('@');
    var dotPos = str.indexOf('.'); 
    var spacePos = str.indexOf(' ');
    var commaPos = str.indexOf(',');
    var eMailSize = str.length;
    var regex = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;
    
    if (atPos > 1 && atPos == atLastPos && 
	   dotPos > 3 && spacePos == -1 && commaPos == -1 
	   && atPos + 1 < dotPos && dotPos + 1 < eMailSize);
    else {
          alert('E-mail주소 형식이 잘못되었습니다.\n\r다시 입력해 주세요!');
	      document.regFrm.email.focus();
		  return;
    }*/
    if(document.regFrm.zipcode.value==""){
		alert("우편번호를 검색해 주세요.");
		return;
	}
	document.regFrm.submit();
}

function win_close(){
	self.close();
}
