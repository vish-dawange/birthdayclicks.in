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
    		addOption(document.regform.months, month[i], month[i]);
  	}

	for (i=1960; i <= 2012;++i)
	{
  		addOption(document.regform.years, i, i);
	}
	for (i=1; i <= 31;++i)
	{
  		addOption(document.regform.days, i, i);
	}

	
       
}
function addday_list()
{

	 
	document.regform.days.options.length = 0;
	var ndays=31;
	if(document.regform.months.value=="Jan" || document.regform.months.value=="Mar" || document.regform.months.value=="May" || document.regform.months.value=="Jul" || document.regform.months.value=="Aug" || document.regform.months.value=="Oct" || document.regform.months.value=="Dec")
		ndays=31;

	else if(document.regform.months.value=="Feb")
 		ndays=29;
	else
		ndays=30;
	
	for (var i=1; i <= ndays;++i)
	{
  		addOption(document.regform.days, i, i);
	}

}

function checkleap()
{
     	
	var year=document.regform.years.value;
	
	if(year%4!=0 && document.regform.months.value=="Feb" && document.regform.days.value==29)
	{
		document.regform.days.selectedIndex=0;
	}
}

function init()
{
	
	document.regform.FName.value="";
	document.regform.LName.value="";
	document.regform.mobno.value="";
	document.regform.mail.value="";
	document.regform.remail.value="";
	document.regform.uname.value="";
	document.regform.pword.value="";
	addmonth_list();
}


function validate()
{
   
   	if(validate_fname() && validate_lname() && validate_mobno() && validate_mail() && validate_uname() && validate_pword())
	{
  		return true;
	}
	else
	{
		return false;
	}

  



}

function validate_fname()
{
 	var s=/^[a-zA-Z]+$/;
	var s1=/^[0-9/-]+$/;
	
	if(document.regform.FName.value!="")
	{
		if(s.test(document.regform.FName.value))
		{
			return true;
		}
		else
		{
 			document.regform.FName.focus();
 			alert("Name Field Should contain Characters only!!!");
  			return false;
		}
	}
	else
	{
 		
  		document.regform.FName.focus();
     		alert("First Name Field is required!!!");
     		return false;
	}
}


function validate_lname()
{
 	var s=/^[a-zA-Z]+$/;
	var s1=/^[0-9/-]+$/;
	
	if(document.regform.LName.value!="")
	{
		if(s.test(document.regform.LName.value))
		{
			return true;
		}
		else
		{
 			document.regform.LName.focus();
 			alert("Name Field Should contain Characters only!!!");
  			return false;
		}
	}
	else
	{
 		
  		document.regform.LName.focus();
     		alert("Last Name Field is required!!!");
     		return false;
	}
}


function validate_mobno()
{
	var s1=/^[0-9/-]+$/;
	if(document.regform.mobno.value!="")
	{
		if(s1.test(document.regform.mobno.value))
		{
			var len=document.regform.mobno.value;
			if(len.length==10)
			{
				
				return true;	
			
			}
			else
			{
				document.regform.mobno.focus();
     				alert("Mobile Number must contain 10 digit only!!!");
     				return false;
			}
		}
		else
		{
			document.regform.mobno.focus();
     			alert("Mobile Number must contain digits only!!!");
     			return false;
		}
	}
	else
	{
		document.regform.mobno.focus();
     		alert("Mobile Number field is required!!!");
     		return false;
	}
}


function validate_mail()
{
	
	if(document.regform.mail.value!="")
	{
		if(document.regform.mail.value==document.regform.remail.value)
		{
			return true;
		}
		else
		{
			document.regform.remail.focus();
     			alert("Re-entered E-mail Id does not match!!!");
     			return false;
		}
	}
	else
	{
		document.regform.mail.focus();
     		alert("Email ID field is required!!!");
     		return false;
	}
}

function validate_uname()
{
 	
	if(document.regform.uname.value!="")
	{
		return true;
		
	}
	else
	{
 		
  		document.regform.uname.focus();
     		alert("UserName Field is required!!!");
     		return false;
	}
}



function validate_pword()
{
 	
	if(document.regform.pword.value!="")
	{
		return true;
		
	}
	else
	{
 		
  		document.regform.pword.focus();
     		alert("Password Field is required!!!");
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
Create a new  Account</h2></center>

<br>
<div align=center>
<div class="frm" align=left>

<form align="center" action="/bdayclicks/reginsert" method="get" name="regform" onSubmit="javascript: return validate()">


	<table align="center" name="regtab">


	<tr><td width=100> <font color="white" size="3" face="comic sans ms"><b>First Name	:</b></font></td>
	<td width="150"> <input type="text" name="FName" value="" size=20></td>

 </tr>
<tr height="20"></tr>
<tr>
<td width="120"><font color="white" size="3" face="comic sans ms"><b>Last Name	:</b></td>
<td width="150"><input type="text" name="LName" value="" size=20></td>

 </tr>

<tr height="20"></tr>
<tr>
<td width="120"><font color="white" size="3" face="comic sans ms"><b>Mobile No. :</b></font></td>
<td width="250"><input type="text" name="m_code" value="+91" readonly="true" size="1"><input type="text" name="mobno" value="" size=20></td>
 </tr>

<tr height="20"></tr>
<tr>
<td width="120"><font color="white" size="3" face="comic sans ms"><b>Your Email :</b></font></td>
<td width="150"><input type="text" name="mail" value="" size=20></td>
 </tr>

<tr height="20"></tr>
<tr>
<td width="130"><font color="white" size="3" face="comic sans ms"><b>Re-enter Email:</b></font></td>
<td width="150"><input type="text" name="remail" value="" size=20></td> 
 </tr>

<tr height="20"></tr>
<tr>

<td width="120"><font color="white" size="3" face="comic sans ms"><b>Username :</b></font></td>
<td width="150"><input type="text" name="uname" value="" size=20></td> 
 </tr>

<tr height="20"></tr>
<tr>

<td width="120"><font color="white" size="3" face="comic sans ms"><b>Password :</b></font></td>
<td width="150"><input type="password" name="pword" value="" size=20></td> 
 </tr>

<tr height="20"></tr>
<tr>

<td width="120"><font color="white" size="3" face="comic sans ms"><b>Gender :</b></font></td>
<td width="150"><select name="gender" value="Category:"><option><font color="white" size="3" face="comic sans ms"><b>Male</b></font></option>
					<option><font color="white" size="3" face="comic sans ms"><b>Female</b></font></option>
					
					</select></td> 
 </tr>

<tr height="20"></tr>
<tr>

<td width="120"><font color="white" size="3" face="comic sans ms"><b>Date Of Birth :</b></font></td>
<td width="200">
		<select name="months" value="" onchange="addday_list()">
		</select>
		<select name="days" value="">
		</select>
		<select name="years" value="" onchange="checkleap()">
		</select></td> 
 </tr>

<tr height="20"></tr>
</table>
	<center><button type="SUBMIT" ><font color="330033" size="3" face="Forte">&nbsp;&nbsp;SUBMIT&nbsp;&nbsp;</font></button> </center>
<br>

</from></div></div>

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