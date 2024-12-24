<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@ include file='sessioncheck.jsp' %>
<%@include file='navbar.jsp' %>
<%String subjectname= request.getParameter("deleteconfirm");

String adminpassword=request.getParameter("password");

if(adminpassword.equals("1234")){
	

String url ="jdbc:mysql://localhost:3306/ducat";  // Replace with your DB URL
String username = "root";  //Replace with your DB username
String password = "1234";  //Replace with your DB password
Connection connection=null;
int valid=1;

try {
    // Establish a connection
     connection = DriverManager.getConnection(url, username, password);
    
    
   
    Statement stmt = connection.createStatement();
 		      
   String sql = "DROP TABLE " + subjectname;
   stmt.executeUpdate(sql);

   
 

  

    // Retrieve table names
  
    connection.close();
} catch (Exception e) {
    e.printStackTrace();
  
    
    
}
response.sendRedirect("managesubjects.jsp"); 

}
else{
	session.setAttribute("deleteerrorMessage", "password wrong");

	response.sendRedirect("subjectdelete.jsp?selectedsubject="+subjectname);
	
}



%>


</body>
</html>