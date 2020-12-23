<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.sql.*" %>
<html>
<head><title>Insert title here</title></head>
<body>
<%
    String userid = request.getParameter("userid");
    String userjob = request.getParameter("userjob");
	
	String name = new String(request.getParameter("name").getBytes("8859_1"),"utf-8");
	String sex = new String(request.getParameter("sex").getBytes("8859_1"),"utf-8");  
	String phone = new String(request.getParameter("phone").getBytes("8859_1"),"utf-8");
    String email = new String(request.getParameter("email").getBytes("8859_1"),"utf-8");	
    String password = new String(request.getParameter("password"));

	Connection myConn = null;  
	Statement stmt = null;  
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

    if(userjob.equals("doctor")) {
        mySQL = "update doctor ";
        mySQL = mySQL + " set name ='" + name + "' , " ;	
        mySQL = mySQL + " sex ='" + sex + "' , " ;
        mySQL = mySQL + " phone ='" + phone + "' , " ;
        mySQL = mySQL + " email ='" + email + "' , " ;
        mySQL = mySQL + " password ='" + password + "' where doctorid='" + userid + "' "; 

    } else{
        mySQL = "update nurse ";
        mySQL = mySQL + " set name ='" + name + "' , " ;	
        mySQL = mySQL + " sex ='" + sex + "' , " ;
        mySQL = mySQL + " phone ='" + phone + "' , " ;
        mySQL = mySQL + " email ='" + email + "' , " ;
        mySQL = mySQL + " password ='" + password + "' where nurseid='" + userid + "' "; 
    }
	try {		
		stmt.executeQuery(mySQL);  
%>

<script>
	alert("사용자 정보가 수정되었습니다.<%= userid %><%= userjob %>");       
	location.href="hospital_user_update.jsp";
</script>
<%    
	} catch(SQLException ex) {
		String sMessage;
		if (ex.getErrorCode() == 20002) sMessage="암호는 4자리 이상이어야 합니다.";
        else if (ex.getErrorCode() == 20003) sMessage="입력된 정보에 공란이 있습니다.";
        else if (ex.getErrorCode() == 20004) sMessage="성별은 M 또는 F를 입력해야 합니다.";
        else if (ex.getErrorCode() == 12899) sMessage="입력된 정보가 너무 깁니다. 입력한 정보의 길이를 확인하세요.";
        else if (ex.getErrorCode() == 1407) sMessage="모든 정보가 입력되어야 합니다. (빈칸 불가)";
		else sMessage="잠시 후 다시 시도하세요.";	
%>
<script>
	alert("<%= sMessage %>");    
	location.href = "hospital_user_update.jsp";
</script>
<%	
	} finally {
		if (stmt != null)   try { 	stmt.close();  myConn.close(); }
		catch(SQLException ex) { }
	}
%>
</body></html>
