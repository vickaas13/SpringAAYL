<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*"%>
<%@ page import="javax.servlet.*,java.text.*"%>
<%@ page import="com.dao.*"%>
<%@ page import="com.controller.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>InvoiceHelper</title>

<link rel="stylesheet" href="/SpringAAYL/resources/css/success.css">
<link rel="stylesheet" href="/SpringAAYL/resources/css/invoice.css">

<script type="text/javascript" language="javascript">
	$(function() {
		$("#datepicker").datepicker({
			showOn : "both",
			buttonImage : "image.jpg",
			dateFormat : "yy-mm-dd",
			buttonImageOnly : false,
			minDate : +0, //you do not want to show previous date.
			maxDate : +0
		// you do not want to show next day.
		});
	});

	function datefunction() {
		var duedate = document.getElementById("ddate").value;
		document.getElementById("div1").innerHTML = "Due Date:" + duedate;
	}

	function changeFunc() {
		var selectBox = document.getElementById("idforselect").value;
		//alert(selectBox);
		var xhttp = new XMLHttpRequest();
		  xhttp.onreadystatechange = function() {
		    if (this.readyState == 4 && this.status == 200) {
		  //  	alert(this.responseText);
		     document.getElementById("demo").innerHTML = this.responseText;
		    }
		  };
		  
		  
		  xhttp.open("GET", "selectAddress?nameforselect="+selectBox, true);
		  xhttp.send();
	}
</script>

</head>

<body>
	<h3>
		</h3>
	<ul>
  	<li><a href="back">Home</a></li>
  	<li><a href="invoice">Create Invoice</a></li>
 	 <li><a href="change-page">Change Password</a></li>
 	 <li><a href="set-answer-page">Set answer for Security
				Question</a></li>
 	 <li><a href="details-page">Add Details</a></li>
 	 <li><a href="#about">About</a></li>
	</ul>
	
	<div class="invoice-box">
		<table cellpadding="0" cellspacing="0">
			<tr class="top">
				<td colspan="5">
					<table>
						<tr>
							<td class="title"><img
								src="/SpringAAYL/resources/images/sp.jpg"
								style="width: 50%; max-width: 300px;"></td>
							<td>Invoice #: 1<br> Created: <%
								java.util.Date dNow = new java.util.Date();
								SimpleDateFormat ft = new SimpleDateFormat("E yyyy.MM.dd 'at' hh:mm:ss a zzz");
								out.print("<b>" + ft.format(dNow) + "</b>");
							%><br>
								<div id="div1">
									<form action="">
										Due Date:<input type="date" name="ddate" id="ddate"><input
											type="submit" onclick="datefunction()">
									</form>
								</div>
							</td>
						</tr>
					</table>
				</td>
			</tr>

			<tr class="information">
				<td colspan="5">
					<table>
						<tr class="heading">
							<td>Company Address</td>
							<td>Billing/Shipping Address</td>
						</tr>
						<tr>
							<td>
							<%
 						 	HashMap<String,Object> model=(HashMap<String,Object>)request.getAttribute("model");
							List<Map> lm=(List<Map>)model.get("flist1");
							for(Map l:lm){
							String str = (String) l.get("f1")+" "+l.get("f2")+" "+l.get("f3");
							out.print("<b>" + str + "</b>");
							}
							
 							%>
							</td>

							<td>
								<%
								HashMap<String,Object> hmap=(HashMap<String,Object>)request.getAttribute("model");
								List<String> lm1=(List<String>)model.get("flist2");%>
								<div id="demo"><select id='idforselect' name='nameforselect' onchange='changeFunc()'>
								<option value='' ></option>
								<%for(String l:lm1){
								out.print("<option value=" +l+ ">"+l+"</option>");
								}%>
								</select>
								</div>
								
								


							</td>
						</tr>
					</table>
				</td>
			</tr>

			<!-- tr class="heading">
				<td>Payment Method</td>
				<td></td>
				<td></td>
				<td></td>
				<td>Check #</td>
			</tr> 

			<tr class="details">
				<td>Check</td>
				<td></td>
				<td></td>
				<td></td>
				<td>1000</td>
			</tr>-->

			<tr class="heading">
				<td>Item</td>
				<td>Price(Rs)</td>
				<td>Qty</td>
				<td>Total</td>
				<td>Tax</td>
			</tr>

			<tr class="item">
				<td>Design Services_businness</td>
				<td>300.00</td>
				<td>5</td>
				<td>2000</td>
				<td>100.00</td>
			</tr>

			<tr class="item">
				<td>Addiotional Concepts</td>
				<td>75.00</td>
				<td>5</td>
				<td>2000</td>
				<td>100.00</td>
			</tr>

			<tr class="item last">
				<td>Domain name (1 year)</td>

				<td>10.00</td>
			</tr>

			<tr class="total">
				<td></td>
				<td></td>
				<td></td>
				<td></td>

				<td>Total: 385.00</td>
			</tr>
		</table>
	</div>
	<form action="logout" method="post">
		<input type="submit" value="Logout" id="button">
	</form>
	<input type="button" onClick="window.print()" value="Print This Page" />
</body>
</html>