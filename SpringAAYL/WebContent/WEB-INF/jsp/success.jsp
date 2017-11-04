<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>InvoiceHelper</title>
<link rel="stylesheet" href="/SpringAAYL/resources/css/success.css">
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
	<h2>Welcome ${msg}</h2>
<ul>
  <li><a href="back">Home</a></li>
  <li><a href="invoice">Create Invoice</a></li>
  <li><a href="change-page">Change Password</a></li>
  <li><a href="set-answer-page">Set answer for Security
				Question</a></li>
  <li><a href="details-page">Add Details</a></li>
</ul>
	<form action="logout" method="post">
		<input type="submit" value="Logout" id="button">
	</form> 

</body>
</html>