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
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Pannel</title>
    <style>
      
    </style>
    
    <link rel="stylesheet" href="css/index2.css">
    
</head>
<body>




<form action="showplan.jsp" method="post" >
    <div class="container" id="container">
        <!-- Original content inside container -->
        <div class="content">
        <h2 style="margin-top:-5px "> SELECT DESIRED SUBJECT</h2>
            <h5 style="color: green;border:2px solid black;width:fit-content;text-align:center; padding: 5px; margin: 0;"> SELECT IN DESIRED SEQUENCE</h5>
               
               
                <%

String [] number={"1","2","3"};
String [] tags={"first","second","third"};


ArrayList < String > listofsubject= new ArrayList<String>();

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

out.print("<table><tr>");


for(int k=0;k<number.length;k++){
	if(k==0){
		
out.print(" <td><label for='select"+number[k]+"'>Subject " +number[k] +":</label></td> <td><select name='"+tags[k]+"select' id='select"+number[k]+"' onchange='validateSelection()''>  <option value='none'>None</option>");
	}else{
		out.print(" <td><label for='select"+number[k]+"'>Subject " +number[k] +":</label></td> <td><select disabled='true' name='"+tags[k]+"select' id='select"+number[k]+"' onchange='validateSelection()''>  <option value='none'>None</option>");
	}

if (listofsubject.isEmpty()) {
	System.out.print("hello");
	out.print("<h1 style='color:red'> no subject available </h1>");
	out.print(" </select></td></tr>");
	
}else {
	for (String i:listofsubject) {
		
    	out.print( " <option value='"+i+"'>" +i.replace("_", " ").toUpperCase()+"</option>");	
  
    	
    }
	out.print(" </select></td></tr>");
}
}
out.print("<tr><td>BATCH :</td><td><select name='batch' ><option>WEEKDAYS </option><option>WEEKEND</option></select></td></tr>");	
out.print("<tr><td><label for='date'>Select a date:</label></td><td><input type='date' id='date' name='date'></td></tr>");
out.print("</table><script>  function validateSelection() {"+
"	const select1 = document.getElementById('select1');"+
"const select2 = document.getElementById('select2');"+
        "const select3 = document.getElementById('select3');"+
        "const errorMessage = document.getElementById('error-message');"+
        "const submitButton = document.getElementById('submit-button');"+

        // Get selected values
        "const values = [select1.value, select2.value, select3.value];"+

        // Reset error styles and error message
        "[select1, select2, select3].forEach(select => {"+
            "select.classList.remove('error');"+
       " });"+
        "errorMessage.style.display = 'none';"+

        // Enable the second select when a valid option is selected in the first select
       " if (select1.value !== 'none') {"+
            "select2.disabled = false;"+
       " } else {"+
         "   select2.disabled = true;"+
          "  select2.value = 'none'; "+
          "  select3.disabled = true;"+
            "select3.value = 'none'; "+
       " }"+

        // Enable the third select when a valid option is selected in the second select
        "if (select2.value !== 'none') {"+
          "  select3.disabled = false;"+
       " } else {"+
         "   select3.disabled = true;"+
         "   select3.value = 'none'; // Reset the third select to'None'"+
       " }"+

        // Remove "none" values from consideration
        "const filteredValues = values.filter(value => value !== 'none');"+

        // Check for duplicate selections
        "const uniqueValues = new Set(filteredValues);"+
        "if (uniqueValues.size !== filteredValues.length) {"+
         "   errorMessage.style.display = 'block';"+
          "  submitButton.classList.add('hidden');"+

            // Highlight duplicate dropdowns
           " if (filteredValues.filter(v => v === select1.value).length > 1) {"+
            "    select1.classList.add('error');"+
          "  }"+
          "  if (filteredValues.filter(v => v === select2.value).length > 1) {"+
           "     select2.classList.add('error');"+
           " }"+
            "if (filteredValues.filter(v => v === select3.value).length > 1) {"+
            "    select3.classList.add('error');"+
           " }"+
        "} else {"+
        "    submitButton.classList.remove('hidden');"+
       " }"+
   " }</script>");
%>




                
                

            <div id="error-message" class="error-message" style="display: none;">
                Only select distinct elements.
            </div>

            <button id="submit-button" class="hidden" onclick="animateTable()">Submit</button>
        </div>

        <!-- Table that appears after zooming -->
      
    </div>
    </form>

    <script type="text/javascript">
    const today = new Date().toISOString().split('T')[0];
    document.getElementById('date').value = today;

    
    
    function validateSelection() {
        const select1 = document.getElementById("select1");
        const select2 = document.getElementById("select2");
        const select3 = document.getElementById("select3");
        const errorMessage = document.getElementById("error-message");
        const submitButton = document.getElementById("submit-button");

        // Get selected values
        const values = [select1.value, select2.value, select3.value];

        // Reset error styles and error message
        [select1, select2, select3].forEach(select => {
            select.classList.remove("error");
        });
        errorMessage.style.display = "none";

        // Enable the second select when a valid option is selected in the first select
        if (select1.value !== "none") {
            select2.disabled = false;
        } else {
            select2.disabled = true;
            select2.value = "none"; // Reset the second select to "None"
            select3.disabled = true;
            select3.value = "none"; // Reset the third select to "None"
        }

        // Enable the third select when a valid option is selected in the second select
        if (select2.value !== "none") {
            select3.disabled = false;
        } else {
            select3.disabled = true;
            select3.value = "none"; // Reset the third select to "None"
        }

        // Remove "none" values from consideration
        const filteredValues = values.filter(value => value !== "none");

        // Check for duplicate selections
        const uniqueValues = new Set(filteredValues);
        if (uniqueValues.size !== filteredValues.length) {
            errorMessage.style.display = "block";
            submitButton.classList.add("hidden");

            // Highlight duplicate dropdowns
            if (filteredValues.filter(v => v === select1.value).length > 1) {
                select1.classList.add("error");
            }
            if (filteredValues.filter(v => v === select2.value).length > 1) {
                select2.classList.add("error");
            }
            if (filteredValues.filter(v => v === select3.value).length > 1) {
                select3.classList.add("error");
            }
        } else {
            submitButton.classList.remove("hidden");
        }
    }
    
    function submitDate() {
            const dateInput = document.getElementById('date').value;
            if (dateInput) {
                alert(`You selected: ${dateInput}`);
            } else {
                alert('Please select a date!');
            }
        }
    </script>
     
   
</body>
</html>
