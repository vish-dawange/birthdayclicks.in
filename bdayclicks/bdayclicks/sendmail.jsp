<%@page contentType="text/html" pageEncoding="UTF-8" import="java.io.*" import="java.sql.*" import="java.util.Properties" import="javax.mail.Message" import="javax.mail.MessagingException" import="javax.mail.Session" import="javax.mail.Transport" import="javax.mail.Message.RecipientType" import="javax.mail.internet.AddressException" import="javax.mail.internet.InternetAddress" import="javax.mail.internet.MimeMessage" import="com.sun.mail.smtp.SMTPSSLTransport"%>

<%
		String mail=null;
		String mobno=null;
		String name=null;
		String uname=request.getParameter("uname");
		Class.forName("com.mysql.jdbc.Driver").newInstance();
		Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/pro","db_bc_admin","dbbcadmin");
		Statement st = con.createStatement();
		try
		{

			try{
				
				
						
				PreparedStatement ps1=con.prepareStatement("SELECT * from usertab where uname='"+ uname +"';");
				ResultSet rs1;
				rs1=null;
				rs1=ps1.executeQuery();
				
				while(rs1.next())
				{
					mail=rs1.getString("email");
					mobno=rs1.getString("mobno");
					name=rs1.getString("fname")+" "+rs1.getString("lname");
				}
				rs1.close();
			}
        		catch(Exception e)
        		{
            			
			}
		
			String from="birthdayclicks@gmail.com";
			String to=mail;

			String subject=" ACCOUNT VERIFICATION!";
			String text="Hi "+ uname + ",\n  Welcome to  BirthdayClicks... This email is to confirm that you have successfully registered to BirthdayClicks with this "+ to +" and mobile no. "+ mobno +"";
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
				
				PreparedStatement ps=con.prepareStatement("DELETE FROM usertab where uname='"+ uname +"';");
            			ps.executeUpdate();
						PreparedStatement ps4=con.prepareStatement("DELETE FROM friend_info where friendname='"+ name +"';");
            			ps4.executeUpdate();
				response.sendRedirect("/bdayclicks/reginfo.jsp?msg=Enter valid Email ID!!!");
				
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
			response.sendRedirect("/bdayclicks/image.html");
		 
		} catch (MessagingException e) {
			PreparedStatement ps=con.prepareStatement("DELETE FROM usertab where uname='"+ uname +"';");
            			ps.executeUpdate();
			PreparedStatement ps5=con.prepareStatement("DELETE FROM friend_info where friendname='"+ name +"';");
            			ps5.executeUpdate();
			response.sendRedirect("/bdayclicks/reginfo.jsp?msg=Enter valid Email ID!!!");
			
		
		}    
%>
