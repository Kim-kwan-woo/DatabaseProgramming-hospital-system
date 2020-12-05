<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.sql.*"%>
<%
	String userID = request.getParameter("userID");
	String userPassword = request.getParameter("userPassword");

	Connection myConn = null;
    Statement stmt = null;
    String mySQL_doctor = null;
    String mySQL_nurse = null;

	String dburl = "jdbc:oracle:thin:@210.94.199.20:1521:dblab";
	String user = "ST2016112117";
	String passwd = "ST2016112117";
	String dbdriver = "oracle.jdbc.OracleDriver";

	Class.forName(dbdriver);
	myConn = DriverManager.getConnection(dburl, user, passwd);
    stmt = myConn.createStatement();

    mySQL_doctor = "select doctorid, name from doctor where doctorid='" + userID + "' and password='" + userPassword + "'";
    ResultSet myResultSet = stmt.executeQuery(mySQL_doctor);

	if (myResultSet.next()) {
		session.setAttribute("user", userID);
        session.setAttribute("userName", myResultSet.getString("name"));
        session.setAttribute("userJob", "doctor");
		response.sendRedirect("hospital_main.jsp");
    } 
    else{
        mySQL_nurse = "select nurseid, name from nurse where nurseid ='" + userID + "' and password ='" + userPassword + "'";
        myResultSet = stmt.executeQuery(mySQL_nurse);
        if (myResultSet.next()) {
            session.setAttribute("user", userID);
            session.setAttribute("userName", myResultSet.getString("name"));
            session.setAttribute("userJob", "nurse");
            response.sendRedirect("hospital_main.jsp");
        }
        else{
%>

<script>
	alert("사용자 아이디 또는 암호가 틀렸습니다.");
	location.href = "hospital_login.jsp";
</script>
<%
        }
    }
    stmt.close();
	myConn.close();
%>
