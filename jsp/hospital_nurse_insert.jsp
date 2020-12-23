<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="java.util.*, doctorBean.*"%><!DOCTYPE html>
<html>
	<head>
		<title>신입 간호사 등록</title>
	</head>
	<body>
    <%@ include file="hospital_top.jsp" %>
    <jsp:useBean id="doctorMgr" class="doctorBean.DoctorMgr" />
    <%
        String d_id = request.getParameter("d_id");
        int dnumber = doctorMgr.getDnumber(d_id);
        if(doctorMgr.isHeadDoctor(dnumber, d_id) != true){
    %>
    <script>
        alert("해당 부서의 과장 계급 의사만 신규 의사를 등록할 수 있습니다.");
        location.href = "hospital_doctor.jsp";
    </script>

     <% } %>
    <form name="insert_nurse" method="post" action="hospital_nurse_insert_verify.jsp">
		<table width="70%" align="center" border>
			<tr>
				<th>간호사 아이디</th>
				<td><input type="text" name="n_id" value=""></td>
			</tr>
			<tr>
				<th>간호사 이름</th>
				<td><input type="text" name="n_name" value=""></td>
			</tr>
			<tr>
				<th>간호사 성별</th>
				<td><input type="text" name="n_sex" value=""></td>
            </tr>
            <tr>
				<th>간호사 전화번호</th>
				<td><input type="text" name="n_phone" value=""></td>			
            </tr>
            <tr>
				<th>간호사 이메일</th>
				<td><input type="text" name="n_email" value=""></td>			
            </tr>
            <tr>
				<th>비밀번호</th>
				<td><input type="password" name="n_password" value=""></td>			
            </tr>    
            <tr>
				<th>등록 부서 번호</th>
				<td><%=dnumber%><input type="hidden" name="n_dnum" value="<%=dnumber%>"></td>			
            </tr>
            <tr>
				<td colspan="2" align="center">
					<input type="submit" value="등록">
				</td> 
			</tr>
		</table>
        </form>
    </body>
</html> 