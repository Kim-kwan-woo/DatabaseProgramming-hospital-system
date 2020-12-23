<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="java.util.*, java.sql.*"%><!DOCTYPE html>
<html>
	<head>
		<title>환자 정보 수정</title>
	</head>
	<body>
    <%@ include file = "hospital_top.jsp" %>
    <%
        String p_id = request.getParameter("p_id");

        Connection myConn = null;     
        Statement stmt = null;	
        ResultSet myResultSet = null; 
        String mySQL = "";
    
        String dburl  = "jdbc:oracle:thin:@210.94.199.20:1521:dblab";
        String user="ST2016112117";
        String passwd="ST2016112117";
        String dbdriver = "oracle.jdbc.driver.OracleDriver";
    
        try {
              Class.forName(dbdriver);
            myConn =  DriverManager.getConnection (dburl, user, passwd);
            stmt = myConn.createStatement();	
        } catch(SQLException ex) {
            System.err.println("SQLException: " + ex.getMessage());
        }
        
        mySQL = "select name, sex, phone, address, email, hospitalization from patient where patientid='" + p_id + "'" ;
        myResultSet = stmt.executeQuery(mySQL);
        if (myResultSet.next()) {
            String p_name = myResultSet.getString("name");
            String p_sex = myResultSet.getString("sex");
            String p_phone = myResultSet.getString("phone");	
            String p_address = myResultSet.getString("address");
            String p_email = myResultSet.getString("email");
            String p_hospitalization = myResultSet.getString("hospitalization");
    %>
    <form name="update_patient" method="post" action="hospital_patient_update_verify.jsp">
        <input type="hidden" name="p_doctorid" value="<%=session_id%>">
		<table width="70%" align="center" border>
			<tr>
				<th>환자 아이디</th>
				<td><%=p_id%><input type="hidden" name="p_id" value="<%=p_id%>"></td>
			</tr>
			<tr>
				<th>환자 이름</th>
				<td><input type="text" name="p_name" value="<%=p_name%>"></td>
			</tr>
			<tr>
				<th>환자 성별</th>
				<td><input type="text" name="p_sex" value="<%=p_sex%>"></td>
            </tr>
            <tr>
				<th>환자 전화번호</th>
				<td><input type="text" name="p_phone" value="<%=p_phone%>"></td>			
            </tr>
            <tr>
				<th>환자 주소</th>
				<td><input type="text" name="p_address" value="<%=p_address%>"></td>			
            </tr>
            <tr>
				<th>환자 이메일</th>
				<td><input type="text" name="p_email" value="<%=p_email%>"></td>			
            </tr>
            <tr>
				<th>입원정보</th>
				<td><input type="text" name="p_hospitalization" value="<%=p_hospitalization%>"></td>			
            </tr>     
    <%
	}	
	    stmt.close();  
	    myConn.close();
    %> 
            <tr>
				<td colspan="2" align="center">
					<input type="submit" value="수정">
				</td> 
			</tr>
		</table>
        </form>
    </body>
</html> 