<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="java.sql.*, chartBean.*" %>
<html>
	<head>
		<title>진료기록 등록</title>
	</head>
	<body>

        <jsp:useBean id="chartMgr" class="chartBean.ChartMgr" />	

        <%	
        request.setCharacterEncoding("utf-8");
            String p_id = request.getParameter("p_id");
		    String d_id = request.getParameter("d_id");
            String t_detail = request.getParameter("t_detail");
            String result = null;
			
			result = chartMgr.insertTreatment(p_id, d_id, t_detail);
        %>		
        <script>	
			alert("<%=result %>");
			location.href = "hospital_chart.jsp?p_id=<%= p_id %>&d_id=<%= d_id %>";
		</script>
		
	</body>
</html>
