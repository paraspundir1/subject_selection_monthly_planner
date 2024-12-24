<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
      <%@page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
  <link rel="stylesheet" type="text/css" href="css/admin.css">
</head>
<body>
<%@ include file='sessioncheck.jsp' %>
<%@include file='navbar.jsp' %>

<%

String selectedsubject=request.getParameter("selectedsubject"); 






out.print("<table > <form action='cofirmdelete.jsp' method='post'><tr><th> SELECTED SUBJECT</th></tr> ");

	out.print("<td > "+selectedsubject.toUpperCase().replace("_", " ")+" </td><td > <input type='hidden' name='deleteconfirm' value='"+selectedsubject+"'><input type='text' name='password' placeholder='ENTER THE PASSWORD'> <button id='deltesubject' > DELETE</button></td>");
	
    
	out.print("</tr></form></table>");
	
	
	out.print("<table > <form action='underconstruction.jsp ' method='post'><tr><th> ADD TOPIC TO "+selectedsubject.toUpperCase().replace("_", " ")+"  (NOT FUNCTINAL YET)</th></tr> ");

	out.print("<td><input type='text' placeholder='TOPIC NAME' name='topicname'><input style='margin-left:40px' type='text' placeholder='DAYS TO COMPLETE' name='topicdays'> <input  type='hidden' name='deleteconfirm' value='"+selectedsubject+"'> <button style='margin-left:40px' id='addtopic' > ADD</button></td>");
	
    
	out.print("</tr></form></table>");	
	
	
	String errorMessage = (String) session.getAttribute("deleteerrorMessage");
	if (errorMessage != null) {
	    out.print("<p style='color:red;'>" + errorMessage + "</p>");
	    session.removeAttribute("deleteerrorMessage"); // Clear the message
	}
	
	 

%>

<%
String a=selectedsubject;

%>



<table border="1">
    <tr>
        <th><%=a.toUpperCase() %> SYALLABUS</th>
        
    </tr>

    <tr>
        <th>SNO :</th>
        <th>TOPICS</th>
        <th>DAYS FOR EACH TOPIC</th>
        <th>ACTION</th>
    </tr>

    <%
        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ducat", "root", "1234")) {
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("select * from "+a);
int count=1;
            while (rs.next()) {
                int sno = rs.getInt("sno");
                String topic = rs.getString("topic");
                int days = rs.getInt("days");
                
    %>
    <form action="underconstruction.jsp" method="POST">
      
        <tr>
            <td><%= count %></td>
            <td><%= topic %></td>
            <td><%= days %></td>
          
             <td> <input type='hidden' name='deleteconfirm' value='"<%= topic %>"'><button id='edittopic' > EDIT TOPIC</button></td>
           
           
        </tr>
       
    </form>
    <%
    count++;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    %>
    
    
    


</table>
</body>
</html>