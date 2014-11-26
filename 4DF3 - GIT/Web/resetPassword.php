<?php
	include_once 'Database.php';
	class ResetPassword {
		protected $username = "";
		
		public function __construct(/*string*/ $user) {
			$this->username = $user;
			
			//check username is valid
			if ($this->checkUsername($this->$username)) {
			}
			else { return $false; }
		}
		
		protected function checkUsername(/*string*/ $user) {
			
			$database = new Database;
			$database->loginDatabase();
			$query = "SELECT * FROM user WHERE userID='$this->username'";
			
			//find out if username exhists
			$result = $database->getResults($query);
			if ($result == $null) {
				return $false;
			}
			else {
				$email = $result['email'];
				$this->emailUser($this->username, $email);
				return $true;
			}
		}
		
		protected function emailUser(/*string*/ $username, /*string*/ $email) {
			$message = "Testing email";
			$to = $email;
			$subject = "Testing Email!";
			$headers = 'From: test@aethnet.com' . "\r\n";
			
			mail($to,$subject,$message,$headers);
		}
		
		protected function generateCode(/*string*/ $username) {
			
		}
	}
		
		