<?php
// Database connection
$conn = new mysqli("localhost", "root", "", "nour"); // Replace with your actual database name

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

$message = "";

// Handle file upload
if ($_SERVER["REQUEST_METHOD"] == "POST" && isset($_FILES["lab_result"])) {
    $target_dir = $_SERVER['DOCUMENT_ROOT'] . "/uploads/"; // Root directory uploads folder
    $file_name = basename($_FILES["lab_result"]["name"]);
    $target_file = $target_dir . $file_name;
    $uploadOk = 1;
    $fileType = strtolower(pathinfo($target_file, PATHINFO_EXTENSION));

    // Allowed file types
    $allowed_types = ["pdf", "doc", "docx", "jpg", "png"];
    if (!in_array($fileType, $allowed_types)) {
        $message = "Only PDF, DOC, DOCX, JPG, and PNG files are allowed.";
        $uploadOk = 0;
    }

    // Check file size (Max 5MB)
    if ($_FILES["lab_result"]["size"] > 5 * 1024 * 1024) {
        $message = "File size must be less than 5MB.";
        $uploadOk = 0;
    }

    if ($uploadOk) {
        if (move_uploaded_file($_FILES["lab_result"]["tmp_name"], $target_file)) {
            $patient_id = 1; // Replace with actual patient ID logic
            $file_path = "/uploads/" . $file_name;

            // Insert into database
            $stmt = $conn->prepare("INSERT INTO patients_lab_results (patient_id, file_name, file_path) VALUES (?, ?, ?)");
            $stmt->bind_param("iss", $patient_id, $file_name, $file_path);

            if ($stmt->execute()) {
                $message = "File uploaded successfully!";
            } else {
                $message = "Database error: " . $stmt->error;
            }

            $stmt->close();
        } else {
            $message = "Error uploading file.";
        }
    }
}

// Fetch uploaded files for display
$result = $conn->query("SELECT file_name, file_path, uploaded_at FROM patients_lab_results WHERE patient_id = 1 ORDER BY uploaded_at DESC");

$conn->close();
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Post Lab Results</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css">
</head>
<body class="bg-gray-100 flex items-center justify-center min-h-screen">

    <div class="bg-white p-6 rounded-lg shadow-md w-96">
        <h2 class="text-xl font-semibold text-gray-800 mb-4">Post Lab Results</h2>

        <?php if (!empty($message)): ?>
            <p class="text-center text-red-600 font-semibold"><?php echo $message; ?></p>
        <?php endif; ?>

        <!-- Upload Form -->
        <form action="post_lab_results.php" method="post" enctype="multipart/form-data">
            <label class="block mb-2 font-medium text-gray-700">Upload Lab Result:</label>
            <input type="file" name="lab_result" class="w-full p-2 border rounded mb-4" required>
            <button type="submit" class="w-full bg-blue-500 text-white p-2 rounded hover:bg-blue-600">
                Upload
            </button>
        </form>

        <!-- Display Uploaded Files -->
        <h3 class="text-lg font-semibold text-gray-800 mt-6">Uploaded Lab Results</h3>
        <ul class="mt-2">
            <?php while ($row = $result->fetch_assoc()): ?>
                <li class="bg-gray-200 p-2 rounded-lg mb-2 flex justify-between items-center">
                    <span class="text-gray-700"><?php echo htmlspecialchars($row['file_name']); ?></span>
                    <a href="<?php echo $row['file_path']; ?>" class="text-blue-600 hover:underline" download>Download</a>
                </li>
            <?php endwhile; ?>
        </ul>
    </div>

</body>
</html>
