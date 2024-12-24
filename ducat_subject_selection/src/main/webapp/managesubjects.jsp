
<%@page import="java.sql.PreparedStatement"%>
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
	<%@page import="java.sql.*"%>
	<%@page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>manage subjects</title>
  <link rel="stylesheet" type="text/css" href="css/admin.css">
 
</head>
<body>
<%@ include file='sessioncheck.jsp' %>


<form action="addtosubject.jsp" method='post'>


<table>
<tr>
<th>ADD NEW SUBJECT
</th>
</tr>
<tr>
<td>
<input type="text" name='subjecttoadd'>
</td>
	
<td>
<button type="submit">ADD SUBJECT</button>
</td></tr>
</table>
</form>




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
        //System.out.println("Table Name: " + tableName);
        listofsubject.add(tableName);
        
    }
    rs.close();
    connection.close();
} catch (Exception e) {
    e.printStackTrace();
    
}




out.print("<table ><ol> <tr><th> EXISTING SUBJECTS</th></tr> ");
if (listofsubject.isEmpty()) {
	out.print("<h1 style='color:red'> NO SUBJECT AVAILABLE </h1>");
	out.print("</ol> ");
}else {
	for (String i:listofsubject) {
		
    	out.print( "<tr><form action ='subjectdelete.jsp' method='post'><td>  <li>"+i.toUpperCase().replace("_", " ")+"</li> <input type='hidden' name='selectedsubject'  value="+i+"> </td><td><button id='editsubject'> EDIT</button><button type='submit' id='deltesubject'> DELETE</button> </td></tr></form>");	
  
    	
    }
	out.print("</ol></table>");
}
	 
	 

%>

</body>
</html>