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
	header("location: /CSE/Mainmenu.jsp");	
?>