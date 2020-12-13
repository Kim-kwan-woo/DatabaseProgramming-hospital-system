<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="java.util.*, patientBean.*"%><!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>담당 환자 조회</title>
</head>
<body>
	<%@ include file="hospital_top.jsp"%>
	<%
		if (session_id == null)
			response.sendRedirect("hospital_login.jsp");
    %>
    <br>
    <h4 align="center"><%=session_name%>(<%=session_id%>) 님의 담당 환자 목록</h4>
	<table width="80%" align="center" border>
		<tr bgcolor="#ffbd99">
			<th>환자ID</th>
			<th>이름</th>
			<th>성별</th>
            <th>전화번호</th>
            <th>주소</th>
            <th>이메일</th>
            <th>입원정보</th>
            <th>담당의사(아이디)</th>
            <th>담당간호사(아이디)</th>
            <th>진료기록</th>
        </tr>
        <jsp:useBean id="patientMgr" class="patientBean.PatientMgr" />
		<%
			Vector patientlist = patientMgr.getPatientList(session_id, session_job);
			for (int i = 0; i < patientlist.size(); i++) {
                Patient pt = (Patient) patientlist.elementAt(i);
                String doctor_name = patientMgr.getDoctorName(pt.getDoctorid());
                String nurse_name = patientMgr.getNurseName(pt.getNurseid());
		%>
		<tr>
			<td align="center"><%=pt.getPatientid()%></td>
			<td align="center"><%=pt.getName()%></td>
			<td align="center"><%=pt.getSex()%></td>
            <td align="center"><%=pt.getPhone()%></td>
            <td align="center"><%=pt.getAddress()%></td>
            <td align="center"><%=pt.getEmail()%></td>
            <td align="center"><%=pt.getHospitalization()%></td>
            <td align="center"><%=doctor_name%>(<%=pt.getDoctorid()%>)</td>
            <td align="center"><%=nurse_name%>(<%=pt.getNurseid()%>)</td>
            <td align="center">
            <a href="hospital_chart.jsp?p_id=<%= pt.getPatientid() %>&d_id=<%= pt.getDoctorid() %>">차트</a>
            </td>>
			<%
                }
			%>
		</tr>
	</table>
</body>
</html>