<?php
	include_once 'Database.php';
	include_once 'Credentials.php';
	class UserManagement {
		function addUser(/*string*/ $username, /*string*/ $password, /*string*/ $fname, /*string*/ $lname, /*string*/ $address1, /*string*/ $address2, /*string*/ $city, /*string*/ $prov, /*string*/ $postal, /*string*/ $email, /*string*/ $phone, /*string*/ $type) {
			$database = new Database;
			$connect = $database->loginDatabase();
			
			if (mysqli_connect_errno($connect)) {
				$message = "Failed to connect to MySQL: " . mysqli_connect_error();
			}
			
			else {
				$hash = new Credentials();
				$hash = $hash->hashPassword($password);
				$sql = "INSERT INTO user (userID, password, fname, lname, address1, address2, city, prov, postal, phone, email, type ) VALUES ('$username','$hash','$fname','$lname','$address1','$address2','$city','$prov','$postal','$phone','$email','$type')";
				
				if (!mysqli_query($connect,$sql))
				{
					$message = 'Error: ' . mysqli_error($connect);
				}
				$message = "1 record added";
			}
			return $message;
		}
		

		function verifyPassword(/*string*/ $username, /*string*/ $password) {
			
			$database = new Database;
			$connect = $database->loginDatabase();
			
			if (mysqli_connect_errno($connect)) {
				$message = "Failed to connect to MySQL: " . mysqli_connect_error();
			}
			else {
				$hash = new Credentials();
				$hash = $hash->hashPassword($password);
				$result = mysqli_query($con,"SELECT * FROM user WHERE userID='$username'");
				$row = mysqli_fetch_array($result);
				if ($row['password'] == $hash && $row['userID'] == $username) {
					echo "password $password hashed to $hash is valid for $username";
					return true;
				}
				else {
					echo "Error for validating credentials";
					return false;
				}

			}
		}
		function changePassword(/*string*/ $username, /*string*/ $password, /*string*/ $newPass) {
			$database = new Database;
			$connect = $database->loginDatabase();
			if ($this->verifyPassword($username, $password)) {
				$hash = new Credentials();
				$hash = $hash->hashPassword($newPass);
				$sql = "UPDATE user SET password=$hash, WHERE userID=$username";
				if (!mysqli_query($connect,$sql))
				{
					$message = 'Error: ' . mysqli_error($connect);
				}
				$message = "1 record added";
				return true;
			}
			else {
				echo "Error for validating credentials";
				return false;
			}
			
			
		}
		
		function updateUser(/*string*/ $username, /*string*/ $fname, /*string*/ $lname, /*string*/ $address1, /*string*/ $address2, /*string*/ $city, /*string*/ $prov, /*string*/ $postal, /*string*/ $email, /*string*/ $phone, /*string*/ $type) {
			$database = new Database;
			$connect = $database->loginDatabase();
			$sql = "UPDATE user SET fname=$fname, lname=$lname, address1=$address1, address2=$address2, city=$city, prov=$prov, postal=$postal, email=$email, phone=$phone, type=$type WHERE userID=$username";
			
			if (!mysqli_query($connect,$sql))
			{
				$message = 'Error: ' . mysqli_error($connect);
				return false;
			}
			$message = "1 record added";
			return true;
		}
		
		function deleteUser(/*string*/ $username) {
			$database = new Database;
			$connect = $database->loginDatabase();
			$sql = "DELETE FROM user WHERE userID=$username";
			
			if (!mysqli_query($connect,$sql))
			{
				$message = 'Error: ' . mysqli_error($connect);
				return false;
			}
			$message = "1 record added";
			return true;
		}
		
		function createSession(/*string*/ $username) {
			$_SESSION['Login'] = 1;
			$_SESSION['User'] = $username;	
		}
	}
?>