<%-- 
    Document   : ClientScreen
    Created on : Nov 9, 2014, 4:19:57 PM
    Author     : Gord
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>CSE | Client Screen</title>
<link href="styles/aboutPageStyle.css" rel="stylesheet" type="text/css">

<!--The following script tag downloads a font from the Adobe Edge Web Fonts server for use within the web page. We recommend that you do not modify it.-->
<script>var __adobewebfontsappname__="dreamweaver"</script><script src="http://use.edgefonts.net/montserrat:n4:default;source-sans-pro:n2:default.js" type="text/javascript"></script>
</head>
<body>
<!-- Header content -->
<header>
  <div class="profileLogo">
    <!-- Profile logo. Add a img tag in place of <span>. -->
	<label>Search</label><input type="text" name="txtSearch"></input><button type="button">Search</button>
  </div>
  <div class="profilePhoto">
    <!-- Profile photo -->
      <img src="images/profilephoto.png" alt="sample">
  </div>
  <!-- Identity details -->
  <div class="profileHeader">
  	<table width="50%">
  		<tr>
  			<td colspan="2">
                            <button type="button" style="width:24%;">&lt;</button>
			    <button type="button" style="width:24%;">&gt;</button>
			    <button type="button" style="width:48%;">Commit Change</button>
        	</td>
  		</tr>
  		<tr>
  			<td align="right">
                            <label>Client Code</label>
  			</td>
  			<td>
  				<input type="text" name="txtClientCode" value="SNPP01" style="width:99%;"></input>
  			</td>
  		</tr>
		<tr>
  			<td align="right">
  				<label>Client Name</label>
  			</td>
  			<td>
  				<input type="text" name="txtClientName" value="Springfield Nuclear Power Plant" style="width:99%;"></input>
  			</td>
  		</tr>
  		<tr>
			<td align="right">
				<label>Contact Person</label>
			</td>
			<td>
				<input type="text" name="txtContactPerson" value="Montgomery Burns" style="width:99%;"></input>
			</td>
  		</tr>
  		<tr>
			<td align="right">
				<label>Job Title</label>
			</td>
			<td>
				<input type="text" name="txtTitle" value="Plant Manager" style="width:99%;"></input>
			</td>
  		</tr>
  		<tr>
  			<td colspan="2" align="center">
  				<input type="Checkbox" name="chkActive" checked="true">Active</input>
  			</td>
  		</tr>
  	</table>
    <hr>
  </div>
</header>
<!-- content -->
<div class="mainContent">
  <!-- Contact details -->
  <section class="section1">
    <h2 class="sectionTitle">Client Details</h2>
    <hr class="sectionTitleRule">
    <hr class="sectionTitleRule2">
    <div class="section1Content">
      <table width=100%>
      	<tr>
      		<td align="right">
      			<label><span>Address :</span></label>
      		</td>
      		<td>
      			<input type="text" name="txtAddress1" value="123 Fake St." style="width:99%;"></input>
      		</td>
      	</tr>
      	<tr>
			<td align="right">
			</td>
			<td>
				<input type="text" name="txtAddress2" value="Unit #1" style="width:99%;"></input>
			</td>
      	</tr>
      	<tr>
			<td align="right">
			</td>
			<td>
				<input type="text" name="txtCity" value="Toronto" style="width:59%;"></input>
				<input type="text" name="txtProv" value="ON" style="width:10%;"></input>
				<input type="text" name="txtPostal" value="A1A 1A1" style="width:28%;"></input>
			</td>
      	</tr>
      	<tr>
			<td align="right">
				<label><span>Tel :</span></label>
			</td>
			<td>
				<input type="text" name="txtTel" value="416-111-1111" style="width:99%;"></input>
			</td>
      	</tr>
      	<tr>
			<td align="right">
				<label><span>Fax :</span></label>
			</td>
			<td>
				<input type="text" name="txtFax" value="416-111-1112" style="width:99%;"></input>
			</td>
      	</tr>
      	<tr>
			<td align="right">
				<label><span>Web</span></label>
			</td>
			<td>
				<input type="text" name="txtWeb" value="www.google.com" style="width:69%;"></input><button type="button" style="width:29%;">Go</button>
			</td>
      	</tr>
      	<tr>
			<td align="right">
				<label><span>Email</span></label>
			</td>
			<td>
				<input type="text" name="txtWeb" value="test@test.com" style="width:69%;"></input><button type="button" style="width:29%;">Email</button>
			</td>
      	</tr>
		<tr>
			<td align="right">
				<label><span>Rep</span></label>
			</td>
			<td>
				<select name="cmbRep" style="width:44%;">
					<option selected value="GC">Gord Coyle</option>
				</select>
				<label style="width:20%;"><span>Tech</span></label>
				<select name="cmbTech" style="width:44%;">
					<option selected value="GC">Gord Coyle</option>
				</select>
			</td>
      	</tr>
      </table>
    </div>
  </section>
  <!-- Previous experience details -->
  <section class="section2">
    <h2 class="sectionTitle">Notes</h2>
    <hr class="sectionTitleRule">
    <hr class="sectionTitleRule2">
    <!-- First Title & company details  -->
    <div class="section2Content">
		<textarea style="width:100%;" rows="10" name="mmonotes">Notes Go Here</textarea>
    </div>
    <!-- Replicate the above Div block to add more title and company details -->
  </section>
  <!-- Links to expore your past projects and download your CV -->
  <div class="externalResourcesNav">
    <div class="externalResources"><a href="quote_screen.html" title="Quote Screen">Quote Screen</a> </div>
    <span class="stretch"></span>
    <div class="externalResources"><a href="invoice_screen.html" title="Invoice Screen">Invoice Screen</a> </div>
  </div>
</div>
<footer>
  <hr>
  <p class="footerDisclaimer">A1 Software: <span>All Rights Reserved</span></p>
  <p class="footerNote">Hello, <label>Michael</label> <span>Logout</span></p>
</footer>
</body>
</html>

