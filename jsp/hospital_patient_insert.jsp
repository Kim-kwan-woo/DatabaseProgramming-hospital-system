<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="java.util.*"%><!DOCTYPE html>
<html>
	<head>
		<title>신규 환자 등록</title>
	</head>
	<body>
	<%@ include file="hospital_top.jsp" %>
    <form name="insert_patient" method="post" action="hospital_patient_insert_verify.jsp">
        <input type="hidden" name="p_doctorid" value="<%=session_id%>">
		<table width="70%" align="center" border>
			<tr>
				<th>환자 아이디</th>
				<td><input type="text" name="p_id" value=""></td>
			</tr>
			<tr>
				<th>환자 이름</th>
				<td><input type="text" name="p_name" value=""></td>
			</tr>
			<tr>
				<th>환자 성별</th>
				<td><input type="text" name="p_sex" value=""></td>
            </tr>
            <tr>
				<th>환자 전화번호</th>
				<td><input type="text" name="p_phone" value=""></td>			
            </tr>
            <tr>
				<th>환자 주소</th>
				<td><input type="text" name="p_address" value=""></td>			
            </tr>
            <tr>
				<th>환자 이메일</th>
				<td><input type="text" name="p_email" value=""></td>			
            </tr>
            <tr>
				<th>입원정보</th>
				<td><input type="text" name="p_hospitalization" value=""></td>			
            </tr>
            <tr>
				<th>담당 간호사 아이디</th>
				<td><input type="text" name="p_nurseid" value=""></td>			
            </tr> 
            <tr>
				<th>최초 진료 기록</th>
				<td><input type="text" name="t_detail" size=50 value=""></td>			
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