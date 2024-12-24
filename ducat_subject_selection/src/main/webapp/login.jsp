<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
String password=request.getParameter("adminpass");
if (password.equals("1234")){
System.out.print(password);
	
	session.setAttribute("adminstatus", "admin1234");
	  %>
	     <%@include file="admin.jsp" %>
	     <%
}else{
     
     
     %>
     <%@include file="admin.jsp" %>
     
     <%
     out.print("wrong password");
}
%>
</body>
</html>