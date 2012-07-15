// Inserting SMS into database

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.sql.*;

public class insert extends HttpServlet {


    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            String name = request.getParameter("name");
            String msg = request.getParameter("msg");
            String cat = request.getParameter("cat");
	String ptime;
	java.util.Date currentTime = new java.util.Date();
        int month = currentTime.getMonth() + 1;
	int day = currentTime.getDate();
	int year = currentTime.getYear()+1900;
	String pdate=day + "/" + month + "/"+ year;

	int hours = currentTime.getHours();
	int minutes = currentTime.getMinutes();
	
	
	if(hours > 11){
		ptime=hours + ":" + minutes + " PM";
		
	} 
	else {
		ptime=hours + ":" + minutes + " AM";	
	}
          
		Class.forName("com.mysql.jdbc.Driver").newInstance();
		Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/pro","db_bc_admin","dbbcadmin");
        Statement st = con.createStatement();
	    PreparedStatement ps=con.prepareStatement("INSERT INTO smstab values (default, '"+ name +"', '"+ msg +"','"+ cat +"', '"+ pdate +"', '"+ ptime +"' );");
        ps.executeUpdate();

            
        response.sendRedirect("/bdayclicks/image.html"); 
	
            
        }
        catch(Exception e)
        {
            out.println(e);
	}
        finally {
            out.close();
        }
    }

   
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    }

    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    }


    @Override
    public String getServletInfo() {
        return "Short description";
    }
}