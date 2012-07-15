<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta name="keywords" content="" />
<meta name="description" content="" />
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title> Birthday Reminder</title>
<link href="style.css" rel="stylesheet" type="text/css" media="screen" />
<script type="text/javascript" src="jquery/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="jquery/jquery.gallerax-0.2.js"></script>
<style type="text/css">
@import "gallery.css";
</style>
</head>
<body font color="white">
	<div id="sidebar1">
		<ul>
			<li>
				<h2><center>Birthday Information</center></h2>
</li>
		</ul>
	</div>
	<div style="clear: both;">&nbsp;</div>
<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*"%>


<%
	
      try{

    	  Class.forName("com.mysql.jdbc.Driver").newInstance();
		Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/pro","db_bc_admin","dbbcadmin");
            Statement st = con.createStatement();
		String str;
	    String uname=(String)session.getAttribute( "username" );
		PreparedStatement ps1=con.prepareStatement("SELECT friendname,day(dob),monthname(dob),year(dob) from friend_info where relation='Friend' and username='"+uname+"';");
	int count=0;
        int flag=0;		    
	    ResultSet rs,rs2;
		rs=null;
		rs2=null;
	    rs=ps1.executeQuery();	


	       %>
	             <table align="center" border="1">
		     <caption align="center"><font color="white">Friend's Birthday Information</font></caption>
	             <tr><td align="center" width="200"><font size="5" color="white">NAME</font></td><td align="center" width="200"><font size="5" color="white">DATE OF BIRTH</font></td></tr>
             
			<%
	          		while(rs.next())
	          		{

					out.write("<tr><td align=left><font color=white size=3>"+rs.getString(1)+"</font></td><td><font color=white size=3>"+rs.getString(2)+"-"+rs.getString(3)+"-"+rs.getString(4)+"</td></tr>");
				}
			%>
			</table>
			<BR><BR><BR>
			<table align="center" border="1"><caption align="center"><font color="white">Family's Birthday Information</font></caption>
	             <tr><td align="center" width="200"><font size="5" color="white">NAME</font></td><td align="center" width="200"><font size="5" color="white">DATE OF BIRTH</font></td></tr>
                          <%

		PreparedStatement ps2=con.prepareStatement("SELECT friendname,day(dob),monthname(dob),year(dob) FROM friend_info where username='"+uname+"' and relation='Family';");
					rs2=ps2.executeQuery();
					
						
 					
				while(rs2.next())
				{
                                       	count=count+1;
					out.write("<tr><td align=left><font color=white size=3>"+rs2.getString(1)+"</font></td><td><font color=white size=3>"+rs2.getString(2)+"-"+rs2.getString(3)+"-"+rs2.getString(4)+"</td></tr>");
				}
				if(count==0)
					out.write("<tr align=center><td><font color=white size=3>NO FAMILY INFORMATION ADDED</font></td></tr>");
	    %>
	          </table>
			  <br>
	            <%

          	
        }catch(Exception e){

        out.write("Exception "+e);
        }

        %>
             
</BODY>
</HTML>