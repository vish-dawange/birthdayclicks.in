// Register user account and send notification to Email

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.sql.*;

public class reginsert extends HttpServlet {


    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            	String fname = request.getParameter("FName");
            	String lname = request.getParameter("LName");
           	String mobno = "91"+request.getParameter("mobno");
		String mail = request.getParameter("mail");	
	    	String uname = request.getParameter("uname");
	    	String pword = request.getParameter("pword");
	    	String gender = request.getParameter("gender");
	 	String mnth=request.getParameter("months");
		String ptime;
		int flag=0;
			

		
	    
	
		Class.forName("com.mysql.jdbc.Driver").newInstance();
		Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/pro","db_bc_admin","dbbcadmin");
            	Statement st = con.createStatement();
		
		PreparedStatement ps1=con.prepareStatement("SELECT * from usertab where mobno='"+ mobno +"';");
		ResultSet rs1,rs2,rs3;
		rs1=null;
		rs2=null;
		rs3=null;
		rs1=ps1.executeQuery();

		while(rs1.next())
		{
			
			response.sendRedirect("/bdayclicks/reginfo.jsp?msg=Mobile Number is already registered!!!");
			flag=1;	
			break;
		}
		rs1.close();
	

		PreparedStatement ps2=con.prepareStatement("SELECT * from usertab where email='"+ mail +"';");
	    	rs2=ps2.executeQuery();
		while(rs2.next())
		{
			
			response.sendRedirect("/bdayclicks/reginfo.jsp?msg=Email ID is already registered!!!");
			flag=1;
			break;
		}
		rs2.close();

		PreparedStatement ps3=con.prepareStatement("SELECT * from usertab where uname='"+ uname +"';");
	    	rs3=ps3.executeQuery();
		while(rs3.next())
		{
			
			response.sendRedirect("/bdayclicks/reginfo.jsp?msg=UserName is already registered!!!");
			flag=1;
			break;
		}
		rs3.close();
    
	if(flag!=1){
		java.util.Date currentTime = new java.util.Date();
            	int month = currentTime.getMonth() + 1;
	    	
		if(mnth.equals("Jan"))
		{
			month=1;
			}
		if(mnth.equals("Feb"))
		{
			month=2;
		}
		if(mnth.equals("Mar"))
		{
			month=3;
		}
		if(mnth.equals("Apr"))
		{
			month=4;
		}
		if(mnth.equals("May"))
		{
			month=5;
		}            	
		if(mnth.equals("Jun"))
		{
			month=6;
		}
	 	if(mnth.equals("Jul"))
		{
			month=7;
		}
	    	if(mnth.equals("Aug"))
		{
			month=8;
		}
            	if(mnth.equals("Sept"))
		{
			month=9;
		}
	    	if(mnth.equals("Oct"))
		{
			month=10;
		}
	    	if(mnth.equals("Nov"))
		{
			month=11;
		}
	    	if(mnth.equals("Dec"))
		{
			month=12;
		}
	
	    	String bdate=request.getParameter("years") + "-" + month + "-"+ request.getParameter("days");

	
           
		String name=fname+" "+lname;
	    PreparedStatement ps=con.prepareStatement("INSERT INTO usertab values (default, '"+ fname +"','"+ lname +"', '"+ mobno +"','"+ mail +"', '"+ uname +"', '"+ pword +"','"+ gender +"','"+ bdate +"');");
            ps.executeUpdate();
			PreparedStatement ps4=con.prepareStatement("INSERT INTO friend_info values (default, '"+ name +"','"+ mail +"', '"+ mobno +"','"+ bdate +"', 'Wish U Many Many Happy Returns Of The Day', 'Friend','DJWorld');");
            ps4.executeUpdate();

            response.sendRedirect("/bdayclicks/sendmail.jsp?uname="+uname+"");
                  
		}	
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