<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" href="/SpringAAYL/resources/css/style1.css">
<link rel="stylesheet" href="/SpringAAYL/resources/css/success.css">
<title>InvoiceHelper</title>
</head>
<body background="/SpringAAYL/resources/images/wallpaper.jpeg">
<%
		String user = null;
		if (session.getAttribute("user") == null) {
			response.sendRedirect("../index.jsp");
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
		
		String str = (String) session.getAttribute("message");
		if (str != null) {
			out.println("<h2><center><font color='red'>" + str + "</font></center></h2>");
			session.setAttribute("message", null);
		}
	%>
<table width=70%>	
<td>
<ul>
  <li><a href="back">Home</a></li>
  <li><a href="invoice">Create Invoice</a></li>
  <li><a href="change-page">Change Password</a></li>
  <li><a href="set-answer-page">Set answer for Security
				Question</a></li>
  <li><a href="details-page">Add Details</a></li>
  <li><a href="#about">About</a></li>
</ul>
	 
</td>

<td>
<h3>Fill Details Here</h3>
<form id='login-form' action="details" method="post">
  <input type="text" placeholder="Company Name" name="cname" required>
  <input type="text" placeholder="Company Address" name="caddress" required>
  <input type="text" placeholder="Billing Address" name="baddress" required>
  <!-- input type="file" placeholder="Logo" name="file" required> -->
  <button type='submit'>Submit</button>
</form>
</td>
</table>
</body>
</html>