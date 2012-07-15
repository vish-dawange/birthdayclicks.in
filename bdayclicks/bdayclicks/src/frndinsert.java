// Add friend in user account and send notification to friend through SMS that he/she added by someone

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

public class frndinsert extends HttpServlet {
	
	/* Way2SMS API for sending SMS */
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

	private void login(String uid, String pwd) 
	{
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

	private void getActionString() 
	{
		connect("http://site5.way2sms.com/jsp/InstantSMS.jsp", false, "GET", cookie, null);
		responseCode = getResponseCode();
		if(responseCode == 302 || responseCode == 200) 
		{

			String str = getResponse();
			String aStr = "name=\"Action\" id=\"Action\"";
			int aStrLen = aStr.length();

			int index = str.indexOf(aStr);
			if(index > 0)
			{
				str = str.substring(index + aStrLen);
				index = str.indexOf("\"");
				if(index > 0)
				{
					str = str.substring(index + 1);
					index = str.indexOf("\"");
					if(index > 0)
					actionStr = str.substring(0, index);
				}
			}
		}
		else
		{
			exit(getErrorMessage());
		}
		
		disconnect();
	}

	private void sendSMS(String receiversMobNo, String msg) 
	{

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

	// End of way2SMS Api

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException 
	{
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
		try{
			String name = request.getParameter("name");
			String mail = request.getParameter("mail");
			String mobno = "91"+request.getParameter("mobno");
			String msg = request.getParameter("msg");

			String relation = request.getParameter("relation");
			String uname=request.getParameter( "uname" );
			String mnth=request.getParameter("months");
			String ptime;
			java.util.Date currentTime = new java.util.Date();
            int month = currentTime.getMonth() + 1;
			String mnth1=request.getParameter("months");
	    
			if(msg==null)
			{
				msg="Wish U Many Many Happy Returns Of The Day!!!";
			}

			if(mnth1.equals("Jan"))
			{
				month=1;
			}
			if(mnth1.equals("Feb"))
			{
				month=2;
			}
			if(mnth1.equals("Mar"))
			{
				month=3;
			}
			if(mnth1.equals("Apr"))
			{
				month=4;
			}
			if(mnth1.equals("May"))
			{
				month=5;
			}            	
			if(mnth1.equals("Jun"))
			{
				month=6;
			}
			if(mnth1.equals("Jul"))
			{
				month=7;
			}
				if(mnth1.equals("Aug"))
			{
				month=8;
			}
					if(mnth1.equals("Sept"))
			{
				month=9;
			}
				if(mnth1.equals("Oct"))
			{
				month=10;
			}
				if(mnth1.equals("Nov"))
			{
				month=11;
			}
				if(mnth1.equals("Dec"))
			{
				month=12;
			}
		
		
	    
		    String bdate=request.getParameter("years") + "-" + month + "-"+ request.getParameter("days");
  	    
			try
			{
				   
				Class.forName("com.mysql.jdbc.Driver").newInstance();
				Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/pro","db_bc_admin","dbbcadmin");
					Statement st = con.createStatement();
				
				PreparedStatement ps2=con.prepareStatement("select * from usertab where uname='"+ uname +"';");
				ResultSet rs1=ps2.executeQuery();
				String msg1=null;
				while(rs1.next())
				{
					msg1="Hi "+ name +"\n Welcome to BirthdayClicks...\n You are added successfully in Birthday Reminder by "+ rs1.getString(2) +" "+rs1.getString(3) +"\n www.birthdayclicks.in";
				
					init_var();
					login("7588854653", "only4u413");
					sendSMS(mobno, msg1);
					out.println("Message Sent Successfully");
				}
				rs1.close();
				
				PreparedStatement ps=con.prepareStatement("INSERT INTO friend_info values (default, '"+ name +"','"+ mail +"', '"+ mobno +"','"+ bdate +"', '"+ msg +"', '"+ relation +"','"+ uname +"');");
				ps.executeUpdate();

				

				con.close();
				
				
			  
			}catch(Exception e)
				{
					out.println(e);
			}

				}   catch(Exception e)
				{
					out.println(e);
			}
				finally {
				response.sendRedirect("/bdayclicks/wall.jsp");
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