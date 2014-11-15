<%-- 
    Document   : InvoiceScreen.jsp
    Created on : Nov 9, 2014, 4:26:35 PM
    Author     : Gord
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>CSE | Invoice Screen</title>
<link href="styles/blogPostStyle.css" rel="stylesheet" type="text/css">
<!--The following script tag downloads a font from the Adobe Edge Web Fonts server for use within the web page. We recommend that you do not modify it.--><script>var __adobewebfontsappname__="dreamweaver"</script><script src="http://use.edgefonts.net/source-sans-pro:n2,n4:default.js" type="text/javascript"></script>
</head>

<body>
<div id="mainwrapper">
	<header id="top">
    	<div id="logo">Logo</div>
    		<nav id="mainnav">
            	<ul>
                	<li>Welcome, <label>Michael</label></li>
                    <li><a href="#">Logout</a></li>
                </ul>
    		</nav>
  	</header>
<div id="content">
	<div class="notOnDesktop">
    <!-- This search box is displayed only in mobile and tablet laouts and not in desktop layouts -->
    	<input type="text" placeholder="Search">
    </div>
    <section id="mainContent">
    <!--************************************************************************
    Main content starts here
    ****************************************************************************-->
		<h1><!-- Title -->Invoice Screen</h1>
      	<h3><!-- Tagline -->Client Details</h3>
        <div id="bannerImage">
        	<table border="0" width="100%">
        		<tr>
        			<td colspan="4">
        				<button type="button" style="width:24%;">&lt;</button>
        				<button type="button" style="width:24%;">&gt;</button>
        				<button type="button" style="width:24%;">Print</button>
        				<button type="button" style="width:24%;">Email</button>
        			</td>
        		</tr>
        		<tr>
        			<td align="right"><b>Code: </b></td>
        			<td><input type="text" name="txtCode" style="width:99%;" value="SNPP01"></input></td>
        			<td align="center"><b>Client Details</b></td>
        			<td><button type="button" style="width:100%;">Add</button></td>
        		</tr>
        		<tr>
        			<td align="right"><b>Name: </b></td>
        			<td colspan="3"><input type="text" name="txtName" style="width:99%;" value = "Springfield Nuclear Power Plant"></input></td>
        		</tr>
        		<tr>
        			<td align="right"><b>Address: </b></td>
        			<td colspan="3"><input type="text" name="txtAddress1" style="width:99%;" value="123 Fake St."></input></td>
        		</tr>
        		<tr>
        			<td align="right"></td>
        			<td colspan="3"><input type="text" name="txtAddress2" style="width:99%;" value="Unit #1"></input></td>
        		</tr>
        		<tr>
        			<td align="right"><b>City: </b></td>
        			<td colspan="3">
        				<input type="text" name="txtCity" style="width:50%;" value="Toronto"></input>
        				<b><label style="width:10%">Prov: </label></b>
        				<input type="text" name="txtProv" style="width:10%;" value="ON"></input>
        				<b><label style="width:5%">PC: </label></b>
        				<input type="text" name="txtPC" style="width:24%;" value="A1A 1A1"></input>
        			</td>
        		</tr>
				<tr>
        			<td align="right"><b>Attn: </b></td>
        			<td colspan="3"><input type="text" name="txtAttn" style="width:99%;" value="Montgomery Burns"></input></td>
        		</tr>
				<tr>
        			<td align="right"><b>Email: </b></td>
        			<td colspan="3"><input type="text" name="txtEmail" style="width:69%;" value="test@test.com"></input><button type="button" style="width:29%;">Email</button></td>
        		</tr>
				<tr>
        			<td align="right"><b>Tel: </b></td>
        			<td colspan="3">
        				<input type="text" name="txtTel" style="width:49%;" value="416-111-1111"></input>
        				<b><label style="width:5%">Fax: </label></b>
        				<input type="text" name="txtFax" style="width:43%;" value="416-111-1112"></input>
        			</td>
        		</tr>
				<tr>
        			<td align="right"><b>Staff: </b></td>
        			<td colspan="3">
        				<select name="cmbStaff" style="width:49%;">
        					<option selected value="GC">Gord Coyle</option>
        				</select>
        				<input type="checkbox" name="chkActive" checked="true"></input><b>Active</b><button type="button">Commit Change</button>
        			</td>
        		</tr>
        	</table>
        </div>
        	<section id="authorInfo">
      		<!-- The invoice description information is contained here -->
        		<h3>Invoice Description</h3>
        		<table border="0" width="100%">
        			<thead>
        				<tr>
        					<th><b>#</b></th>
        					<th><b>Code</b></th>
        					<th><b>Tech</b></th>
        					<th><b>Desc</b></th>
        					<th><b>Qty</b></th>
        					<th><b>Price</b></th>
        					<th><b>/</b></th>
        					<th><b>Amount</b></th>
        					<th><b>Cost</b></th>
        				</tr>
        			</thead>
        			<tbody>
        				<tr>
        					<th><b>1</b></th>
        					<td><input type="text" name="data[0][iCode]" style="width:99%;" value="SNPP01_01_01"></input></td>
        					<td>
        						<select name="data[0][iTech]" style="width:99%;">
        						<option selected value="GC">Gord Coyle</option>
        						</select>
        					</td>
        					<td><input type="text" name="data[0][iDesc]" style="width:99%;" value="On Site Work"></input></td>
        					<td><input type="text" name="data[0][iQty]" style="width:99%;text-align:right;" value="6"></input></td>
        					<td><input type="text" name="data[0][iPrice]" style="width:99%;" style="width:99%;text-align:right;" value="10.50"></input></td>
        					<td><input type="text" name="data[0][iUnit]" style="width:99%;" value="hr"></input></td>
        					<td><input type="text" name="data[0][iAmount]" style="width:99%;text-align:right;" value=""></input></td>
        					<td style="text-align:right;"><label style="width:99%;text-align:right;">63.00</label></td>
        				</tr>
        				<tr>
        					<th><b>2</b></th>
        					<td><input type="text" name="data[0][iCode]" style="width:99%;" value="SNPP01_01_02"></input></td>
        					<td>
        						<select name="data[0][iTech]" style="width:99%;">
        						<option selected value="GC">Gord Coyle</option>
        						</select>
        					</td>
        					<td><input type="text" name="data[0][iDesc]" style="width:99%;" value="Server"></input></td>
        					<td><input type="text" name="data[0][iQty]" style="width:99%;text-align:right;" value="2"></input></td>
        					<td><input type="text" name="data[0][iPrice]" style="width:99%;" style="width:99%;text-align:right;" value=""></input></td>
        					<td><input type="text" name="data[0][iUnit]" style="width:99%;" value=""></input></td>
        					<td><input type="text" name="data[0][iAmount]" style="width:99%;text-align:right;" value="200.00"></input></td>
        					<td style="text-align:right;"><label style="width:99%;text-align:right;">400.00</label></td>
        				</tr>
        				<tr>
        					<th><b>3</b></th>
        					<td><input type="text" name="data[0][iCode]" style="width:99%;" value=""></input></td>
        					<td>
        						<select name="data[0][iTech]" style="width:99%;">
        						<option value="GC">Gord Coyle</option>
        						</select>
        					</td>
        					<td><input type="text" name="data[0][iDesc]" style="width:99%;" value=""></input></td>
        					<td><input type="text" name="data[0][iQty]" style="width:99%;text-align:right;" value=""></input></td>
        					<td><input type="text" name="data[0][iPrice]" style="width:99%;" style="width:99%;text-align:right;" value=""></input></td>
        					<td><input type="text" name="data[0][iUnit]" style="width:99%;" value=""></input></td>
        					<td><input type="text" name="data[0][iAmount]" style="width:99%;text-align:right;" value=""></input></td>
        					<td style="text-align:right;"><label style="width:99%;text-align:right;"></label></td>
        				</tr>
        				<tr>
        					<td colspan="9"><button type="button">&lt;</button><button type="button">&gt;</button><button type="button">New Invoice</button><button type="button">Commit</button></td>
        				</tr>
        			</tbody>
        		</table>
      		</section>
    </section>
    <aside id="sidebar">
    <!--************************************************************************
    Sidebar starts here. It contains a searchbox, A1 logo image and 6 links
    ****************************************************************************-->
      	<input type="text" placeholder="Search">
      	<div id="adimage"><img src="images/A1 Logo.jpg" alt=""/></div>
      	<nav>
        	<ul>
          		<li><a href="client_screen.html" title="Link">Client Screen</a></li>
          		<li><a href="quote_screen.html" title="Link">Quote Screen</a></li>
        	</ul>
      	</nav>
   	</aside>
    <footer>
    <!--************************************************************************
    Footer starts here
    ****************************************************************************-->
    	<article>
          	<h3>Followup Comments</h3>
          	<textarea name="mmoComments" style="width:99%;" rows=10>
          	</textarea>
        </article>
 	</footer>
</div>
	<div id="footerbar"><!-- Small footerbar at the bottom --></div>
</div>
</body>
</html>
