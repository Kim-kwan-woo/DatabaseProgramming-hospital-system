<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head><title>종합병원 관리 시스템</title></head>
<body>
	<%@ include file="hospital_top.jsp" %>
	<table width="100%" align="center" height="100%">
	<% if(session_id != null) { %>
		<tr>
            <br>
            <td align="center"><%=session_name%>님 방문을 환영합니다 (<%=session_job%>)</td>
        </br>
		</tr>	
	<% } else {	%>
		<tr>
            <br>
            <td align="center"> 로그인 정보가 없습니다.</td>
        </br>
		</tr>
	<% } %>
	</table>
</body>
</html>

