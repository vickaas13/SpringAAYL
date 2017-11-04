<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>InvoiceHelper</title>
<link rel="stylesheet" href="/SpringAAYL/resources/css/style1.css"> 
<script type="text/javascript">
function mbno() {
	var mbno = document.getElementById("mobileNumber").value;
	if(mbno.length!=10||isNaN(mbno)){
		document.getElementById("set").innerHTML="Mobile Number Not Correct";
	}
	else{
		document.getElementById("set").innerHTML="";
	}
}
</script>
</head>
<body background="/SpringAAYL/resources/images/wallpaper.jpeg">
	<h3>Welcome to InvoiceHelper</h3>
	<%
		System.out.println("user attribite:"+session.getAttribute("user"));
		String str = (String) request.getAttribute("message");
		if (str != null) {
			if (str == "Registration Successful" || str=="Lets start")
				out.println("<h2><center><font color='green'>" + str + "</font></h2>");
			else
				out.println("<h2><center><font color='red'>" + str + "</font></center></h2>");
			session.setAttribute("message", null);
		}
	%>
	<input type='checkbox' id='form-switch'>
	<form id='login-form' action="login" method='post'>
		<input type="email" placeholder="Email" name="email" value="vikas@gmail.com" required>
		<input type="password" placeholder="Password" name="passWord" value="vikas123" required>
		<button type='submit'>Login</button>
		<label for='form-switch'><span>Register</span></label> 
		<a href="forgot-page">Forgot Password?</a>
	</form>


	<form id='register-form' action="register" method='post'>
		<input type="text" placeholder="First Name" name="firstName" required>
		<input type="text" placeholder="Last Name" name="lastName" required>
		<input type="email" placeholder="Email" name="email" required>
		<input type="text" id="mobileNumber" placeholder="Mobile Number"
			name="mobileNumber" required onchange="mbno()">
			<script> if(document.getElementById("set").value!=null) 
				out.println("<h3 id="set"></h3>");</script>
		 <input type="password"	placeholder="Password" name="passWord" required>
		<button type='submit'>Register</button>
		<label for='form-switch'>Already Member ? Sign In Now.</label>
	</form>
</body>
</html>