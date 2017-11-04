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
		setInvoiceId();
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
		document.getElementById("td12").innerHTML = tax/2;
		document.getElementById("td13").innerHTML = tax/2;
		document.getElementById("td4").innerHTML = totalprice;
		
	}
	function saveInvoice3(){
		var Row = document.getElementById("somerow");
		var Cells = Row.getElementsByTagName("td");
		baddress=Cells[1].innerText;
		//out.println("bill address"+baddress);
		if(duedate==0){
			alert("Set a Due Date");
			alert(baddress);
		}
		else if (baddress.match("^Select"))
			alert("Select Billing Address");
		else if(totalprice==0)
			alert("Add an Item");
		else
			saveInvoice();
	}
	
	function saveInvoice(){
		var xhttp = new XMLHttpRequest();
		var Row = document.getElementById("somerow");
		var Cells = Row.getElementsByTagName("td");
		caddress=Cells[0].innerText;
		baddress=Cells[1].innerText;
		xhttp.onreadystatechange = function(){
			if(this.readyState == 4 && this.status == 200){
				document.getElementById("save").innerHTML = this.responseText;
			}
		};
		xhttp.open("GET","saveInvoice?id="+invoiceId+"&duedate="+duedate+"&caddress="
				+caddress+"&baddress="+baddress+"&totalprice="+totalprice, true);
		xhttp.send();
	}
	function setInvoiceId(){
		var s = document.getElementById("td15").innerHTML;
		var xhttp = new XMLHttpRequest();
		xhttp.onreadystatechange = function(){
			if(this.readyState == 4 && this.status == 200){
				invoiceId=this.responseText;
				var x = "Invoice #:"+invoiceId;
				s=x+s;
				document.getElementById("td15").innerHTML=s;
			}
		};
		xhttp.open("POST","getCurrentInvoiceId", true);
		xhttp.send();
	}