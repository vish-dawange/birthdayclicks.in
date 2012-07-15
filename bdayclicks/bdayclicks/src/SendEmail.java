// Send weekly notification on Email of user

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.sql.*;
import java.util.Properties;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.Message.RecipientType;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import com.sun.mail.smtp.SMTPSSLTransport;

public class SendEmail extends HttpServlet {


    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
	    // send email to registered user
			try{
			String from="birthdayclicks@gmail.com";
			String to=request.getParameter("mail");
			String uname=request.getParameter("uname");
			String mobno=request.getParameter("mobno");
			String subject="ACCOUNT VERIFICATION!";
			String text="Hi "+ uname + ".. \nWelcome to BirthdayClicks... This email is to confirm that you have successfully registered to BirthdayClicks with this "+ to +" and mobile no. "+ mobno +"";
			String host = "smtp.gmail.com";
			String userid = "birthdayclicks@gmail.com"; 
			String password = "djworld2127"; 	
			try
			{
				Properties props = System.getProperties(); 
				props.put("mail.smtp.starttls.enable", "true"); 
				props.put("mail.smtp.host", host); 
				props.setProperty("mail.transport.protocol", "smtps");
				props.put("mail.smtp.user", userid); 
				props.put("mail.smtp.password", password); 
				props.put("mail.smtp.port", "465"); 
				props.put("mail.smtps.auth", "true"); 
				Session session = Session.getDefaultInstance(props, null); 
				MimeMessage message = new MimeMessage(session); 
				InternetAddress fromAddress = null;
				InternetAddress toAddress = null;

				try {
					fromAddress = new InternetAddress(from);
					toAddress = new InternetAddress(to);
				} catch (AddressException e) {

					e.printStackTrace();
				}
				message.setFrom(fromAddress);
				message.setRecipient(RecipientType.TO, toAddress);
				message.setSubject(subject);
				message.setText(text); 

				//SMTPSSLTransport transport =(SMTPSSLTransport)session.getTransport("smtps");

				Transport transport = session.getTransport("smtps"); 
				transport.connect(host, userid, password); 
				transport.sendMessage(message, message.getAllRecipients());
				
				getServletContext().getRequestDispatcher("/bdayclicks/reginsert").forward(request, response);	
				
				transport.close();			
				
				 
			} catch (MessagingException e) {
				e.printStackTrace();
				out.println("Enter valid E-mail ID!!!");
				getServletContext().getRequestDispatcher("/bdayclicks/reginfo.jsp").forward(request, response);
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