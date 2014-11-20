<?php

	include_once 'UserManagement.php';
	$username = $_POST['username'];
	$password = $_POST['password'];
	
	$changePassword = new UserManagement;
	
	if ($changePassword->verifyPassword) {
		$changePassword->changePassword;
	}
	
	else {
		//password is invalid
	}
	
?>