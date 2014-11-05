<?php

	class Credentials {
		
		private $salt = "newsalt";
		
		public function hashPassword(/*string*/ $password) {
			
			$output = crypt($password, $this->salt);
			return $output;
			
		}
	}
?>