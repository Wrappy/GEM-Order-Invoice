<?php
	class Database {
		
		//variables, can be changed
		private $username = "4fd3"; //username
		private $password = "password"; //password
		private $ip = "127.0.0.1"; //mySQL IP
		private $table = "4fd3"; //table name
		
		//login to database
		public function loginDatabase() {
			$con = mysqli_connect($this->ip,$this->username,$this->password,$this->table);
			return $con;
		}
		
		public function queryDatabase(/*string*/ $query) {
			$con = $this->loginDatabase();
			$sql = $query;
			
			if (!mysqli_query($con,$sql))
			{
				$message = 'Error: ' . mysqli_error($con);
				return false;
			}
			$message = "success";
			return true;
		}
		
		public function getResults(/*string*/ $query) {
			$con = $this->loginDatabase();
			$sql = $query;
			
			$result = mysqli_query($con,$query);
			$row = mysqli_fetch_array($result);	
			return $row;
		}
		
		function getAccount(/*string*/ $username) {
			
			$con = $this->loginDatabase();
			$query = "SELECT * FROM user WHERE userID='$username'";
			$result = mysqli_query($con,$query);
			
			return $result;
		}
		
		function getUsers() {
			$con = $this->loginDatabase();
			$sql = "SELECT username FROM user'";
		}	
	}
?>