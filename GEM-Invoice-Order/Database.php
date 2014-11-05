<?php
	class Database {
		
		//variables, can be changed
		private $username = "x"; //username
		private $password = "x"; //password
		private $ip = "x"; //mySQL IP
		private $table = "x"; //table name
		
		//login to database
		public function loginDatabase() {
			$con = mysqli_connect($this->ip,$this->username,$this->password,$this->table);
			return $con;
		}
	}
?>