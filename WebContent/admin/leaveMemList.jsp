<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="user.DrawBean"%>
<%@ include file="../main/top.jsp" %>
<%    
request.setCharacterEncoding("UTF-8");



Vector<DrawBean> leave_vlist = null;
           leave_vlist = mMgr.mtdWithdraw();	
	 
	 
	 
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
<div class="col-xs-12" id="M_title">탈퇴회원목록</div>
</div>
<br><br>
<table class="table table-hover" id="List_table">
<thead id="List_thead">
      <tr id="List_tr">
                <th>회원ID</th>
				<th>이름</th>
				<th>닉네임</th>
				<th>성별</th>
				<th>e-mail</th>
				<th>주소</th>
				<th>PHON</th>
				<th>가입날짜</th>
				<th>탈퇴날짜</th>
      </tr>
    </thead>
    <% if(leave_vlist.isEmpty()) {%>
			<tr>
				<td colspan="10">회원목록 자료가 없습니다.</td>			
			</tr>
<% } else { %>

			<% 
			for (int i=0; i<leave_vlist.size(); i++) {
			
				DrawBean D_bean = leave_vlist.get(i);
					int no = D_bean.getNo();
					String D_List_id = D_bean.getId();
					String D_List_name = D_bean.getName();
					String D_List_nickname = D_bean.getNickname();
					String D_List_gender = D_bean.getGender();
					String D_List_email = D_bean.getEmail();
					String D_List_zipcode = D_bean.getZipcode();
					String D_List_address = D_bean.getAddress();
					String D_List_phon = D_bean.getPhon();
					String D_List_joinTime = D_bean.getJointime();
					String D_List_Drawtime = D_bean.getDrawtime();
					String D_List_admin = D_bean.getAdmin();
			%>
         <%if (D_List_admin.equals("n")){ %>

			<tr>
				<td><%=D_List_id%></td>	
				<td><%=D_List_name %></td>
				<td><%=D_List_nickname %></td>
				<% String str2 = "";
				if(D_List_gender.equals("1")){
					str2 = "남자";
				}else{
					str2 = "여자";
				 }%>
				<td><%=str2 %></td>
				
				<td><%=D_List_email %></td>
				<td><%=D_List_zipcode %> <%=D_List_address %></td>
				<td><%=D_List_phon %></td>
				<td><%=D_List_joinTime %></td>
					<td><%=D_List_Drawtime %></td>
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