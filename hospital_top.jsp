<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head><title>Insert title here</title></head>
<body>
	<% 
		String session_id = (String)session.getAttribute("user"); 
		String session_name = (String)session.getAttribute("userName");
		String session_job = (String)session.getAttribute("userJob");
		String log;
  	
		if(session_id==null){
			log="<a href=hospital_login.jsp>로그인</a>";
		} else {
			log="<a href=hospital_logout.jsp>로그아웃</a>";
		}
	%>

	<table width="70%" align="center" bgcolor="#99ffad">
		<tr>
			<td align="center"><b><%=log%></b></td>
			<td align="center"><b><a href="insert.jsp">전체 의사</b></td>
			<td align="center"><b><a href="insert.jsp">전체 간호사</b></td>
            <td align="center"><b><a href="delete.jsp">담당 환자</b></td>
            <td align="center"><b><a href="update.jsp">사용자 정보 수정</b></td>
		</tr>
	</table>
</body>
</html>