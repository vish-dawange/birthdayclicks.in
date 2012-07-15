// sending SMS API of WAY2SMS

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.sql.*;

import java.net.URL;
import java.net.HttpURLConnection;
import java.io.DataOutputStream;
import java.io.InputStream;
import java.io.BufferedReader;
import java.io.InputStreamReader;

import java.util.ArrayList;
import java.net.URLEncoder;

public class SendWaySms extends HttpServlet {
	private static int responseCode = -1;
	private static String userCredentials = null;
	private static String cookie = null;
	private static String actionStr = null;
	//private static Credentials credentials = new Credentials();
	private ArrayList list = new ArrayList();
	private static HttpURLConnection connection;

private void init_var()
{
	responseCode = -1;
	userCredentials = null;
	cookie = null;
	actionStr = null;
	//private static Credentials credentials = new Credentials();
	list = new ArrayList();
}

private void login(String uid, String pwd) {
set("username", uid); //mobile no
append("password", pwd); //password
append("button", "Login");
userCredentials = getUserCredentials();

connect("http://site5.way2sms.com/Login1.action", false, "POST", null, userCredentials);
cookie = getCookie();
responseCode = getResponseCode();
if(responseCode != 302 && responseCode != 200)
exit(getErrorMessage());
disconnect();
}

private void getActionString() {
connect("http://site5.way2sms.com/jsp/InstantSMS.jsp", false, "GET", cookie, null);
responseCode = getResponseCode();
if(responseCode == 302 || responseCode == 200) {

String str = getResponse();

String aStr = "name=\"Action\" id=\"Action\"";
int aStrLen = aStr.length();

int index = str.indexOf(aStr);
if(index > 0) {
str = str.substring(index + aStrLen);
index = str.indexOf("\"");
if(index > 0) {
str = str.substring(index + 1);
index = str.indexOf("\"");
if(index > 0)
actionStr = str.substring(0, index);
}
}
} else {
exit(getErrorMessage());
}
disconnect();
}

private void sendSMS(String receiversMobNo, String msg) {
getActionString();

reset();
set("HiddenAction", "instantsms");
append("catnamedis", "Birthday");
if(actionStr != null)
append("Action", actionStr);
else
exit("Action string missing!");
append("chkall", "on");
append("MobNo", receiversMobNo); //receivers mobile no
append("textArea", msg); //actual message
append("bulidguid", "username");
append("bulidgpwd", "*******");
append("bulidyuid", "username");
append("bulidypwd", "*******");
append("guid1", "username");
append("gpwd1", "*******");
append("yuid1", "username");
append("ypwd1", "*******");

userCredentials = getUserCredentials();

connect("http://site5.way2sms.com/quicksms.action", true, "POST", cookie, userCredentials);
responseCode = getResponseCode();
if(responseCode != 302 && responseCode != 200)
exit(getErrorMessage());
disconnect();
}

private static void exit(String errorMsg) {
System.out.println(errorMsg);
System.exit(1);
}



public void set(String name, String value) {
StringBuffer buffer = new StringBuffer();

buffer.append(name);
buffer.append("=");
buffer.append(getUTF8String(value));

add(buffer.toString());
}

public void append(String name, String value) {
StringBuffer buffer = new StringBuffer();

buffer.append("&");
buffer.append(name);
buffer.append("=");
buffer.append(getUTF8String(value));

add(buffer.toString());
}

private void add(String item) {
list.add(item);
}

private String getUTF8String(String value) {
String encodedValue = null;

try {
encodedValue = URLEncoder.encode(value, "UTF-8");
} catch(Exception exception) {
//
System.out.println("Encoding error");
//
}

return encodedValue;
}

public boolean isEmpty() {
return list.isEmpty();
}

public void reset() {
list.clear();
}

public String getUserCredentials() {
StringBuffer buffer = new StringBuffer();
int size = list.size();

for(int i = 0; i < size; i++)
buffer.append(list.get(i));

return buffer.toString();
}


public static void connect(String urlPath, boolean redirect, String method, String cookie, String credentials) {
try {
URL url = new URL(urlPath);
connection = (HttpURLConnection) url.openConnection();

connection.setInstanceFollowRedirects(redirect);

if(cookie != null)
connection.setRequestProperty("Cookie", cookie);

if(method != null && method.equalsIgnoreCase("POST")) {
connection.setRequestMethod(method);
connection.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
}

connection.setUseCaches (false);
connection.setDoInput(true);
connection.setDoOutput(true);

if(credentials != null) {
DataOutputStream wr = new DataOutputStream (connection.getOutputStream ());
wr.writeBytes (credentials);
wr.flush ();
wr.close ();
}
} catch(Exception exception) {
//
System.out.println("Connection error");
//
}
}

public static String getCookie() {
String cookie = null;

if(connection != null) {
String headerName=null;

for (int i = 1; (headerName = connection.getHeaderFieldKey(i)) != null; i++) {
if (headerName.equals("Set-Cookie")) {
cookie = connection.getHeaderField(i).split(";")[0];
break;
}
}
}

return cookie;
}

public static int getResponseCode() {
int responseCode = -1;

if(connection != null) {
try {
responseCode = connection.getResponseCode();
} catch(Exception exception) {
//
System.out.println("Response code error");
//
}

}

return responseCode;
}

public static String getResponse() {
StringBuffer response = new StringBuffer();

if(connection != null) {
try {
InputStream is = connection.getInputStream();
BufferedReader rd = new BufferedReader(new InputStreamReader(is));

String line = null;
while((line = rd.readLine()) != null) {
response.append(line);
response.append('\r');
}

rd.close();
} catch(Exception exception) {
//
System.out.println("Response error");
//
}
}

return response.toString();
}

public static String getErrorMessage() {
StringBuffer errorMessage = new StringBuffer();

if(connection != null) {
try {
InputStream is = connection.getErrorStream();
BufferedReader rd = new BufferedReader(new InputStreamReader(is));

String line = null;
while((line = rd.readLine()) != null) {
errorMessage.append(line);
errorMessage.append('\r');
}

rd.close();
} catch(Exception exception) {
//
System.out.println("Error in getting error message");
//
}
}

return errorMessage.toString();
}

public static void disconnect() {
if(connection != null)
connection.disconnect();
}



    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try 
		{
			java.util.Date currentTime = new java.util.Date();
			int s = currentTime.getDay();
			String msg1=null;
			int f1,f2,f3;
			f1=0;
			f2=0;
			f3=0;
			Class.forName("com.mysql.jdbc.Driver").newInstance();
			Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/pro","db_bc_admin","dbbcadmin");
			Statement st = con.createStatement();
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
						msg1="BirthdayClicks\nThis Week BirthDayz\n";
						while(rs2.next())
						{
							f1=1;
							msg1=msg1+"- "+rs2.getString(1)+" "+rs2.getString(3)+" "+rs2.getString(4)+"\n"; 
						}
						if(f1==1)
						{
							init_var();
							login("7588854653", "only4u413");
							sendSMS(rs1.getString(4), msg1);
							out.println("Message Sent Successfully");	
						}
					}
					rs1.close();
					rs2.close();
				}
			
				
				PreparedStatement ps3=con.prepareStatement("select * from usertab");
				ResultSet rs3 = ps3.executeQuery();
				ResultSet rs4;
				PreparedStatement ps4;
				rs4=null;
				String msg2=null;
				while(rs3.next())
				{
					ps4=con.prepareStatement("select friendname,dob,day(dob),monthname(dob),message,mobile_no from friend_info where username='"+ rs3.getString(6) +"' and day(dob)=day(curdate()) and month(dob)=month(curdate());");
					f2=0;
					rs4=ps4.executeQuery();
					msg1="BirthdayClicks\n";
					msg2="BirthdayClicks\nToday's Birthdays:\n";
					while(rs4.next())
					{
						
						msg1=msg1+""+rs4.getString(5)+"\nFrom- "+rs3.getString(2)+" "+rs3.getString(3);
						msg2=msg2+"- "+rs4.getString(1)+"\n";
						init_var();
						login("7588854653", "only4u413");
						sendSMS(rs4.getString(6), msg1);
						out.println("Message Sent Successfully");
						f2=1;
					}
					if(f2==1)
					{
						init_var();
						login("7588854653", "only4u413");
						sendSMS(rs3.getString(4), msg2);
						out.println("Message Sent Successfully");
					}
				}
				rs3.close();
				rs4.close();
				
				
				
			}
			response.sendRedirect("/bdayclicks/sendnotify.jsp");
        }
        catch(Exception e)
        {
            out.println(e);
	}
        finally {
            out.close();
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
}