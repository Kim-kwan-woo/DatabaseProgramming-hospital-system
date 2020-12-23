<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="java.util.*, doctorBean.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>전체 의사 조회</title>
</head>
<body>
	<%@ include file="hospital_top.jsp"%>
	<%
		if (session_id == null)
			response.sendRedirect("hospital_login.jsp");

		if(session_job == "doctor"){
	%>
			<h4 align="center"><a href="hospital_doctor_insert.jsp?d_id=<%=session_id%>">신입 의사 등록</a></h4>
	<% } %>
    <jsp:useBean id="doctorMgr" class="doctorBean.DoctorMgr" />
    <%
        int maxDnum = doctorMgr.getMaxDnum();
        for(int i = 0; i < maxDnum; i++){
            int currentDnum =  i+1;
            String currentDname = doctorMgr.getDname(currentDnum);
    %>
	<table width="70%" align="center" border>
        <h4 align="center"><%=currentDname%></h4>
		<tr bgcolor="#ffbd99">
			<th>의사ID</th>
			<th>이름</th>
			<th>성별</th>
			<th>전화번호</th>
            <th>이메일</th>
            <th>부서번호</th>
		</tr>
		<br>

		<%
			Vector doctorlist = doctorMgr.getDoctorList(currentDnum);
			int counter = doctorlist.size();
			for (int j = 0; j < doctorlist.size(); j++) {
				Doctor dr = (Doctor) doctorlist.elementAt(j);
		%>
		<tr>
			<td align="center"><%=dr.getDoctorid()%></td>
			<td align="center"><%=dr.getName()%></td>
			<td align="center"><%=dr.getSex()%></td>
            <td align="center"><%=dr.getPhone()%></td>
            <td align="center"><%=dr.getEmail()%></td>
            <td align="center"><%=dr.getDnum()%></td>
			<%
                }
            }
			%>
		</tr>
	</table>
</body>
</html>