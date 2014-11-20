		<?php
				session_start();
				if (isset($_SESSION['login'])) {
					echo "Logged Out";
					session_destroy();
					header("location: index.php");
				}
				else {
					echo "Error, not logged in!";
				}
		?>