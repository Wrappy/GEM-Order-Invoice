<?php
	include_once 'Database.php';
	include_once 'Credentials.php';
	class UserManagement {
		function addUser(/*string*/ $username, /*string*/ $password, /*string*/ $fname, /*string*/ $lname, /*string*/ $address1, /*string*/ $address2, /*string*/ $city, /*string*/ $prov, /*string*/ $postal, /*string*/ $email, /*string*/ $phone, /*string*/ $type) {
			$database = new Database;
			$con = $database->loginDatabase();
			
			if (mysqli_connect_errno($con)) {
				$message = "Failed to connect to MySQL: " . mysqli_connect_error();
			}
			
			else {
				$hash = new Credentials();
				$hash = $hash->hashPassword($password);
				$sql = "INSERT INTO user (userID, password, fname, lname, address1, address2, city, prov, postal, phone, email, type ) VALUES ('$username','$hash','$fname','$lname','$address1','$address2','$city','$prov','$postal','$phone','$email','$type')";
				
				if (!mysqli_query($con,$sql))
				{
					$message = 'Error: ' . mysqli_error($con);
				}
				$message = "1 record added";
			}
			return $message;
		}
		

		function verifyPassword(/*string*/ $username, /*string*/ $password) {
			
			$database = new Database;
			$con = $database->loginDatabase();
			
			if (mysqli_connect_errno($con)) {
				$message = "Failed to connect to MySQL: " . mysqli_connect_error();
			}
			else {
				$hash = new Credentials();
				$hash = $hash->hashPassword($password);
				$result = mysqli_query($con,"SELECT * FROM user WHERE userID='$username'");
				$row = mysqli_fetch_array($result);
				if ($row['password'] == $hash && $row['userID'] == $username) {
					echo "password $password hashed to $hash is valid for $username";
					return TRUE;
				}
				else {
					echo "Error for validating credentials";
					return FALSE;
				}

			}
		}
		function changePassword(/*string*/ $username, /*string*/ $password, /*string*/ $newPass) {
			$database = new Database;
			$con = $database->loginDatabase();
			if ($this->verifyPassword($username, $password)) {
				$hash = new Credentials();
				$hash = $hash->hashPassword($newPass);
				$sql = "UPDATE user SET password=$hash, WHERE userID=$username";
				if (!mysqli_query($con,$sql))
				{
					$message = 'Error: ' . mysqli_error($con);
				}
				$message = "1 record added";
				return TRUE;
			}
			else {
				echo "Error for validating credentials";
				return FALSE;
			}
			
			
		}
		
		function updateUser(/*string*/ $username, /*string*/ $fname, /*string*/ $lname, /*string*/ $address1, /*string*/ $address2, /*string*/ $city, /*string*/ $prov, /*string*/ $postal, /*string*/ $email, /*string*/ $phone, /*string*/ $type) {
			$database = new Database;
			$con = $database->loginDatabase();
			$sql = "UPDATE user SET fname=$fname, lname=$lname, address1=$address1, address2=$address2, city=$city, prov=$prov, postal=$postal, email=$email, phone=$phone, type=$type WHERE userID=$username";
			
			if (!mysqli_query($con,$sql))
			{
				$message = 'Error: ' . mysqli_error($con);
				return FALSE;
			}
			$message = "1 record added";
			return TRUE;
		}
		
		function deleteUser(/*string*/ $username) {
			$database = new Database;
			$con = $database->loginDatabase();
			$sql = "DELETE FROM user WHERE userID=$username";
			
			if (!mysqli_query($con,$sql))
			{
				$message = 'Error: ' . mysqli_error($con);
				return FALSE;
			}
			$message = "1 record added";
			return TRUE;
		}
		
		function createSession(/*string*/ $username) {
			session_start();
			$_SESSION['login'] = 1;
			$_SESSION['user'] = $username;
		}
	}
?>