<?php
	class Ldap {
		private $host = "192.168.1.150";
		private $port = "389";
		private $username = "acme\administrator";
		private $password = "Adminp&ss";
		
		
		public function connectLdap() {
			$connect = ldap_connect($this->host,$this->port);
			return $connect;
		}

		public function bindLdap(/*link_identifer*/ $connect) {
			$bind = ldap_bind($connect,$this->username,$this->password);
		}

		public function checkUser(/*link_identifer*/ $connect) {
			$base = "CN=Users,DC=acme,DC=com";
			$find = array("cn", "givenname", "samaccountname", "homedirectory", "telephonenumber", "mail");

			$search = ldap_search($connect,$base, 'cn=Administrator',$find);
			if ($search == $false) {
				return false;
			}
			else {
				$info = ldap_get_entries($connect,$search);
				return $info;
			}
		}

		public function validateUser(/*string*/ $username, /*string*/ $password) {
			$connect = $this->connectLdap();
			$bind = ldap_bind($connect,$username,$password);
			if ($bind) {
				return true;
			}
			else {
				return false;
			}
		}
		public function addUser(/*resource*/ $info) {
			include_once "UserManagement.php";
			$userManagement = new UserManagement;
			$username = $info[0]['cn'][0];
			$password = "";
			$fname = "";
			$lname = "";
			$address1 = "";
			$address2 = "";
			$city = "";
			$prov = "";
			$postal = "";
			$email = "";
			$phone = "";
			$type = "ad";
			$userManagement->addUser(/*string*/ $username, /*string*/ $password, /*string*/ $fname, /*string*/ $lname, /*string*/ $address1, /*string*/ $address2, /*string*/ $city, /*string*/ $prov, /*string*/ $postal, /*string*/ $email, /*string*/ $phone, /*string*/ $type);
		}
		public function findUser(/*resource*/ $info) {
			include_once "Database.php";
			$database = new Database;
			
			$username = $info[0]['cn'][0];
			
			//needs to be fixed
			if ($database->getAccount(/*string*/ $username)) {}
			else {
				$this->addUser(/*resource*/ $info);
			}
		}
	}

	/*$test = new Ldap;
	$connect = $test->connectLdap();
	$test->bindLdap($connect);
	$result = $test->checkUser($connect);
	$test->findUser($result);	*/
	
?>