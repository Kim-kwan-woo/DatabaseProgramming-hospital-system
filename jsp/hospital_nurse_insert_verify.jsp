<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="java.sql.*, nurseBean.*" %>
<html>
	<head>
		<title>신입 간호사 등록</title>
	</head>
	<body>
        <jsp:useBean id="nurseMgr" class="nurseBean.NurseMgr" />	

        <%	
        request.setCharacterEncoding("utf-8");
            String n_id = request.getParameter("n_id");
            String n_name = request.getParameter("n_name");
            String n_sex = request.getParameter("n_sex");
            String n_phone = request.getParameter("n_phone");
            String n_email = request.getParameter("n_email");
            String n_password = request.getParameter("n_password");
            int n_dnum = Integer.parseInt(request.getParameter("n_dnum"));
            String result = null;
			
            result = nurseMgr.insertNurse(n_id, n_name, n_sex, n_phone, n_email, n_password, n_dnum);
            
            if("20005".equals(result)){
        %>
        <script>
            var message;
                message = "입력정보가 너무 깁니다\n\n";
                message = message + "간호사 아이디 : 최대 8글자\n";
                message = message + "간호사 이름 : 최대 3글자\n";
                message = message + "간호사 성별 : M 또는 F\n";
                message = message + "간호사 전화번호 : 최대 11글자\n";
                message = message + "간호사 이메일 : 최대 20글자\n";
                message = message + "비밀번호 : 최대 8글자\n";
            alert(message);
			location.href = "hospital_nurse.jsp";
        </script>
        <%
        } else if ("-20002".equals(result)){
        %>
        <script>
            var message = "암호는 4자리 이상이어야 합니다.";
            alert(message);
			location.href = "hospital_nurse.jsp";
        </script>
        <%
        } else if ("-20003".equals(result)){
        %>
        <script>
            var message = "입력된 정보에 공백이 있습니다.";
            alert(message);
			location.href = "hospital_nurse.jsp";
        </script>
        <%
        } else if ("-20004".equals(result)){
        %>
        <script>
            var message = "성별 정보가 올바르지 않습니다. M 또는 F를 입력하세요";
            alert(message);
            location.href = "hospital_nurse.jsp";
        </script>
        <% } %>		
        <script>	
			alert("<%=result %>");
			location.href = "hospital_nurse.jsp";
		</script>
	</body>
</html>