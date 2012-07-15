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
				<h2><center>Upcoming Birthdays</center></h2>
</li>
		</ul>
	</div>
	<div style="clear: both;">&nbsp;</div>

<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*"%>


<%
	java.util.Date currentTime = new java.util.Date();
        int m = currentTime.getMonth()+1;
	int d = currentTime.getDate();
      try{

    	  Class.forName("com.mysql.jdbc.Driver").newInstance();
		Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/pro","db_bc_admin","dbbcadmin");
            Statement st = con.createStatement();
		String str;
	    String uname=(String)session.getAttribute( "username" );
		PreparedStatement ps1=con.prepareStatement("SELECT day(dob),monthname(dob),username,dob,year(curdate()) FROM friend_info group by day(dob),month(dob) order by month(dob),day(dob) asc;");
	int count=0;
        int flag=0;
		int f2=0;
	    ResultSet rs,rs2;
		rs=null;
		rs2=null;
	    rs=ps1.executeQuery();	


	       %>
	             <table align="center">
	     	<%    out.write("<tr><td><font color=white>______________________________________________________________</font></td></tr>");
             
		
	          		while(rs.next())
	          		{
					
		PreparedStatement ps2=con.prepareStatement("SELECT friendname,(year(curdate())-year(dob)),day(dob),month(dob) FROM friend_info where username='"+uname+"' and dayofyear(dob)>=dayofyear(curdate()) and day(dob)=day('"+rs.getDate(4)+"') and month(dob)=month('"+rs.getDate(4)+"');");
					rs2=ps2.executeQuery();
					
 					flag=0;
					while(rs2.next())
					{
						if(flag==0)
						{
								out.write("<tr><td width=500 align=center><font color=white size=5><b>"+rs.getString(1)+" "+rs.getString(2)+"  "+ rs.getString(5) +"</b></font></td></tr>");	
								
						}
						count=count+1;
						flag=1;
						out.write("<tr><td width=500 align=left><font color=white size=3>"+rs2.getString(1)+"     Age: "+rs2.getString(2)+" Year</td></tr>");	
						
						
	          		}
					if(flag==1)
						out.write("<tr><td><font color=white>______________________________________________________________</font></td><tr>");
				}
				if(count==0)
					out.write("<tr><td><font size=6 color=white>NO UPCOMING BIRTHDAY'S</font></td></tr>");	
	         %>
	          </table>
	            <%

          	
        }catch(Exception e){

        out.write("Exception "+e);
        }

        %>
             
</BODY>
</HTML>