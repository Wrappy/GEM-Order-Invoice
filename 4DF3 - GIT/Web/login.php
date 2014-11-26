<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>CSE | A1 Login</title>
<link href="styles/indexStyle.css" rel="stylesheet" type="text/css">
<script>var __adobewebfontsappname__="dreamweaver"</script><script src="http://use.edgefonts.net/source-sans-pro:n2,n4:default.js" type="text/javascript"></script>
</head>
<body>
<div id="mainWrapper">
  <header> 
	<div id="logo"> CSE </div>
    <div id="headerLinks"><a href="admin.html" title="Admin">Admin</a><a href="register.html" title="Register">Register</a></div>
  </header>
  <section id="title"> 
    <h1>A1 Report</h1>
    <p>Login</p>
  </section>
  <div id="content">
    <div class="mainContent">
      <form action="index.php" method="post">
      	
      	<input type="text"  id="username" name="username" placeholder="Username">
      	<input type="password"  id="password" name="password" placeholder="Password">
      	<input type="submit"  id="submit" value="Sign In">
      	
      	<?php
		    include 'Credentials.php';
			
			if (isset($_SESSION['login'])) {
				echo "Hi";
			}
			
			//$username = $_POST['username'];
			//$password = $_POST['password'];
			$username = "TestUser";
			
			$password = "testtest";
			$login = new Credentials();
			if ($login->login($username, $password)){
			
			echo "success";
			if (isset($_SESSION['login'])) {
					echo "Logged Out";
					session_destroy();
					header("location: index.php");
				}
			$login = $_SESSION['login'];
			$username = $_SESSION['username'];
			$admin = $_SESSION['admin'];
			echo '<body onload="document.myform.submit()">';
			echo '<form name="myform" action="Mainmenu.jsp" method="POST">';
			echo "<input type=\"hidden\" name=\"login\" value=\"$login\">";
			echo "<input type=\"hidden\" name=\"login\" value=\"$username\">";
			echo "<input type=\"hidden\" name=\"login\" value=\"$admin\">";
			//header("location: Mainmenu.jsp");
			}
			
			else {
			 echo "Wrong username or Password";
			}
      	?>
      </form>
    </div>
  </div>
</div>
</body>
</html>