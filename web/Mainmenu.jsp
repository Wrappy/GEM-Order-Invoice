<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta charset="utf-8">
<title>CSE | Main Menu</title>
<link href="styles/eCommerceStyle.css" rel="stylesheet" type="text/css">

<!--The following script tag downloads a font from the Adobe Edge Web Fonts server for use within the web page. We recommend that you do not modify it.-->
<script>var __adobewebfontsappname__="dreamweaver"</script><script src="http://use.edgefonts.net/montserrat:n4:default;source-sans-pro:n2:default.js" type="text/javascript"></script>
</head>

<body>
<div id="mainWrapper">
  <header>
    <!-- This is the header content. It contains Logo and links -->
    <div id="logo">
      <!-- Company Logo text -->
      CSE </div>
    <div id="headerLinks"><a href="#" title="Login/Register">Hello, <% %></a><a href="#" title="Cart">Logout</a></div>
  </header>
  <section id="offer">
    <!-- The offer section displays a banner text for promotions -->
    <h1>A1 Software</h1>
    <p>Main Menu</p>
  </section>
  <div id="content">
    <nav class="sidebar">

      <div id="menubar">
        <div class="menu">

        </div>
        <div class="menu">

        </div>
      </div>
    </nav>
    <div class="mainContent">
      <div class="productRow"><!-- Each row contains info of 3 elements -->
        <div class="productInfo"><!-- Each individual menu item -->
          <div><img alt="sample" src="images/client.png"></div>
          <p class="price">&nbsp;</p>
          <p class="productContent">&nbsp;</p>
          <input type="button" name="button" value="Client Screen" class="buyButton" onclick="window.open('ClientScreen.jsp?hdnAction=V','_blank'); return false;">
        </div>
        <div class="productInfo"><!-- Each individual product description -->
          <div><img alt="sample" src="images/quote.png"></div>
          <p class="price">&nbsp;</p>
          <p class="productContent">&nbsp;</p>
          <input type="button" name="button" value="Quote Screen" class="buyButton" onclick="window.open('QuoteScreen.jsp?hdnAction=V','_blank'); return false;">
        </div>
        <div class="productInfo"> <!-- Each individual product description -->
          <div><img alt="sample" src="images/invoice.png"></div>
          <p class="price">&nbsp;</p>
          <p class="productContent">&nbsp;</p>
          <input type="button" name="button" value="Invoice Screen" class="buyButton" onclick="window.open('InvoiceScreen.jsp?hdnAction=V','_blank'); return false;">
        </div>
      </div>
    </div>
  </div>
  <footer>

  </footer>
</div>
</body>
</html>
