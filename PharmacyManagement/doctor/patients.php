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

// Function to fetch symptoms and show diagnosis form
function fetchSymptomsAndAddDiagnosis($appointment_id) {
    global $conn;

    // Query to get symptoms for the given appointment_id
    $sql = "SELECT symptoms FROM diagnoses WHERE appointment_id = ?";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("i", $appointment_id); // Bind appointment_id as an integer
    $stmt->execute();
    $result = $stmt->get_result();

    if ($result->num_rows > 0) {
        $row = $result->fetch_assoc();
        
        // Display symptoms
        echo "<div class='mb-4'><strong>Symptoms:</strong><p class='text-gray-700'>" . htmlspecialchars($row['symptoms']) . "</p></div>";

        // Display form to add diagnosis if not already set
        echo "<div class='mb-4'>
                <label for='diagnosis' class='block text-gray-600 font-medium'>Add Diagnosis:</label>
                <textarea name='diagnosis' class='w-full p-3 border border-gray-300 rounded-lg mt-2' rows='4' required></textarea>
            </div>";
        echo "<button type='submit' class='w-full bg-blue-500 text-white p-3 rounded-lg mt-4 hover:bg-blue-600 focus:outline-none'>Submit Diagnosis</button>";
    } else {
        echo "<div class='text-red-500 font-semibold mt-4'>No symptoms found for this appointment ID.</div>";
    }
}

// Function to update or add diagnosis for a specific appointment
function addDiagnosis($appointment_id, $diagnosis) {
    global $conn;

    // Check if a diagnosis already exists in the dios table
    $check_sql = "SELECT id FROM dios WHERE appointment_id = ?";
    $check_stmt = $conn->prepare($check_sql);
    $check_stmt->bind_param("i", $appointment_id);
    $check_stmt->execute();
    $check_result = $check_stmt->get_result();

    if ($check_result->num_rows > 0) {
        // Diagnosis exists, update it
        $update_sql = "UPDATE dios SET diagnosis_text = ? WHERE appointment_id = ?";
        $update_stmt = $conn->prepare($update_sql);
        $update_stmt->bind_param("si", $diagnosis, $appointment_id); // Bind diagnosis and appointment_id
        if ($update_stmt->execute()) {
            return "<div class='text-green-500 font-semibold mt-4'>Diagnosis has been successfully updated!</div>";
        } else {
            return "<div class='text-red-500 font-semibold mt-4'>Error: Could not update diagnosis. " . $conn->error . "</div>";
        }
    } else {
        // No diagnosis exists for this appointment, insert a new record into the dios table
        $insert_sql = "INSERT INTO dios (appointment_id, diagnosis_text) VALUES (?, ?)";
        $insert_stmt = $conn->prepare($insert_sql);
        $insert_stmt->bind_param("is", $appointment_id, $diagnosis);
        if ($insert_stmt->execute()) {
            return "<div class='text-green-500 font-semibold mt-4'>Diagnosis has been successfully added!</div>";
        } else {
            return "<div class='text-red-500 font-semibold mt-4'>Error: Could not insert diagnosis. " . $conn->error . "</div>";
        }
    }
}

// Handle form submission for diagnosis
$confirmation_message = '';
if ($_SERVER["REQUEST_METHOD"] == "POST" && isset($_POST['appointment_id']) && isset($_POST['diagnosis'])) {
    $appointment_id = $_POST['appointment_id'];  // Appointment ID from form input
    $diagnosis = $_POST['diagnosis'];  // Diagnosis from form input

    // Call function to add the diagnosis
    $confirmation_message = addDiagnosis($appointment_id, $diagnosis);
}

// Example usage: If the doctor is viewing symptoms and adding a diagnosis
$appointment_id = isset($_GET['appointment_id']) ? $_GET['appointment_id'] : '';
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Symptoms & Add Diagnosis</title>
    <!-- Tailwind CSS CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 p-8">

    <div class="max-w-lg mx-auto bg-white p-6 rounded-lg shadow-lg">
        <h2 class="text-2xl font-semibold text-center text-gray-700 mb-6">View Symptoms & Add Diagnosis</h2>

        <!-- Form to view symptoms and add diagnosis -->
        <form method="GET" action="">
            <div class="mb-4">
                <label for="appointment_id" class="block text-gray-600 font-medium">Appointment ID:</label>
                <input type="text" name="appointment_id" value="<?= htmlspecialchars($appointment_id) ?>" class="w-full p-3 border border-gray-300 rounded-lg mt-2" required>
            </div>
            <button type="submit" class="w-full bg-blue-500 text-white p-3 rounded-lg mt-4 hover:bg-blue-600 focus:outline-none">View Symptoms</button>
        </form>

        <?php
        // Display symptoms and diagnosis form if appointment_id is provided
        if (!empty($appointment_id)) {
            echo "<form method='POST' action=''>";
            // Ensure $appointment_id is set before calling fetchSymptomsAndAddDiagnosis
            if (!empty($appointment_id)) {
                fetchSymptomsAndAddDiagnosis($appointment_id);
            } else {
                echo "<div class='text-red-500 font-semibold mt-4'>Appointment ID is required.</div>";
            }
            echo "</form>";
        }

        // Show the confirmation message if any
        if ($confirmation_message != '') {
            echo $confirmation_message;
        }
        ?>

        <!-- Back Button to Dashboard -->
        <div class="mt-4 text-center">
            <a href="dashboard.php" class="bg-gray-500 text-white p-3 rounded-lg hover:bg-gray-600">Back to Dashboard</a>
        </div>

    </div>

</body>
</html>
