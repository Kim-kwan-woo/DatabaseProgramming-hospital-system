<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="java.util.*, chartBean.*"%><!DOCTYPE html>
<html>
	<head>
		<title>진료 내용 수정</title>
	</head>
	<body>
	<%@ include file="hospital_top.jsp" %>
    <%
        String p_id = request.getParameter("p_id");
        String d_id = request.getParameter("d_id");
        String t_date = request.getParameter("t_date");
        String t_detail = request.getParameter("t_detail");
    %>
    <jsp:useBean id="chartMgr" class="chartBean.ChartMgr" />
    <%
        String p_name = chartMgr.getPatientName(p_id);
        String d_name = chartMgr.getDoctorName(d_id);
    %>
	<form name="update_chart" method="post" action="hospital_chart_update_verify.jsp">
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
				<th>진료 날짜</th>
				<td> <%= t_date %><input type="hidden" name="t_date" value="<%=t_date%>"></td>
            </tr>
            <tr>
				<th>진료 내용</th>
				<td><input type="text" name="t_detail" size=50 value="<%=t_detail%>"></td>			
            </tr>      
            <tr>
				<td colspan="2" align="center">
					<input type="submit" value="수정">
				</td> 
			</tr>
		</table>
		</form>
	</body>
</html> 