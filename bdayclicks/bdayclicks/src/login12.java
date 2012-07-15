// check for valid login

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.sql.*;

public class login12 extends HttpServlet {


    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            String name = request.getParameter("uname");
            String pass = request.getParameter("pword");
            int flag=0;
   

	    Class.forName("com.mysql.jdbc.Driver").newInstance();
	    Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/pro","db_bc_admin","dbbcadmin");
            Statement st = con.createStatement();

            PreparedStatement ps=con.prepareStatement("select * from usertab");
            ResultSet rs1 = ps.executeQuery();

            while(rs1.next())
            {
				flag=0;
            String username=rs1.getString("uname");
            String password=rs1.getString("pword");
            if(name.equals(username) && pass.equals(password))
            {
                 getServletContext().getRequestDispatcher("/session1.jsp").forward(request, response);
                 //response.sendRedirect("/bdayclicks/session1.jsp");
				 break;
            }

            else
                if(name!=username  && pass!=password )
            {
				flag=1;
                 // out.println("Login incorrect !!!");
                //  break;
            }
            }
			if(flag==1)
			{
				response.sendRedirect("/bdayclicks/loginfail.html");
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