<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
     <%@include file="navbar.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

 <link rel="stylesheet" type="text/css" href="css/admin.css">
</head>
<body>
<%
String errorMessage = (String) session.getAttribute("errorMessage");
if (errorMessage != null) {
    out.print("<p style='color:red;'>" + errorMessage + "</p>");
    session.removeAttribute("errorMessage"); // Clear the message
}
%>



<%String adminpage= (String)session.getAttribute("adminstatus");
 
//if (adminpage!=(String)(getServletContext().getAttribute("adminsessionid"))){
if (adminpage!="admin1234"){
	out.print("<form action='login.jsp' method='post'><table><tr><td> <input type='text' name='adminpass'><button style='margin-left:40px'>login</button></td></tr></form>");
	
	
}else{
	
			%>
			<table>
        <tr>
            <th colspan="2">Admin Dashboard</th>
        </tr>
        <tr>
            <td colspan="2"><b>Logged in as admin</b></td>
        </tr>
        <tr>
            <td><b>User Info</b></td>
            <td>Admin user details here</td>
        </tr>
        <tr>
            <td><b>Other Info</b></td>
            <td>Some other data related to the admin</td>
        </tr>
    </table>

    <!-- Logout button -->
    
    <%
    out.print("<a href='logout.jsp' class='logout-btn'>Logout</a>");
    

}
%>

</body>
</html>