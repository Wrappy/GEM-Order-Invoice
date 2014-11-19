<?php

	class Credentials {
		
		private $salt = "newsalt";
		
		public function hashPassword(/*string*/ $password) {
			
			$output = crypt($password, $this->salt);
			return $output;
			
		}
		
		public function login(/*string*/$username, /*string*/$password) {
			
			
			//verify password, if true create session
			$userManagement = new UserManagement;
			if ($userManagement->verifyPassword($username, $password)) {
				$userManagement->createSession($username);
				return $true;
			}
			else {
				return $false;
			}
				
			
			
		}
	}
?>