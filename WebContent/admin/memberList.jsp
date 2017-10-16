<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../main/top.jsp"%>
<%    
request.setCharacterEncoding("UTF-8");

	 Vector<MemberBean> List_vlist = null;
	 List_vlist = mMgr.mtdList();	 
	 
%>  
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width"  initial-scale="1" >
<link rel="stylesheet" href="../boot/css/bootstrap.css">
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
<title>회원목록</title>
</head>

<script src="../boot/js/bootstrap.js"></script>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>

<body>
<div class="container" >
<br>
<div class="table-responsive">
<div class="row">
<div class="col-xs-12" id="M_title">가입회원목록</div>
</div>
<br><br>
<table class="table table-hover" id="List_table">
<thead id="List_thead">
      <tr id="List_tr">
      <th>회원ID</th>
				<th>PW</th>
				<th>이름</th>
				<th>닉네임</th>
				<th>성별</th>
				<th>e-mail</th>
				<th>주소</th>
				<th>PHON</th>
				<th>가입날짜</th>
      </tr>
    </thead>
    <% if(List_vlist.isEmpty()) {%>
			<tr>
				<td colspan="10">회원목록 자료가 없습니다.</td>			
			</tr>
<% } else { %>

			<% 
			for (int i=0; i<List_vlist.size(); i++) {
			
					MemberBean bean = List_vlist.get(i);
					int no = bean.getNo();
					String List_id = bean.getId();
					String List_pw = bean.getPw();
					String List_name = bean.getName();
					String List_nickname = bean.getNickname();
					String List_gender = bean.getGender();
					String List_email = bean.getEmail();
					String List_zipcode = bean.getZipcode();
					String List_address = bean.getAddress();
					String List_phon = bean.getPhon();
					String List_joinTime = bean.getJointime();
					String List_admin = bean.getAdmin();
			%>
         <%if (List_admin.equals("n")){ %>

			<tr>
				<td><a href="memview.jsp?id=<%=List_id%>"><%=List_id%></a></td>				
				<td><%=List_pw %></td>
				<td><%=List_name %></td>
				<td><%=List_nickname %></td>
				<% String str2 = "";
				if(List_gender.equals("1")){
					str2 = "남자";
				}else{
					str2 = "여자";
				 }%>
				<td><%=str2 %></td>
				
				<td><%=List_email %></td>
				<td><%=List_zipcode %> <%=List_address %></td>
				<td><%=List_phon %></td>
				<td><%=List_joinTime %></td>
			</tr>

			<% } %>
  <% } %>
<% } %>			
    
</table>
</div>
</div>
<br><br>
		
<%@ include file="../main/footer.jsp"%>
</body>
</html>