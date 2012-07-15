<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

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
<body>
	<div id="sidebar1">
		<ul>
			<li>
				<h2><center>Password Recovery Form</center></h2><br>
					<!--<iframe width="600" height="450" align="right" name="ifr" border="1"></iframe>-->				
							<form name="pwordrecovery" method="post" action="/bdayclicks/pwordsend.jsp">
							<table align="center" >
								<tr><td width="120"> <font color="white" size="3" face="comic sans ms">Username	:</font></td>
									<td width="150"><input style="width:150px;color:#808080;font-style:italic;margin:0;" type="text" name="uname" size="20" /></td>
								</tr>
								<tr height="20"></tr>
								<tr><td width="120"> <font color="white" size="3" face="comic sans ms">Email-Id  :</font></td>
								<td width="150"><input style="width:150px;color:#808080;font-style:italic;margin:0;" type="text" name="mail" size="20"/></td></tr>
								<tr height="20"></tr>
								<tr><td width="120"> <font color="white" size="3" face="comic sans ms">Mobile No.	:</font></td>
								<td width="150"><input style="width:150px;color:#808080;font-style:italic;margin:0;" type="text" name="mobno" size="20"/></td></tr>
								<tr height="20"></tr>
								

								<tr></tr>

							</table>
							<center><button type="SUBMIT" ><font color="330033" size="3" face="Forte">&nbsp;&nbsp;SUBMIT&nbsp;&nbsp;</font></button> </center>
									</form>
			</li>
		</ul>
	</div>
	<div style="clear: both;">&nbsp;</div>
	<!-- end #footer -->
</body>
</html>
<%String msg=request.getParameter("msg");
if(msg!=null){
    %>
<label><font color="red" size="5"><%=msg%></font></label> 
<%
}
    %>
