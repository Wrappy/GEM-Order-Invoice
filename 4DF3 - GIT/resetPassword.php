<?php
	class Database {
		protected $username = "";
		protected $email = "";
		
		public function __construct(/*string*/ $user) {
			$this->$username = $user;
			
			//check username is valid
			if ($this->checkUsername($this->$username)) {
			}
			else { return $false; }
		}
		
		public function checkUsername(/*string*/ $user) {
			
			
		}
	}
		
		