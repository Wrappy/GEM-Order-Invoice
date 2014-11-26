<?php

	$sourceIP = $_SERVER['REMOTE_ADDR'];
	
	if ($sourceIP == "192.168.1.150") {
		header("location: /SSO/index.php");	
	}
	else {
		header("location: index.php");	
	}

?>
