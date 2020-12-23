<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="java.util.*, chartBean.*"%><!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>환자 진료 내용 조회</title>
</head>
<body>
    <%@ include file="hospital_top.jsp"%>
    <%
        String p_id = request.getParameter("p_id");
        String d_id = request.getParameter("d_id");
        String t_date = request.getParameter("t_date");
    %>
    <jsp:useBean id="chartMgr" class="chartBean.ChartMgr" />
    <%
        String p_name = chartMgr.getPatientName(p_id);
        String d_name = chartMgr.getDoctorName(d_id);
        String t_detail = chartMgr.getTreatmentDetail(p_id, d_id, t_date);
    %>
    <br>
    <h4 align="center"><%=p_name%>(<%=p_id%>) 님의 진료 내용</h4>
    <p align="center">진료 의사 : <%=d_name%>(<%=d_id%>)</p>
    <p align="center">진료 날짜 : <%=t_date%></p>

    <br>
    <h4 align="center">[상세 진료 내용]</h4>
    <p align="center"><%=t_detail%></p>
    <br>
    <% 
    if(session_job == "doctor"){
    %>
    <h4 align="center"><a href="hospital_chart_update.jsp?p_id=<%= p_id %>&d_id=<%= d_id %>&t_date=<%= t_date %>&t_detail=<%=t_detail%>">진료내용 수정하기</a></h4>
    <% } %>
</body>
</html>