<?php
	include "config.php";
	
	if($_SERVER["REQUEST_METHOD"] == "POST") {
		
		$sql = trim($_POST["sql_query"]);
	}
	
	$forbidden = ["DROP", "DELETE"];
	foreach ($forbidden as $word) {
		if(stripos($sql, $word) !== false){
			die("Error: Forbidden Query!!!");
		}
	}
	
	$result = $conn->query($sql);

    if ($result) {
        if ($result->num_rows > 0) {
            echo "<table border='1'><tr>";
			echo "<body style='background-color:powderblue;'>";
			echo "<style> body{font-family: 'Trebuchet MS', sans-serif;} table{background-color: #CBC3E3;} </style>";

            // Get column names
            while ($field = $result->fetch_field()) {
                echo "<th>" . htmlspecialchars($field->name) . "</th>";
            }
            echo "</tr>";

            // Get rows
            while ($row = $result->fetch_assoc()) {
                echo "<tr>";
                foreach ($row as $col) {
                    echo "<td>" . htmlspecialchars($col) . "</td>";
                }
                echo "</tr>";
            }
            echo "</table>";
			echo "<br><br> <form action = 'index.html' method = 'GET'> <input type = 'submit' value = 'Back'> </form>";

        } else {
            echo "No results found.";
        }
    } else {
        echo "Error: " . $conn->error;
    }


$conn->close();

?>