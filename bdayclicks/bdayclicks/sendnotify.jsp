<%@page contentType="text/html" pageEncoding="UTF-8" import="java.io.*" import="java.sql.*" import="java.util.Properties" import="javax.mail.Message" import="javax.mail.MessagingException" import="javax.mail.Session" import="javax.mail.Transport" import="javax.mail.Message.RecipientType" import="javax.mail.internet.AddressException" import="javax.mail.internet.InternetAddress" import="javax.mail.internet.MimeMessage" import="com.sun.mail.smtp.SMTPSSLTransport"%>

<%
		String mail=null;
		String mobno=null;
		java.util.Date currentTime = new java.util.Date();
			int s = currentTime.getDay();
			String msg1=null;
			int f1,f2,f3;
			f1=0;
			f2=0;
			f3=0;

			String from=null;
			String to=null;

			String subject=null;
			String text=null;
			String host = null;
			String userid = null; 
			String password = null;


			Properties props = System.getProperties(); 
			Session session1; 
			MimeMessage message;
			InternetAddress fromAddress = null;
			InternetAddress toAddress = null;
			Transport transport;
		Class.forName("com.mysql.jdbc.Driver").newInstance();
		Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/pro","db_bc_admin","dbbcadmin");
		Statement st = con.createStatement();
		try
		{

			
				
			PreparedStatement ps5=con.prepareStatement("select * from sent_date where t_date!=curdate();");
		    ResultSet rs5 = ps5.executeQuery();
			while(rs5.next())
			{
				if(s==0)
				{
				
					PreparedStatement ps=con.prepareStatement("select * from usertab");
					ResultSet rs1 = ps.executeQuery();
					ResultSet rs2;
					PreparedStatement ps2;
					rs2=null;

					while(rs1.next())
					{
						ps2=con.prepareStatement("select friendname,dob,day(dob),monthname(dob) from friend_info where username='"+ rs1.getString(6) +"' and day(dob)>day(curdate()) and day(dob)<=day(curdate()+7) and month(dob)=month(curdate()) order by month(dob),day(dob) asc;");
						f1=0;
						rs2=ps2.executeQuery();
						msg1="\nThis Week BirthDayz\n";
						while(rs2.next())
						{
							f1=1;
							msg1=msg1+"- "+rs2.getString(1)+" "+rs2.getString(3)+" "+rs2.getString(4)+"\n"; 
						}
						if(f1==1)
						{
								try{
								from="birthdayclicks@gmail.com";
								to=rs1.getString(5);

								subject=" WEEKLY BIRTHDAY NOTIFICATION";
								text=msg1;
								host = "smtp.gmail.com";
								userid = "birthdayclicks@gmail.com"; 
								password = "djworld2127";


								props = System.getProperties(); 
								props.put("mail.smtp.starttls.enable", "true"); 
								props.put("mail.smtp.host", host); 
								props.setProperty("mail.transport.protocol", "smtps");
								props.put("mail.smtp.user", userid); 
								props.put("mail.smtp.password", password); 
								props.put("mail.smtp.port", "465"); 
								props.put("mail.smtps.auth", "true"); 
								session1 = Session.getDefaultInstance(props,null); 
								message = new MimeMessage(session1); 
								fromAddress = null;
								toAddress = null;

								try {
									fromAddress = new InternetAddress(from);
									toAddress = new InternetAddress(to);
								} catch (AddressException e) {
									//response.sendRedirect("http://localhost:8080/reginfo.jsp?msg=Enter valid Email ID!!!");
				
								}
								message.setFrom(fromAddress);
								message.setRecipient(RecipientType.TO, toAddress);
								message.setSubject(subject);
								message.setText(text); 

								//SMTPSSLTransport transport =(SMTPSSLTransport)session.getTransport("smtps");

								transport = session1.getTransport("smtps"); 
								transport.connect(host, userid, password); 
								transport.sendMessage(message, message.getAllRecipients());
		
		
		
								transport.close();		
								
		 
							} catch (MessagingException e) {
								//response.sendRedirect("http://localhost:8080/reginfo.jsp?msg=Enter valid Email ID!!!");
			
		
							}    
						}
					}
					rs1.close();
					rs2.close();
				}

						
			}
			int m = currentTime.getMonth() + 1;
			int d = currentTime.getDate();
			int y = currentTime.getYear()+1900;
			String pdate=y + "-" + m + "-"+ d;
			PreparedStatement ps6=con.prepareStatement("update sent_date set t_date='"+pdate+"' where srno=1");
			ps6.executeUpdate();
			con.close();
			
			response.sendRedirect("/bdayclicks/index.html");
		}catch(Exception e)
        {
       	}
		
			
%>
