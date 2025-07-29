<?php
// Assuming you already have a database connection
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "nour";

// Create a connection to the database
$conn = new mysqli($servername, $username, $password, $dbname);

// Check if connection is successful
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Function to check the appointment status and insert symptoms
function checkAndAddSymptoms($appointment_id, $symptoms) {
    global $conn;

    // Query to get appointment details by id
    $sql = "SELECT status FROM appointments WHERE id = ?";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("i", $appointment_id); // Bind appointment_id as an integer
    $stmt->execute();
    $result = $stmt->get_result();

    // Check if appointment exists and has 'Accepted' status
    if ($result->num_rows > 0) {
        $row = $result->fetch_assoc();
        if ($row['status'] == 'Accepted') {
            // Appointment is accepted, now insert symptoms into diagnoses table

            // Prepare the query to insert symptoms, with default value for diagnosis
            $insert_sql = "INSERT INTO diagnoses (appointment_id, diagnosis, symptoms) VALUES (?, ?, ?)";
            $insert_stmt = $conn->prepare($insert_sql);
            $diagnosis = "Not Diagnosed"; // Default value for diagnosis
            $insert_stmt->bind_param("iss", $appointment_id, $diagnosis, $symptoms); // Bind params
            if ($insert_stmt->execute()) {
                echo "<div class='text-green-500 font-semibold mt-4'>Symptoms have been successfully added!</div>";
            } else {
                echo "<div class='text-red-500 font-semibold mt-4'>Error: Could not insert symptoms. " . $conn->error . "</div>";
            }
        } else {
            echo "<div class='text-red-500 font-semibold mt-4'>This appointment is not accepted. Symptoms cannot be entered.</div>";
        }
    } else {
        echo "<div class='text-red-500 font-semibold mt-4'>Appointment not found.</div>";
    }
}

// Example usage
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $appointment_id = $_POST['appointment_id'];  // Appointment ID from form input
    $symptoms = $_POST['symptoms'];  // Symptoms from form input

    // Call the function to check appointment and insert symptoms
    checkAndAddSymptoms($appointment_id, $symptoms);
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Enter Symptoms</title>
    <!-- Tailwind CSS CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 p-8">

    <div class="max-w-lg mx-auto bg-white p-6 rounded-lg shadow-lg">
        <h2 class="text-2xl font-semibold text-center text-gray-700 mb-6">Enter Symptoms</h2>
        
        <!-- HTML Form to Enter Symptoms -->
        <form method="POST" action="">
            <div class="mb-4">
                <label for="appointment_id" class="block text-gray-600 font-medium">Appointment ID:</label>
                <input type="text" name="appointment_id" class="w-full p-3 border border-gray-300 rounded-lg mt-2" required>
            </div>

            <div class="mb-4">
                <label for="symptoms" class="block text-gray-600 font-medium">Symptoms:</label>
                <textarea name="symptoms" class="w-full p-3 border border-gray-300 rounded-lg mt-2" rows="4" required></textarea>
            </div>

            <button type="submit" class="w-full bg-blue-500 text-white p-3 rounded-lg mt-4 hover:bg-blue-600 focus:outline-none">Submit Symptoms</button>
        </form>
    </div>

</body>
</html>
