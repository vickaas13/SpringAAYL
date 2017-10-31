<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>InvoiceHelper</title>
<link 	rel="stylesheet" href="/SpringAAYL/resources/css/style1.css">
</head>
<body background="/SpringAAYL/resources/images/wallpaper.jpeg">
	<h3>Welcome to password reset wizard</h3>
	<form id="login-form" action="change-password" method=POST>
		<input type=text size=20 placeholder="email" name="email1" required>
		<input type=password placeholder="password" size=20 name="opass" required>
		<input type=password size=20 name="npass" placeholder="new password" required>
		<input type=submit value="Submit">
		<a href="back">back to home</a>
	</form>
</body>
</html>