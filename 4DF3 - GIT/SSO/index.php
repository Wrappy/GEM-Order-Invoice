<?php
	include_once "ldap.php";
	include_once "UserManagement.php";
	$username = $_SERVER['AUTH_USER'];
	echo $username;
	$ldap = new Ldap;
	$connect = $ldap->connectLdap();
	$ldap->bindLdap($connect);
	$info = $ldap->checkUser($connect);
	$ldap->findUser($info);
	
	//create session
	$userManagement = new UserManagement;
	$userManagement->createSession($username);
	
	//redirect to menu
	$login = $_SESSION['login'];
	$username = $_SESSION['username'];
	$admin = $_SESSION['admin'];
	echo '<body onload="document.myform.submit()">';
	echo '<form name="myform" action="Mainmenu.jsp" method="POST">';
	echo "<input type=\"hidden\" name=\"login\" value=\"$login\">";
	echo "<input type=\"hidden\" name=\"login\" value=\"$username\">";
	echo "<input type=\"hidden\" name=\"login\" value=\"$admin\">";
	//header("location: /CSE/Mainmenu.jsp");	
?>