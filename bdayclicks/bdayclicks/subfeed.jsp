<%@page contentType="text/html" pageEncoding="UTF-8" import="java.io.*" import="java.sql.*" import="java.util.Properties" import="javax.mail.Message" import="javax.mail.MessagingException" import="javax.mail.Session" import="javax.mail.Transport" import="javax.mail.Message.RecipientType" import="javax.mail.internet.AddressException" import="javax.mail.internet.InternetAddress" import="javax.mail.internet.MimeMessage" import="com.sun.mail.smtp.SMTPSSLTransport"%>

<%
		String mail=request.getParameter("mail");
		String mobno=request.getParameter("mobno");
		String name=request.getParameter("name");
		String msg=request.getParameter("msg");
		
		
			String from="rajemayur.413@gmail.com";
			String to="birthdayclicks@gmail.com";

			String subject=" FEEDBACK";
			String text="NAME: "+ name + ",		Email-ID:"+ mail +",	Mobile  No.:"+ mobno +"		Feedback:"+ msg +"";
			String host = "smtp.gmail.com";
			String userid = "rajemayur.413@gmail.com"; 
			String password = "missu413";

		try{
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
				
				
				response.sendRedirect("/bdayclicks/image.html");
				
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
			
			response.sendRedirect("/bdayclicks/image.html");
			
		
		}    
%>
