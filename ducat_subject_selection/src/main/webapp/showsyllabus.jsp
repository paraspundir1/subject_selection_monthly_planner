<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import="java.sql.*" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
    <link rel="stylesheet" type="text/css" href="admin.css">
    <style>
       
    </style>
</head>
<body>


<%@include file="subjects.jsp" %>
<%
String a=request.getParameter("selectedsubject");

%>



<table border="1">
    <tr>
        <th><%=a.toUpperCase() %> SYALLABUS</th>
        
    </tr>

    <tr>
        <th>SNO :</th>
        <th>TOPICS</th>
        <th>DAYS FOR EACH TOPIC</th>
        
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
    <form action="adminaction" method="POST">
      
        <tr>
            <td><%= count %></td>
            <td><%= topic %></td>
            <td><%= days %></td>
           
           
        </tr>
    </form>
    <%
    count++;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    %>
    
    
    


</body>
</html>