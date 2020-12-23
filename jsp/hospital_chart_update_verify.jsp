<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="java.sql.*, chartBean.*" %>
<html>
	<head>
		<title>진료내용 업데이트</title>
	</head>
	<body>

        <jsp:useBean id="chartMgr" class="chartBean.ChartMgr" />	

        <%	
        request.setCharacterEncoding("utf-8");
            String p_id = request.getParameter("p_id");
		    String d_id = request.getParameter("d_id");
            String t_date = request.getParameter("t_date");
            String t_detail = request.getParameter("t_detail");
            String result = null;
			
			result = chartMgr.updateTreatmentDetail(p_id, d_id, t_detail, t_date);
        %>		
        <script>	
			alert("<%=result %>");
			location.href = "hospital_chart_detail.jsp?p_id=<%= p_id %>&d_id=<%= d_id %>&t_date=<%= t_date %>";
		</script>
		
	</body>
</html>
