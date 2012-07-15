<%@page contentType="text/html" pageEncoding="UTF-8" import="java.io.*" import="java.sql.*" import="java.util.Properties" import="javax.mail.Message" import="javax.mail.MessagingException" import="javax.mail.Session" import="javax.mail.Transport" import="javax.mail.Message.RecipientType" import="javax.mail.internet.AddressException" import="javax.mail.internet.InternetAddress" import="javax.mail.internet.MimeMessage" import="com.sun.mail.smtp.SMTPSSLTransport"%>

<%
		String mail=request.getParameter("mail");
		String mobno="91"+request.getParameter("mobno");
		String uname=request.getParameter("uname");
		String pword=null;
		int flag=0;
		Class.forName("com.mysql.jdbc.Driver").newInstance();
		Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/pro","db_bc_admin","dbbcadmin");
		Statement st = con.createStatement();
		try{

			try{
				
				PreparedStatement ps1=con.prepareStatement("SELECT * from usertab where uname='"+ uname +"' and email='"+ mail +"' and mobno='"+ mobno +"';");
				ResultSet rs1;
				rs1=null;
				rs1=ps1.executeQuery();
				
				while(rs1.next())
				{
					pword=rs1.getString("pword");
					flag=1;
				}
				rs1.close();
				}
        		catch(Exception e)
        		{
            			
				}
				if(flag==1)
				{
				String from="birthdayclicks@gmail.com";
				String to=mail;

				String subject=" ACCOUNT VERIFICATION!";
				String text="Hi "+ uname + ",  Welcome to  Birthday Reminder... This email is to confirm that you are valid user Of www.birthdayclicks.in  with this "+ to +" and mobile no. "+ mobno +" And Your Password is: "+ pword +"";
				String host = "smtp.gmail.com";
				String userid = "birthdayclicks@gmail.com"; 
				String password = "djworld2127";


				Properties props = System.getProperties(); 
				props.put("mail.smtp.starttls.enable", "true"); 
				props.put("mail.smtp.host", host); 
				props.setProperty("mail.transport.protocol", "smtps");
				props.put("mail.smtp.user", userid); 
				props.put("mail.smtp.password", password); 
				props.put("mail.smtp.port", "465"); 
				props.put("mail.smtps.auth", "true"); 
				Session session1 = Session.getDefaultInstance(props,null); 
				MimeMessage message = new MimeMessage(session1); 
				InternetAddress fromAddress = null;
				InternetAddress toAddress = null;

				try {
					fromAddress = new InternetAddress(from);
					toAddress = new InternetAddress(to);
					} catch (AddressException e) {
								
								response.sendRedirect("/bdayclicks/passrecova.jsp?msg=Enter valid Information!!!");
					}
				message.setFrom(fromAddress);
				message.setRecipient(RecipientType.TO, toAddress);
				message.setSubject(subject);
				message.setText(text); 

			//SMTPSSLTransport transport =(SMTPSSLTransport)session.getTransport("smtps");
				
				Transport transport = session1.getTransport("smtps"); 
				transport.connect(host, userid, password); 
				transport.sendMessage(message, message.getAllRecipients());
		
				transport.close();		
				response.sendRedirect("/bdayclicks/passinfo.html");
		 
				
			}
			else
			{
				response.sendRedirect("/bdayclicks/passrecova.jsp?msg=Enter valid Information!!!");	
			}
		} catch (MessagingException e) {
					
					response.sendRedirect("/bdayclicks/passrecova.jsp?msg=Enter valid INFORMATION!!!");
		}
%>
