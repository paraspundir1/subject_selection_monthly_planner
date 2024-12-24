<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%@include file="navbar.jsp" %>
	<%@page import="jakarta.servlet.ServletException"%> 
	<%@page import="jakarta.servlet.annotation.WebServlet"%>
	<%@page import="jakarta.servlet.http.HttpServlet"%>
	<%@page import="jakarta.servlet.http.HttpServletRequest"%>
	<%@page import="jakarta.servlet.http.HttpServletResponse"%>
	<%@page import="java.io.IOException"%>
	<%@page import="java.io.PrintWriter"%>
	<%@page import="java.sql.Connection"%>
	<%@page import="java.sql.DatabaseMetaData"%>
	<%@page import="java.sql.DriverManager"%>
	<%@page import="java.sql.ResultSet"%>
	<%@page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="css/admin.css">
<style>

    </style>
</head>
<body>

<%@ include file='sessioncheck.jsp' %>
<%
ArrayList< String > listofsubject= new ArrayList<String>();
 String url ="jdbc:mysql://localhost:3306/ducat";  // Replace with your DB URL
String username = "root";  //Replace with your DB username
String password = "1234";  //Replace with your DB password

try {
    // Establish a connection
    Connection connection = DriverManager.getConnection(url, username, password);

    // Get metadata for the database

    DatabaseMetaData dbMetaData = connection.getMetaData();

    // Retrieve table names
    ResultSet rs = dbMetaData.getTables("ducat", null, "%", new String[] {"TABLE"});
    while (rs.next()) {
        String tableName = rs.getString("TABLE_NAME");
        System.out.println("Table Name: " + tableName);
        listofsubject.add(tableName);
        
    }
    rs.close();
    connection.close();
} catch (Exception e) {
    e.printStackTrace();
    
}
out.print(" <table><ol><tr ><th>AVAILABLE SUBJECTS</th></tr	>");

if (listofsubject.isEmpty()) {
	out.print("<li> no subject available </li>");
	out.print("</ol> ");
}else {
	for (String i:listofsubject) {
		
    	out.print("<form action='showsyllabus.jsp' method='post'>"+
    	"<tr><td><li>"+ i.toUpperCase().replace("_", " ")+"</li></td><input type='hidden' name='selectedsubject' value="+i+"> <td> <button> see syllabus</button></td></tr></form>");	
  
    	
    }
	out.print("</ol></table> ");
}



%>

	



</body>
</html>