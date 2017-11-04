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
<script type="text/javascript" src="/SpringAAYL/resources/js/invoice.js"></script>

</head>

<body>
	<h3 color:green> Welcome ${msg}</h3>
	<ul>
  	<li><a href="back">Home</a></li>
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
							<td id="td15"><br> Created : <%
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
			<tr class="heading">
				<td>Item</td>
				<td>Price(Rs)</td>
				<td>Qty</td>
				<td>Total Price</td>
				<td>GST(18%)</td>
			</tr>
			<div id="divadd">
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
			<td id="td2">0</td>
			<td id="td3">0</td>
			</tr><div>
			
			<tr><td><hr></td><td><hr></td><td><hr></td><td><hr></td><td><hr></td></tr>
 			
 			<tr class="total">
				<td></td>
				<td></td>
				<td>CGST: </td>
				<td></td>

				<td id="td12">9%</td>
			</tr>
			<tr class="total">
				<td></td>
				<td></td>
				<td>SGST: </td>
				<td></td>

				<td id="td13">9%</td>
			</tr>
			<tr class="total">
				<td></td>
				<td></td>
				<td>Total(Total Price + GST): </td>
				<td></td>

				<td id="td4">0</td>
			</tr>
		</table>
	</div>
	<form action="logout" method="post">
		<input type="submit" value="Logout" id="button">
	</form>
	<center><div id="save"><input type="submit" name="save" value="save" onclick="saveInvoice3()"/></div>
	<input type="button" onClick="window.print()" value="Print This Page" /></center>
</body>
</html>