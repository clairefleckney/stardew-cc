<?php
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "stardew_cc";

function createDB() {
	global $servername, $username, $password, $dbname;
	$conn = mysqli_connect($servername, $username, $password);
	$filename = "factory.sql";

	if (!$conn) {
		die("Connection failed: " . mysqli_connect_error());
	}

	$result = $conn->query("SHOW DATABASES LIKE '$dbname'");
	if ($result->num_rows == 0) {
		$sql = "CREATE DATABASE IF NOT EXISTS " . $dbname;

		if (!mysqli_query($conn, $sql)) {
			die("Error creating database: " . mysqli_error($conn));
		}

		mysqli_close($conn);

		$conn = mysqli_connect($servername, $username, $password, $dbname);
		if (!$conn) {
			die("Connection failed: " . mysqli_connect_error());
		}

		$sql = file_get_contents($filename);

		if ($conn->multi_query($sql)) {
			do {
				if ($result = $conn->store_result()) {
					$result->free();
				}
			} while ($conn->next_result());
		} else {
			echo "Error: " . $conn->error;
		}
	}
	mysqli_close($conn);

	fillDB();
}

function fillDB() {
	global $servername, $username, $password, $dbname;
	$conn = mysqli_connect($servername, $username, $password, $dbname);
	$filename = "seeder.sql";

	if (!$conn) {
		die("Connection failed: " . mysqli_connect_error());
	}

	$sql = file_get_contents($filename);

	if ($conn->multi_query($sql)) {
		do {
			if ($result = $conn->store_result()) {
				$result->free();
			}
		} while ($conn->next_result());
	} else {
		echo "Error: " . $conn->error;
	}
	mysqli_close($conn);
}