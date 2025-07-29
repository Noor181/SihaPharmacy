<?php
// Database connection
$conn = new mysqli("localhost", "root", "", "nour"); // Replace with your actual database name

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Fetch all lab results
$result = $conn->query("
    SELECT id, patient_id, file_name, file_path, uploaded_at 
    FROM patients_lab_results 
    ORDER BY uploaded_at DESC
");

$conn->close();
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Lab Results</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css">
</head>
<body class="bg-gray-100 flex items-center justify-center min-h-screen">

    <div class="bg-white p-6 rounded-lg shadow-md w-full max-w-2xl">
        <h2 class="text-xl font-semibold text-gray-800 mb-4">Lab Results</h2>

        <?php if ($result->num_rows > 0): ?>
            <table class="w-full border-collapse border border-gray-300">
                <thead>
                    <tr class="bg-blue-500 text-white">
                        <th class="p-2 border">Patient ID</th>
                        <th class="p-2 border">File Name</th>
                        <th class="p-2 border">Uploaded At</th>
                        <th class="p-2 border">Action</th>
                    </tr>
                </thead>
                <tbody>
                    <?php while ($row = $result->fetch_assoc()): ?>
                        <tr class="bg-gray-100 border-b">
                            <td class="p-2 border text-center"><?php echo htmlspecialchars($row['patient_id']); ?></td>
                            <td class="p-2 border"><?php echo htmlspecialchars($row['file_name']); ?></td>
                            <td class="p-2 border text-center"><?php echo $row['uploaded_at']; ?></td>
                            <td class="p-2 border text-center">
                                <a href="<?php echo $row['file_path']; ?>" class="text-blue-600 hover:underline" download>Download</a>
                            </td>
                        </tr>
                    <?php endwhile; ?>
                </tbody>
            </table>
        <?php else: ?>
            <p class="text-gray-600 text-center">No lab results available.</p>
        <?php endif; ?>
    </div>

</body>
</html>
