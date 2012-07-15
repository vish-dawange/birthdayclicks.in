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


<script type="text/javascript">
function addOption(selectbox,text,value )
{
var optn = document.createElement("OPTION");
optn.text = text;
optn.value = value;
selectbox.options.add(optn);
}

function addmonth_list()
{
  var month = new Array("Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sept","Oct","Nov","Dec");

  	for (var i=0; i < month.length;++i)
 	{
    		addOption(document.friendform.months, month[i], month[i]);
  	}

	for (i=1960; i <= 2012;++i)
	{
  		addOption(document.friendform.years, i, i);
	}
	for (i=1; i <= 31;++i)
	{
  		addOption(document.friendform.days, i, i);
	}

	
       
}
function addday_list()
{

	 
	document.friendform.days.options.length = 0;
	var ndays=31;
	if(document.friendform.months.value=="Jan" || document.friendform.months.value=="Mar" || document.friendform.months.value=="May" || document.friendform.months.value=="Jul" || document.friendform.months.value=="Aug" || document.friendform.months.value=="Oct" || document.friendform.months.value=="Dec")
	{	ndays=31;}

	else if(document.friendform.months.value=="Feb")
 	{	ndays=29;}
	else
	{	ndays=30;}
	
	for (var i=1; i <= ndays;++i)
	{
  		addOption(document.friendform.days, i, i);
	}

}

function checkleap()
{
     	
	var year=document.friendform.years.value;
	
	if(year%4!=0 && document.friendform.months.value=="Feb" && document.friendform.days.value==29)
	{
		document.friendform.days.selectedIndex=0;
	}
}

function init()
{
	
	document.friendform.name.value="";
	document.friendform.mail.value="";
	document.friendform.mobno.value="";
	document.friendform.msg.value="";
	
	addmonth_list();
}

function validate()
{
   
   	if(validate_name())
	{
  		return true;
	}
	else
	{
		return false;
	}

}
function validate_name()
{
 	var s=/^[a-zA-Z/^\s]+$/;
	var s1=/^[0-9/-]+$/;
	
	if(document.friendform.name.value!="")
	{
		if(s.test(document.friendform.name.value))
		{
			return true;
		}
		else
		{
 			document.friendform.name.focus();
 			alert("Name Field Should contain Characters only!!!");
  			return false;
		}
	}
	else
	{
 		
  		document.friendform.name.focus();
     		alert("First Name Field is required!!!");
     		return false;
	}
}
</script>
</head>
<body onLoad="init()">
<font color="white">


<div id="sidebar1">
		<ul>
			<li>
				<h2><center>
Details of Friend</h2></center>





</li>
		</ul>
	</div>
	<div style="clear: both;">&nbsp;</div>
<form align="center" name="friendform" action="/bdayclicks/frndinsert"  onSubmit="javascript: return validate()">
<table align="center">


<tr><td width="120"> <font color="white" size="3" face="comic sans ms"><b>Name	:</b></font></td>
<td width="150"><input style="width:150px;color:#808080;font-style:italic;margin:0;" type="text" name="name" size="20" /></td>
</tr>
<tr height="20"></tr>
<tr><td width="150"> <font color="white" size="3" face="comic sans ms"><b>Email-Id(if Any)	:</b></td>
<td width="150"><input style="width:150px;color:#808080;font-style:italic;margin:0;" type="text" name="mail" size="20"/></td></tr>
<tr height="20"></tr>
<tr><td width="120"> <font color="white" size="3" face="comic sans ms"><b>Mobile No.	:</b></td>
<td width="150"><input style="width:150px;color:#808080;font-style:italic;margin:0;" type="text" name="mobno" size="20"/></td></tr>
<tr height="20"></tr>
<tr><td width="150"> <font color="white" size="3" face="comic sans ms"><b>Date Of Birth	:</b></td>
<td width="200"><select name="months" value="" onchange="addday_list()">
		</select>
		<select name="days" value="">
		</select>
		<select name="years" value="" onchange="checkleap()">
		</select>	
</td></tr>
<tr height="20"></tr>
<tr>
<td width="120"><font color="white" size="3" face="comic sans ms"><b>Message :</b></font></td>
<td width="150"><textarea cols="30" rows="6" name="msg""></textarea></td></tr>

<tr></tr>
<tr>
<td width="100"><font color="white" size="3" face="comic sans ms"><b>Relation :</b></font></td>
<td><select name="relation" value="Relation:"><option>Friend</option>
					<option>Family</option>
					</select></td>
</tr>
<tr>
<td width="100"><font color="white"></font></td>
<td><input type="hidden" name="uname" value="<%= session.getAttribute( "username" ) %>" /></td>
</tr>
</table><br><br>
<div align="center">

<center><button type="SUBMIT" ><font color="330033" size="3" face="Forte">&nbsp;&nbsp;SUBMIT&nbsp;&nbsp;</font></button> </center>
</form>
</div>
</body>
</html>
