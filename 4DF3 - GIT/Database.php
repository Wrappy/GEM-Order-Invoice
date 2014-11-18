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
		
		public function queryDatabase(/*string*/ $query) {
			$connect = $this->loginDatabase();
			$sql = $query;
			
			if (!mysqli_query($connect,$sql))
			{
				$message = 'Error: ' . mysqli_error($connect);
				return false;
			}
			$message = "success";
			return true;
		}
		
		public function getResults(/*string*/ $query) {
			$connect = $this->loginDatabase();
			$sql = $query;
			
			$result = mysqli_query($con,"SELECT * FROM user WHERE userID='$username'");
			$row = mysqli_fetch_array($result);	
			return $row;
		}
	}
?>