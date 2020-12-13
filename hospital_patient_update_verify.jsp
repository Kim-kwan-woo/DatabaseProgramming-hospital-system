<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="java.sql.*, patientBean.*" %>
<html>
	<head>
		<title>환자 정보 수정</title>
	</head>
	<body>
        <jsp:useBean id="patientMgr" class="patientBean.PatientMgr" />	

        <%	
        request.setCharacterEncoding("utf-8");
            String p_id = request.getParameter("p_id");
            String p_name = request.getParameter("p_name");
            String p_sex = request.getParameter("p_sex");
            String p_phone = request.getParameter("p_phone");
            String p_address = request.getParameter("p_address");
            String p_email = request.getParameter("p_email");
            String p_hospitalization = request.getParameter("p_hospitalization");
            String result = null;
			
            result = patientMgr.updatePatient(p_id, p_name, p_sex, p_phone, p_address, p_email, p_hospitalization);
            System.out.print(p_id);
            if("20002".equals(result)){
        %>
        <script>
            var message;
                message = "입력정보가 너무 깁니다\n\n";
                message = message + "환자 이름 : 최대 3글자\n";
                message = message + "환자 성별 : M 또는 F\n";
                message = message + "환자 전화번호 : 최대 11글자\n";
                message = message + "환자 주소 : 최대 10글자\n";
                message = message + "환자 이메일 : 최대 20글자\n";
                message = message + "입원 정보 : O 또는 X\n";
                message = message + "담당 간호사 아이디 : 최대 8글자\n";
                message = message + "최초 진료 기록 : 최대 50글자\n";
            alert(message);
			location.href = "hospital_patient.jsp";
        </script>
        <%
        }
        %>		
        <script>	
			alert("<%=result %>");
			location.href = "hospital_patient.jsp";
		</script>
		
	</body>
</html>