<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>CSE | A1 Admin</title>
<link href="styles/adminStyle.css" rel="stylesheet" type="text/css">
<script>var __adobewebfontsappname__="dreamweaver"</script><script src="http://use.edgefonts.net/source-sans-pro:n2,n4:default.js" type="text/javascript"></script>
</head>
<body>
<div id="mainWrapper">
  <header> 
    <div id="logo"> CSE </div>
    <div id="headerLinks">
    <a href="main_menu.html">Main Menu</a><a href="index.html" title="Login">Logout</a></div>
  </header>
  <section id="title"> 
    <h1>A1 Report</h1>
    <p>Admin</p>
  </section>
  <div id="content">
    <div class="mainContent">
    <form action="admin.php" method="post">
	    <input type="text"  id="search" name="search" placeholder="Search">
	    <input type="submit"  id="submit" value="Search">
    </form>
    <fieldset>
    <legend>Personal Information</legend>
        <table align="center">

	<?php
		include_once "Database.php";
		if (isset($_SESSION['login'])) {
			if (isset($_POST['search'])) {
				$search = $_POST['search'];
				//$search = "TestUser";
				$database = new Database;
				$query = "SELECT * FROM user WHERE userID='$search'";
				$row = $database->getResults($query);
				$fname = $row['fname'];
				$lname = $row['lname'];
			    echo "<tr><td align=\"right\"><label class=\"field\" for=\"Name\">First Name: </label></td><td><input type=\"text\" value=\"$fname\"></td></tr>";
				echo "<tr><td align=\"right\"><label class=\"field\" for=\"Name\">Last Name: </label></td><td><input type=\"text\" value=\"$lname\"></td></tr>";
			    echo "<tr><td align=\"right\"><label class=\"field\" for=\"Name\">Address 1: </label></td><td><input type=\"text\" ></td></tr>";
			    echo "<tr><td align=\"right\"><label class=\"field\" for=\"Name\">Address 2: </label></td><td><input type=\"text\"></td></tr>";
			    echo "<tr><td align=\"right\"><label class=\"field\" for=\"Name\">City: </label></td><td><input type=\"text\"></td></tr>";
			    echo "<tr><td align=\"right\"><label class=\"field\" for=\"Name\">Province: </label></td><td><input type=\"text\"></td></tr>";
			    echo "<tr><td align=\"right\"><label class=\"field\" for=\"Name\">Postal Code: </label></td><td><input type=\"text\"></td></tr>";
			    echo "<tr><td align=\"right\"><label class=\"field\" for=\"Name\">Email: </label></td><td><input type=\"text\"></td></tr>";
			    echo "<tr><td align=\"right\"><label class=\"field\" for=\"Name\">Phone Number: </label></td><td><input type=\"text\"></td></tr>";
			    echo "<tr><td align=\"right\"><label class=\"field\" for=\"Name\">User Type: </label></td><td><input type=\"text\"></td></tr>";
			    }	    
		}

		else {
			header("location: /index.php");	
		}
    ?>
    </table>
    </fieldset>
    
      <input type="submit"  id="submit" value="Add">
      
      <input type="submit"  id="submit" value="Edit">
      
      <input type="submit"  id="submit" value="Delete">
      
    </div>
  </div>
  <footer> 
    <div> <p>Terms of Service</p></div>
    <div> <p>Disclaimer: By signing in, you agree to CSE's Terms of Service.</p> </div>
    <div class="footerlinks">
      <p><a href="#" title="Link">CSE</a></p>
      <p><a href="#" title="Link">Events</a></p>
      <p><a href="#" title="Link">Contact</a></p>
    </div>
  </footer>
</div>
</body>
</html>