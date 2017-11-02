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
	var price=0;
	var total1=0;
	var tax=0;
	var totalprice=0;
	var duedate=0;
	var invoiceId=0;
	var caddress=null;
	var baddress=null;
	function datefunction() {
		duedate = document.getElementById("ddate").value;
		document.getElementById("div1").innerHTML = "Due Date:" + duedate;
	}

	function changeFunc() {
		var selectBox = document.getElementById("idforselect").value;
		var xhttp = new XMLHttpRequest();
		  xhttp.onreadystatechange = function() {
		    if (this.readyState == 4 && this.status == 200) {
		    	selectBox=selectBox+" "+this.responseText;
		     document.getElementById("select").innerHTML = selectBox;
		    }
		  };
		  xhttp.open("GET", "selectAddress?nameforselect="+selectBox, true);
		  xhttp.send();
	}
	
	function changeFunc1() {
		var selectBox = document.getElementById("idforselect1").value;
		var xhttp = new XMLHttpRequest();
		xhttp.onreadystatechange = function(){
			if(this.readyState == 4 && this.status == 200){
				price=this.responseText;
				document.getElementById("td1").innerHTML = this.responseText;
				document.getElementById("select1").innerHTML = selectBox;
			}
		};
		xhttp.open("GET","selectPrice?nameforselect1="+selectBox, true);
		xhttp.send();
		
		
	}
	
	function changeFunc2(){
		var value = document.getElementById("count").value;
		total1=value*price;
		tax=value*price*0.18;
		totalprice=total1+tax;
		document.getElementById("td2").innerHTML = total1;
		document.getElementById("td3").innerHTML = tax;
		document.getElementById("td4").innerHTML = totalprice;
		
	}
	
	function saveInvoice() {
		var xhttp = new XMLHttpRequest();
		xhttp.onreadystatechange = function(){
			if(this.readyState == 4 && this.status == 200){
				invoiceId=this.responseText;
				saveInvoice1(invoiceId);
			}
		};
		xhttp.open("POST","getCurrentInvoiceId", true);
		xhttp.send();
	}
	
	function saveInvoice1(){
		var xhttp = new XMLHttpRequest();
		var Row = document.getElementById("somerow");
		var Cells = Row.getElementsByTagName("td");
		alert(Cells[0].innerText);
		caddress=Cells[0].innerText;
		baddress=Cells[1].innerText;
		alert(Cells[1].innerText);
		xhttp.onreadystatechange = function(){
			if(this.readyState == 4 && this.status == 200){
				document.getElementById("save").innerHTML = this.responseText;
			}
		};
		xhttp.open("GET","saveInvoice?id="+invoiceId+"&duedate="+duedate+"&caddress="
				+caddress+"&baddress="+baddress+"&totalprice="+totalprice, true);
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
							<td>Company </td>
							<td>Billing/Shipping Address</td>
						</tr>
						<tr id="somerow">
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
								<div id="select">Select Company Name<select id='idforselect' name='nameforselect' onchange='changeFunc()'>
								<option value='' ></option>
								<%for(String l:lm1){
									l=l.replaceAll("\\s+","&nbsp");
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
				<td>GST(18%)</td>
			</tr>
			<tr class="item"><td>
			<%
			HashMap<String,Object> hmap1=(HashMap<String,Object>)request.getAttribute("model");
			List<String> lm2=(List<String>)model.get("flist3");	
			System.out.println("lm2:"+lm2);%>
			<div id="select1">Select item :<select id='idforselect1' name='nameforselect1' onchange='changeFunc1()'>
			<option value='' ></option>
			<%for(String l:lm2){
				l=l.replaceAll("\\s+","&nbsp");
			out.print("<option value=" +l+ ">"+l+"</option>");
			}%></select></td>
			</div>
			<td id="td1">0</td>
			<td><input type="number" name="count" id="count" onchange="changeFunc2()"></td>
			<td id="td2"></td>
			<td id="td3"></td>
			
			</tr>
			<!-- <tr class="item">
				<td>Design Services_businness</td>
				<td>300.00</td>
				<td>5</td>
				<td>2000</td>
				<td>100.00</td>
			</tr> -->

<!-- 			<tr class="item">
				<td>Additional Concepts</td>
				<td>75.00</td>
				<td>5</td>
				<td>2000</td>
				<td>100.00</td>
			</tr> -->

			<!-- <tr class="item last">
				<td>Domain name (1 year)</td>

				<td>10.00</td>
			</tr>
 -->
			<tr class="total">
				<td>Total: </td>
				<td></td>
				<td></td>
				<td></td>

				<td id="td4"></td>
			</tr>
		</table>
	</div>
	<form action="logout" method="post">
		<input type="submit" value="Logout" id="button">
	</form>
	<div id="save"><input type="submit" name="save" value="save" onclick="saveInvoice()"/></div>
	<input type="button" onClick="window.print()" value="Print This Page" />
</body>
</html>