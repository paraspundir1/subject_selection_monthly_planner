<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@page import="java.util.ArrayList"%>
	<%@page import="java.sql.*" %>
	<%@page import="java.time.*" %>
		<%@page import="java.time.format.*" %>
		<%@page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style>
   #subjectnamesyllabus {
            background-color:#007bff ;
            color: white;
        }
        
        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
            font-size: 16px;
            font-family: Arial, sans-serif;
            text-align: left;
        }

        table th, table td {
            padding: 12px 15px;
            border: 1px solid #ddd;
        }

        table th {
            background-color: #007bff;
            color: white;
        }

        table tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        table tr:nth-child(odd) {
            background-color: #ffffff;
        }

        table tr:hover {
            background-color: #f1f1f1;
        }

        button {
            padding: 5px 10px;
            border: none;
            border-radius: 4px;
            color: white;
            cursor: pointer;
        }

        button[style*='background-color:green'] {
            background-color: #28a745;
        }

        button[style*='background-color:red'] {
            background-color: #dc3545;
        }
    </style>
</head>
<body>


	
	<%@include file="navbar.jsp" %>
	
	
<%	
	
	
ArrayList <String> selected = new ArrayList();
String firstselect="";
String secondselect="";
String thirdselect="";
String daysslected=request.getParameter("batch");
String selectedDate = request.getParameter("date");

// Parse the date into a LocalDate object
LocalDate startDate = LocalDate.parse(selectedDate);



out.println("<tr>");

out.println("</tr>");



 firstselect=request.getParameter("firstselect");
	 selected.add(firstselect);
 if (!(firstselect.equalsIgnoreCase("None") )){
	 
 	secondselect=request.getParameter("secondselect");
 	selected.add(secondselect);
 		if (!(secondselect.equalsIgnoreCase("None") )){
 				thirdselect=request.getParameter("thirdselect");	
 			selected.add(thirdselect);
 			}
 		
 }
 else{
	 
	 response.sendRedirect("student.jsp");
 }
 	
 selected.removeIf(item -> item == null || item.equalsIgnoreCase("None"));
 
	
out.print("<table><tr><th> SELECTED SUBJECTS IN THEIR SEQUENCE</th><th> START DATE</th><th> END DATE</th><th> TOPIC/WORKING DAYS</th><th>COURSE DURATION</th></tr>");
for(String subjectname:selected){
	
	out.print("<tr><td id=''> "+(subjectname).toUpperCase().replace("_", " ")+"</td><td id='start"+subjectname+"'> N/A</td><td id='end"+subjectname+"'> N/A</td><td id='topic"+subjectname+"'>N/A</td><td id='"+subjectname+"'>N/A</td></tr>");

}
out.print("<tr><td id=''> TOTAL : </td><td id='coursestart'> N/A</td><td id='courseend'> N/A</td><td id='totaltopics'>N/A</td><td id='totaldays'>N/A</td></tr>");

out.print("</table>");



out.print("<script type='text/javascript'>");
 out.print("document.getElementById('totaldays').innerHTML=parseInt(0);");
 out.print("document.getElementById('totaltopics').innerHTML=parseInt(0);");

 out.print("</script>");

 
 
// Process the result
//so that number continues after the subject change
int i=0;

out.print("PLESAE NOTE : this is a rough estimation of the course actual time duration may affted by other factors");


ArrayList  content = new ArrayList ();
for(String subjectname:selected){
	
	out.print("<table><tr><td id='subjectnamesyllabus'> "+(subjectname).toUpperCase().replace("_", " ")+" SYLABUS</td></tr>");



String date=null;
String query="SELECT * FROM "+subjectname+" ORDER BY sno ASC";


try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ducat", "root", "1234")) {
    // Create a Statement
    Statement stmt = conn.createStatement();

    // Execute the query and get the result
    ResultSet rs = stmt.executeQuery(query);
 
    out.print("<tr><td> SNO: </td><td> DATE: </td>"
    		+ "<td> DAYS: </td>"
    		+ " <td> WORKING/OFF: </td>"
    		+ "<td> TOPIC: </td>"
    		+ "<td> PART: </td><td>REMARKS /OUTCOME</td> </tr>");
    
    
    
    	if(rs.next()==false){
    		 out.print("<script type='text/javascript'>");
    		    out.print("document.getElementById('topic"+subjectname+"').innerHTML=0;");
    		    out.print("document.getElementById('"+subjectname+"').innerHTML=0;");
    		    
    		    out.print("</script>");

    	   
    	}
    	 rs = stmt.executeQuery(query);
    while (rs.next()) {
    	
    	String topic=rs.getString("topic");
        Integer days = rs.getInt("days");
        ArrayList  temp = new  ArrayList ();
        temp.add(topic);
        temp.add(days);
       
    	content.add(temp);
    	
    	
    	
    	
    }
    
    

   
    
   
    int dayspersubject=0;
    int workingtopic=0;
    LocalDate currentDate = startDate.plusDays(i);
    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
    String formattedDate = currentDate.format(formatter);


    out.print("<script type='text/javascript'>");
    out.print("document.getElementById('start"+subjectname+"').innerHTML='" + formattedDate + "';");
    out.print("</script>");

    
    
    while (!(content.isEmpty())){
    	ArrayList  dataofcontent =(ArrayList)content.get(0);
    	
 		List<String> daysOfWeek=null;
 		 if (daysslected.equals("weekend")){
 			 daysOfWeek = List.of(  "SATURDAY", "SUNDAY");
 		 }else{
 			 daysOfWeek = List.of("MONDAY", "TUESDAY", "WEDNESDAY", "THURSDAY"); 
 		 }
 		 
 		
 		int endday=(Integer) dataofcontent.get(1);
 		
 		
 		
 		
 		String remark="no remark";
 	// Define holiday- hard coded can also be retrived from database
 		List<LocalDate> holidays = List.of( LocalDate.of(2024, 1, 1),
 				LocalDate.of(2024, 8, 15),
 				LocalDate.of(2024, 12, 25),
 				//2025
 				LocalDate.of(2025, 1, 1),   // New Year
 	            LocalDate.of(2025, 1, 26),  // Republic Day
 	            LocalDate.of(2025, 8, 15),  // Independence Day
 	            LocalDate.of(2025, 10, 23), // Diwali
 	            LocalDate.of(2025, 12, 25), // Christmas

 	            // Holidays for 2026
 	            LocalDate.of(2026, 1, 1),   // New Year
 	            LocalDate.of(2026, 1, 26),  // Republic Day
 	            LocalDate.of(2026, 3, 6),   // Holi
 	            LocalDate.of(2026, 10, 21), // Dussehra
 	            LocalDate.of(2026, 12, 25));  // Christmas );
		int part=1;
 		while (endday > 0) {
 			
 		     currentDate = startDate.plusDays(i);
 		    DayOfWeek dayOfWeek = currentDate.getDayOfWeek();
 		   
 		    // Check if the current day is a working day and not a holiday
 		    
 		    boolean isHoliday = holidays.contains(currentDate);
 		    
 		    
 		    boolean isWorkingDay = daysOfWeek.stream().anyMatch(day -> day.toUpperCase().equals(dayOfWeek.toString().toUpperCase()));
System.out.print( dataofcontent.get(0));
 		    if (isHoliday) {
 		        // Holiday row
 		        out.print("<tr> <td> " + (i + 1) + " </td>"
 		                + "<td>" + currentDate.format(DateTimeFormatter.ofPattern("yyyy-MM-dd")) + "</td>"
 		                + "<td> " + dayOfWeek + " </td>"
 		                + "<td style='color:orange'>HOLIDAY</td>"
 		                + "<td style='color:orange'>-</td>"
 		                + "<td style='color:orange'>-</td><td style='color:red'>"+remark+"</td></tr>");
 		    } else if (isWorkingDay) {
 		        // Working day row
 		        out.print("<tr> <td> " + (i + 1) + " </td>"
 		                + "<td>" + currentDate.format(DateTimeFormatter.ofPattern("yyyy-MM-dd")) + "</td>"
 		                + "<td> " + dayOfWeek + " </td>"
 		                + "<td style='color:green'>WORKING</td>"
 		                + "<td> " + dataofcontent.get(0)+" </td>"
 		                + "<td>" + part + "</td><td style='color:red'>"+remark+"</td></tr>");
 		        endday--; // Decrease remaining working days for this topic
 		       part++;
 		    	workingtopic++;
 		        // If the topic is complete, remove it from the content list
 		        if (endday == 0) {
 		            content.remove(0);
 		            part=1;
 		        }
 		    } else {
 		        // Week-off row
 		        out.print("<tr> <td> " + (i + 1) + " </td>"
 		                + "<td>" + currentDate.format(DateTimeFormatter.ofPattern("yyyy-MM-dd")) + "</td>"
 		                + "<td> " + dayOfWeek + " </td>"
 		                + "<td style='color:red'>WEEK-OFF</td>"
 		                + "<td style='color:red'>-</td>"
 		                + "<td style='color:red'>-</td><td style='color:red'>"+remark+"</td></tr>");
 		    }
				

 		   
 		   dayspersubject++;
 		date=   currentDate.format(DateTimeFormatter.ofPattern("yyyy-MM-dd")).toString();
 		out.print("<script type='text/javascript'>document.getElementById('"+subjectname+"').innerHTML="+dayspersubject+"</script>");
 	  
 	     currentDate = startDate.plusDays(i);
 	     formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
 	     formattedDate = currentDate.format(formatter);


 	    out.print("<script type='text/javascript'>");
 	    out.print("document.getElementById('end"+subjectname+"').innerHTML='" + formattedDate + "';");
 	   out.print("document.getElementById('courseend').innerHTML='" + formattedDate + "';");
 	    out.print("</script>");
 	   out.print("<script type='text/javascript'>");
	    out.print("document.getElementById('topic"+subjectname+"').innerHTML='" + workingtopic + "';");
	    out.print("</script>");
	    
 	   i++; // Increment the day index
 		}
 		
 		
 		
 		
 		
 	  	
    }
       
    	
out.print("<script type='text/javascript'>");
out.print("document.getElementById('totaldays').innerHTML=parseInt(document.getElementById('totaldays').innerHTML)+parseInt(document.getElementById('"+subjectname+"').innerHTML);");
out.print("document.getElementById('totaltopics').innerHTML=parseInt(document.getElementById('totaltopics').innerHTML)+parseInt(document.getElementById('topic"+subjectname+"').innerHTML);");
out.print("document.getElementById('coursestart').innerHTML=document.querySelectorAll('table')[0].rows[1].cells[1].innerHTML;");
out.print("</script>") ;
    }
 		
  	
 	
  	


 		
  	
   
 		
 		
 		
 		
 		
 		
//  		while (endday > 0) {
//  		    LocalDate currentDate = startDate.plusDays(i);
//  		    DayOfWeek dayOfWeek = currentDate.getDayOfWeek();

//  		    // Check if the current day is in the selected batch (weekend or weekday)
//  		    boolean containsDay = daysOfWeek.stream().anyMatch(day -> day.toUpperCase().equals(dayOfWeek.toString().toUpperCase()));

//  		    if (containsDay) {
//  		        // Decrement endday only on working days
//  		        out.print("<tr> <td> " + (i + 1) + " </td>"
//  		                + "<td>" + currentDate.format(DateTimeFormatter.ofPattern("yyyy-MM-dd")) + "</td>"
//  		                + "<td> " + dayOfWeek + " </td>");

//  		        out.print("<td style='color:green'>WORKING</td>");
//  		        out.print("<td> " + dataofcontent.get(0) + " </td>"
//  		                + "<td>" + endday + "</td></tr>");
 		        
//  		        endday--; // Decrease remaining working days for this topic
 		        
//  		        // If the topic is complete, remove it from the content list
//  		        if (endday == 0) {
//  		            content.remove(0);
//  		        }
//  		    } else {
//  		        // Non-working day
//  		        out.print("<tr> <td> " + (i + 1) + " </td>"
//  		                + "<td>" + currentDate.format(DateTimeFormatter.ofPattern("yyyy-MM-dd")) + "</td>"
//  		                + "<td> " + dayOfWeek + " </td>"
//  		                + "<td style='color:red'>WEEK-OFF</td>"
//  		                + "<td style='color:red'>-</td>"
//  		                + "<td style='color:red'>-</td></tr>");
//  		    }

//  		    i++; // Increment the day index
//  		}

 		
 		
 		
 		
 		
 		
 		
 		
 		
 		
 		
 		
//  		 while(endday!=0){
//  			LocalDate currentDate = startDate.plusDays(i);
//  	    	DayOfWeek dayOfWeek = currentDate.getDayOfWeek();
 			
//  			 boolean containsDay = daysOfWeek.stream().anyMatch(day -> day.toUpperCase().equals(dayOfWeek.toString().toUpperCase()));
//  	 		if(containsDay){
//  	 			status="WORKING";
 	 			
//  	 		}
//  	 		else{
//  	 			status="WEEK-OFF";
//  	 		}
 			 
 			 
 			 
 			 
 			 
//  			 out.print("<tr> <td> "+(i+1)+" </td>"
//  	         		+ "<td>"+ currentDate.format(DateTimeFormatter.ofPattern("yyyy-MM-dd")) +"</td>"+
//  	         		"<td> "+dayOfWeek+" </td>");
 	 		 
 	 		
//  	 		 if (status.equals("WEEK-OFF")){
//  		 out.print("<td style='color:red'>"+status+"</td>");
//  		 out.print("<td style='color:red'>"+status+"</td>"
//  	     		+ "<td style='color:red'>"+status+"</td>");
 		 
//  			}
//  	 		else{
//  	 			 out.print("<td style='color:green'>"+status+"</td>");	
//  	 			out.print("<td> "+dataofcontent.get(0)+" </td>"
//  	 					+ "<td>"+dataofcontent.get(1)+"</td></tr>");
//  	 			if(endday==1){
 	 				
//  	 	 			content.remove(0);
//  	 	 			}
//  		 }
 		
 		
	 	        		
 		
 		 			
 		 		
//  		    i++	;
// 		 endday--;
 		
//  			 }
    	
  	
//  		}
 				
     		





catch (Exception e) {
    e.printStackTrace();
}
out.print("</table>");
}


%>



</body>
</html>