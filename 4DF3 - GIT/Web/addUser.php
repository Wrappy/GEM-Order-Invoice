<?php
	include_once 'UserManagement.php';
	$username = $_POST['username'];
	$password = $_POST['password'];
	$fname = $_POST['fname'];
	$lname = $_POST['lname'];
	/*$address1 = $_POST['address1'];
	$address2 = $_POST['address2'];
	$city = $_POST['city'];
	$prov = $_POST['prov'];
	$postal = $_POST['postal'];
	$phone = $_POST['phone'];
	$email = $_POST['email'];
	$type = $_POST['type'];
	$active = $_POST['active'];
	
	$username = "TestUser";
	$password = "testtest";
	$fname = "user";
	$lname = "lname";
	$address1 = "";
	$address2 = "";
	$city = "";
	$prov = "";
	$postal = "";
	$phone = "";
	$email = "";
	$type = "";
	$active = "";*/
	
	
	$addNewUser = new UserManagement;
	
	$addingUser = $addNewUser->addUser($username, $password, $fname, $lname, $address1, $address2, $city, $prov, $postal, $email, $phone, $type)
?>