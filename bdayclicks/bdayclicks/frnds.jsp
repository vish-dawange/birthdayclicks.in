<HTML>
<HEAD>
</HEAD>
<BODY>
<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*"%>


<%
	
      try{

    	  Class.forName("com.mysql.jdbc.Driver").newInstance();
		Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/pro","db_bc_admin","dbbcadmin");
            Statement st = con.createStatement();
	    
		PreparedStatement ps1=con.prepareStatement("SELECT msg,name,catgry,pdate,ptime FROM smstab where catgry='Friendship';");
	    
	    ResultSet rs;
	    rs=ps1.executeQuery();	


	       %>
	             <table align="center" color="white">
	             
			<%
	          		while(rs.next())
	          		{
					out.write("<tr width=200 ><td width=20 align=left><font color=white>"+rs.getString(1)+"</font></td></tr>");
					
out.print("<tr><td><font color=white>__________________________________________________________________</font></td><tr>");
					out.write("<tr width=200 ><td align=right><font color=white>Category: "+rs.getString(3)+"  Submitted By: "+rs.getString(2)+"  On :"+rs.getString(4)+" "+rs.getString(5)+"</font></td> </tr>");
out.print("<tr><td><font color=white>__________________________________________________________________</font></td></tr>");
		 			out.write("<tr></tr>");		
	          }
	         %>
	          </table>
	            <%

          	
        }catch(Exception e){

        out.write("Exception "+e);
        }

        %>
             
</BODY>
</HTML>