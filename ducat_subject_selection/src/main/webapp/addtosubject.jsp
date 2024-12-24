<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
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
 <link rel="stylesheet" type="text/css" href="admin.css">

<title>addtosubject</title>
</head>
<body>


<%String addtosubjectpage= ((String)session.getAttribute("adminstatus"));

if (addtosubjectpage == null || !"admin1234".equals(addtosubjectpage)) {
    session.setAttribute("errorMessage", "You are not logged in. Please log in first.");
    response.sendRedirect("admin.jsp");
    return;
}
%>

<%
out.print("hello");

String subject =request.getParameter("subjecttoadd").toUpperCase();
subject=subject.trim().replaceAll("\\s+", " ").replace(" ", "_");


if(subject != null && !subject.trim().isEmpty()){
	 String url ="jdbc:mysql://localhost:3306/ducat";  // Replace with your DB URL
	 String username = "root";  //Replace with your DB username
	 String password = "1234";  //Replace with your DB password
	 Connection connection=null;
 int valid=1;
	 
	 try {
	     // Establish a connection
	      connection = DriverManager.getConnection(url, username, password);
	      DatabaseMetaData dbMetaData = connection.getMetaData();
	      ResultSet result = dbMetaData.getTables("ducat", null, "%", new String[] {"TABLE"});
	     while(result.next()){
	    	 String dbname=result.getString(1);
	    	 if(dbname.equals(subject)){
System.out.print("nt dne");
	    		 
	    		 valid=0;
	    	 }
	     }
	     if(valid==1){
	    	 
	     Statement stmt = connection.createStatement();
      		      
        String sql = "CREATE TABLE " + subject + "(sno INT AUTO_INCREMENT PRIMARY KEY,topic VARCHAR(100),days INT)";
        stmt.executeUpdate(sql);
out.print("i m sds");
        System.out.println("table created successfully..."); 
        
	     }
	     else{
	    	 System.out.print("already existing subject");
	    	
	    	 response.sendRedirect("index.jsp");
	     }

	   

	     // Retrieve table names
	   
	     connection.close();
	 } catch (Exception e) {
	     e.printStackTrace();
	   
	     
	     
	 }
	 response.sendRedirect("managesubjects.jsp"); 
}

%>
</body>
</html>