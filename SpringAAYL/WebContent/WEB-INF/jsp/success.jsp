<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>InvoiceHelper</title>
<link rel="stylesheet" href="/SpringAAYL/resources//css/success.css">
<script>
document.getElementById("set").addEventListener("click", myFunction);

function myFunction() {
    document.getElementById("set").innerHTML = "YOU CLICKED ME!";
}
    function myFunction1() {
        document.getElementById("demo").innerHTML = "Hello World";
    }
</script>
</head>
<body background="/SpringAAYL/resources/images/wallpaper.jpeg">
	<h1>${msg}</h1>
	<h2>${message}</h2>
	<%--
		String user = null;
		if (session.getAttribute("user") == null) {
			response.sendRedirect("/loginregister");
		} else
			user = (String) session.getAttribute("user");
		String userName = null;
		String sessionID = null;
		Cookie[] cookies = request.getCookies();
		if (cookies != null) {
			for (Cookie cookie : cookies) {
				if (cookie.getName().equals("user"))
					userName = cookie.getValue();
				if (cookie.getName().equals("JSESSIONID"))
					sessionID = cookie.getValue();
			}
		}
	--%>
	<%--
	String str=(String)session.getAttribute("success");
	if(str!=null){
		if(str=="PassWord Changed Successfully")
			out.println("<h1><font color='green'>"+str+"</font></h1>");
		else
			out.println("<h1><font color='red'>"+str+"</font></h1>");
	}		
	--%> 
<%-- 	<h3>Welcome <%=user%> <br><!-- Login successful. Your Session ID=<%=sessionID%> --> </h3> --%>
		
<%--  <!-- User=<%=user%> --> --%>
<ul>
  <li><a href="back">Home</a></li>
  <li><a href="invoice">Create Invoice</a></li>
  <li><a href="change-page">Change Password</a></li>
  <li><a href="set-answer-page">Set answer for Security
				Question</a></li>
  <li><a href="details-page">Add Details</a></li>
  <li><a href="#about">About</a></li>
</ul>
	<form action="logout" method="post">
		<input type="submit" value="Logout" id="button">
	</form> 

</body>
</html>