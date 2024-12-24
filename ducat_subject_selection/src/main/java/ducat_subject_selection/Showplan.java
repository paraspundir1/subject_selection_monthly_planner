package ducat_subject_selection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

/**
 * Servlet implementation class Showplan
 */
@WebServlet("/showplan")
public class Showplan extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	
	
	
	 
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Showplan() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		  // Get the current date
        Calendar calendar = Calendar.getInstance();
		
        // Populate table with the next 7 days
        SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
        SimpleDateFormat dayFormat = new SimpleDateFormat("EEEE");
		ArrayList <String []> listofdata= new ArrayList();
		int datatill=100;
		
		for (int i = 0; i < datatill; i++) {
	            Date date = calendar.getTime();
	            String dateStr = dateFormat.format(date);
	            String dayStr = dayFormat.format(date);
	            String [] obj1 = new  String [4];
	            obj1[0]=dateStr;
	            obj1[1]=dayStr;
	            if (dayStr.equals("Friday")|| dayStr.equals("Saturday") || dayStr.equals("Sunday")){
	            obj1[2]="Off";
	            }
	            else {
	            	  obj1[2]="topic";
	            }
	            obj1[3]="part";
	            
	            listofdata.add(obj1);
	           
	            	System.out.println(obj1[1]);
	            	calendar.add(Calendar.DAY_OF_MONTH, 1);
	            }
	 
	             // Move to the next day
	


	      

	        // Generate HTML table
	        out.println("<!DOCTYPE html>");
	        out.println("<html>");
	        out.println("<head>");
	        out.println("<title>Date and Day Table</title>");
	        out.println("<style>");
	        out.println("table { width: 50%; border-collapse: collapse; margin: 20px auto; }");
	        out.println("th, td { border: 1px solid #ddd; padding: 8px; text-align: center; }");
	        out.println("th { background-color: #f4f4f4; }");
	        out.println("body { font-family: Arial, sans-serif; text-align: center; }");
	        out.println("</style>");
	        out.println("</head>");
	        out.println("<body>");
	        out.println("<h1>Date and Day Table</h1>");
	        out.println("<table>");
	        out.println("<tr><th>Date</th><th>Day</th><th>Topic</th><th>Part</th></tr>");


	        for (int i = 0; i < datatill; i++) {
	           
	            String [] obj2= new String [4];
	            obj2=listofdata.get(i);
	            
	            out.println("<tr>");
	            out.println("<td>" + obj2[0] + "</td>");
	            out.println("<td>" + obj2[1] + "</td>");
	            
	            	
	            out.println("<td> "+obj2[2]+" </td>");
	            out.println("<td>"+obj2[3]+"</td>");
	            
	            out.println("</tr>");
	            

	           
	        }

	        out.println("</table>");
	        out.println("</body>");
	        out.println("</html>");
		
		
		
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
