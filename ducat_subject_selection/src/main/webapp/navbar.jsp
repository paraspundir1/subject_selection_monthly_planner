<!-- navbar.jsp -->
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="styles.css">
    <style>
        /* Add some basic styling for the navbar */
        .navbar {
            background-color:  #007bff;
            overflow: hidden;
        }
        .navbar a {
            float: left;
            display: block;
            color: white;
            text-align: center;
            padding: 14px 20px;
            text-decoration: none;
        }
        .navbar a:hover {
            background-color: #0056b3;
            color: black;
        }
    </style>
</head>
<body>
    <div class="navbar">
        <a href="admin.jsp">Admin Home</a>
      
       
    <% 
    
    String statusAdminLoggedIn=(String)session.getAttribute("adminstatus");
   // String datafromwebxml=(String)(getServletContext().getAttribute("adminsessionid"));
    if(statusAdminLoggedIn=="admin1234"){
    	
    out.print(" <a href='subjects.jsp'>Subjects/Syllabus </a><a href='managesubjects.jsp'>Edit Subjects</a><a href='underconstruction.jsp'>Account Settings</a><a href='logout.jsp'>Log Out</a>");
    }
    %>
     <a href="student.jsp">Student Home</a>
       <a href="index.jsp">Welcome page</a>
    
    </div>
</body>
</html>
