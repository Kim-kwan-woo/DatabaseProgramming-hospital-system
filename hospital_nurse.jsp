<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="java.util.*, nurseBean.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>전체 간호사 조회</title>
</head>
<body>
	<%@ include file="hospital_top.jsp"%>
	<%
		if (session_id == null)
			response.sendRedirect("hospital_login.jsp");
	%>
    <jsp:useBean id="nurseMgr" class="nurseBean.NurseMgr" />
    <%
        int maxDnum = nurseMgr.getMaxDnum();
        for(int i = 0; i < maxDnum; i++){
            int currentDnum =  i+1;
            String currentDname = nurseMgr.getDname(currentDnum);
    %>
	<table width="70%" align="center" border>
        <br>
        <h4 align="center"><%=currentDname%></h4>
		<tr bgcolor="#ffbd99">
			<th>간호사ID</th>
			<th>이름</th>
			<th>성별</th>
			<th>전화번호</th>
            <th>이메일</th>
            <th>담당업무</th>
            <th>부서번호</th>
		</tr>
		<br>

		<%
			Vector nurselist = nurseMgr.getNurseList(currentDnum);
			int counter = nurselist.size();
			for (int j = 0; j < nurselist.size(); j++) {
				Nurse nr = (Nurse) nurselist.elementAt(j);
		%>
		<tr>
			<td align="center"><%=nr.getNurseid()%></td>
			<td align="center"><%=nr.getName()%></td>
			<td align="center"><%=nr.getSex()%></td>
            <td align="center"><%=nr.getPhone()%></td>
            <td align="center"><%=nr.getEmail()%></td>
            <td align="center"><%=nr.getAssignedWork()%></td>
            <td align="center"><%=nr.getDnum()%></td>
			<%
                }
            }
			%>
		</tr>
	</table>
</body>
</html>