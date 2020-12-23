<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="java.util.*, chartBean.*"%><!DOCTYPE html>
<html>
	<head>
        <meta charset="EUC-KR">
		<title>진료 기록 등록</title>
	</head>
	<body>
	<%@ include file="hospital_top.jsp" %>
    <%
        String p_id = request.getParameter("p_id");
        String d_id = request.getParameter("d_id");
    %>
    <jsp:useBean id="chartMgr" class="chartBean.ChartMgr" />
    <%
        String p_name = chartMgr.getPatientName(p_id);
        String d_name = chartMgr.getDoctorName(d_id);
    %>
	<form name="insert_chart" method="post" action="hospital_chart_insert_verify.jsp">
		<table width="70%" align="center" border>
			<tr>
				<th>환자</th>
				<td> <%= p_name %> (<%= p_id %>)<input type="hidden" name="p_id" value="<%=p_id%>"></td>
			</tr>
			<tr>
				<th>의사</th>
				<td> <%= d_name %> (<%= d_id %>)<input type="hidden" name="d_id" value="<%=d_id%>"></td>
			</tr>
            <tr>
				<th>진료 내용</th>
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