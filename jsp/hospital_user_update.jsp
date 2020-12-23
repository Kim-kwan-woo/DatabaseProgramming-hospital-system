<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.sql.*"  %>
<!DOCTYPE html>
<html>
<head><title>종합병원 시스템 사용자 정보 수정</title></head>
<body>
<%@ include file="hospital_top.jsp" %>
<%
	if (session_id==null) response.sendRedirect("hospital_login.jsp");

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
    
    if(session_job == "doctor"){
        mySQL = "select name, sex, phone, email, password from doctor where doctorid='" + session_id + "'" ;
    } else {
        mySQL = "select name, sex, phone, email, password from nurse where nurseid='" + session_id + "'";
    }
	myResultSet = stmt.executeQuery(mySQL);
	if (myResultSet.next()) {
		String name = myResultSet.getString("name");
		String sex = myResultSet.getString("sex");
		String phone = myResultSet.getString("phone");	
		String email = myResultSet.getString("email");
		String password = myResultSet.getString("password");
%>

<form method="post" action="hospital_user_update_verify.jsp">
  <input type="hidden" name="userid" size="30" value="<%= session_id %>">
  <input type="hidden" name="userjob" size ="30" value="<%= session_job %>">
  <table width="70%" align="center" border>
     <tr><th>이름</th>
         <td><input type="text" name="name" size="20" value="<%= name %>"> </td>
     </tr>
     <tr><th>성별</th>
         <td><input type="text" name="sex" size="20" value="<%= sex %>"> </td>
     </tr>
     <tr><th>전화번호</th>
         <td><input type="text" name="phone" size="20"  value="<%= phone %>"></td>
     </tr>
     <tr><th>이메일</th>
         <td><input type="text" name="email" size="20" value="<%= email %>"> </td>
     </tr>
     <tr><th>비밀번호</th>
         <td><input type="password" name="password" size="20" value="<%= password %>"> </td>
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
</table></form></body></html>
