<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="java.util.*, chartBean.*"%><!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>환자 진료 기록 조회(차트)</title>
</head>
<body>
    <%@ include file="hospital_top.jsp"%>
    <%
        String p_id = request.getParameter("p_id");
        String d_id = request.getParameter("d_id");
    %>
    <jsp:useBean id="chartMgr" class="chartBean.ChartMgr" />
    <%
        String p_name = chartMgr.getPatientName(p_id);
    %>
    <br>
    <h4 align="center"><%=p_name%>(<%=p_id%>) 님의 진료 기록</h4>
    <table width="60%" align="center" border>
		<tr bgcolor="#ffbd99">
			<th>진료의사</th>
			<th>진료날짜</th>
			<th>진료내용</th>
		</tr>
		<%
			Vector chartlist = chartMgr.getChartList(p_id, d_id);
			for (int i = 0; i < chartlist.size(); i++) {
                Chart ch = (Chart) chartlist.elementAt(i);
                String doctor_name = chartMgr.getDoctorName(ch.getDoctorid());
		%>
		<tr>
			<td align="center"><%=ch.getDoctorid()%></td>
			<td align="center"><%=ch.getTreatmentDate()%></td>
            <td align="center">
                <a href="hospital_chart_detail.jsp?p_id=<%= p_id %>&d_id=<%= d_id %>&t_date=<%= ch.getTreatmentDate() %>">진료 내용 보기</a>
                </td>>
			<%
                }
			%>
		</tr>
    </table>
    <%
    if(session_job == "doctor"){
        %>
        <h4 align="center"><a href="hospital_chart_insert.jsp?p_id=<%= p_id %>&d_id=<%= d_id %>">진료기록 추가</a></h4>
    <% } %>
</body>
</html>