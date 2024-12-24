<%
String adminstatus= (String)session.getAttribute("adminstatus");


if (adminstatus!="admin1234"){
	 out.print("login first");
	 
	 session.setAttribute("errorMessage", "You are not logged in. Please log in first.");
	
	 response.sendRedirect("admin.jsp");
	 
	 
	 
	 
}
%>