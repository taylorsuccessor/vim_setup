<?php

error_reporting(E_ALL);        // Report all types of errors
ini_set('display_errors', 1);  // Display errors in the browser
// Default base directory for sessions
$baseDir = __DIR__ . '/sessions/';
$sessionsDir = __DIR__ . '/sessions/';

// Ensure the base directory exists
if (!is_dir($baseDir)) mkdir($baseDir, 0777, true);

// Get the current session name
$sessionName = isset($_GET['file']) ? basename($_GET['file']) : 'default';
$sessionDir = $baseDir . $sessionName . '/';
$textFile = $sessionDir . $sessionName . '.txt';

// Ensure the session directory exists
if (!is_dir($sessionDir)) mkdir($sessionDir, 0777, true);

// Function to clear all session data, now restricted to session directory only
function deleteDir($dir) {

    if (!is_dir($dir)) {
        return false; // Not a directory
    }

    $items = array_diff(scandir($dir), ['.', '..']); // Ignore `.` and `..`
    foreach ($items as $item) {
        $path = $dir . DIRECTORY_SEPARATOR . $item;
        if (is_dir($path)) {
            deleteDir($path); // Recursively delete subdirectories
        } else {
            unlink($path); // Delete file
        }
    }

    return rmdir($dir);
}

// Handle "Clear All Data" action
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['clear_all'])) {
    deleteDir($sessionsDir);
    echo "All session data cleared.";
    exit;
}

// Handle text file saving
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['content'])) {
    file_put_contents($textFile, $_POST['content']);
    echo "Content auto-saved.";
    exit;
}

// Handle file uploads with restriction to session directory only
if (isset($_FILES['uploaded_file'])) {
    $filePath = $sessionDir . basename($_FILES['uploaded_file']['name']);
   

    if (move_uploaded_file($_FILES['uploaded_file']['tmp_name'], $filePath)) {
        echo "File uploaded successfully.";
    } else {
        echo "Failed to upload the file.";
    }
    exit;
}

// Display the current file content or an empty editor if the file doesn't exist
if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    // Only allow viewing files within the session directory
   
    $content = file_get_contents($textFile);
    ?>
    <!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Session-Based File Manager</title>
        <style>
            body { font-family: Arial, sans-serif; margin: 20px; }
            textarea { width: 100%; height: 300px; }
            .status { margin-top: 10px; color: green; }
        </style>
    </head>
    <body>
        <h1>Session-Based File Manager</h1>
        
        <!-- Change Text File -->
        <form method="GET">
            <label for="file">Session Name:</label>
            <input type="text" id="file" name="file" value="<?= htmlspecialchars($sessionName) ?>">
            <button type="submit">Change Session</button>
        </form>
        
        <hr>
        
        <!-- Text Area for Editing -->
        <textarea id="content"><?= htmlspecialchars($content) ?></textarea>
        <div class="status" id="status">All changes are saved.</div>
        
        <hr>
        
        <!-- Upload Files -->
        <h1>Upload a File</h1>
        <form method="POST" enctype="multipart/form-data">
            <label for="uploaded_file">Choose a file:</label>
            <input type="file" id="uploaded_file" name="uploaded_file">
            <button type="submit" name="upload">Upload</button>
        </form>
        
        <hr>
        
        <!-- List Uploaded Files -->
        <h1>Uploaded Files for Session "<?= htmlspecialchars($sessionName) ?>"</h1>
        <?php
        foreach (glob($sessionDir . '*') as $file) {
            if (is_file($file)) {
                $fileName = basename($file);
                echo "<a href='$file' download>$fileName</a><br>";
            }
        }
        ?>

        <hr>

        <!-- Clear All Data -->
        <h1>Clear All Sessions</h1>
        <form method="POST">
            <button type="submit" name="clear_all" onclick="return confirm('Are you sure you want to delete all sessions?');">Clear All Data</button>
        </form>

        <script>
            const textarea = document.getElementById('content');
            const statusDiv = document.getElementById('status');

            let timeout;

            // Auto-save function
            textarea.addEventListener('input', () => {
                clearTimeout(timeout); // Clear any existing timeout
                statusDiv.textContent = "Saving...";
                
                // Delay saving by 500ms to avoid too many requests
                timeout = setTimeout(() => {
                    fetch(window.location.href, {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/x-www-form-urlencoded',
                        },
                        body: `content=${encodeURIComponent(textarea.value)}`
                    })
                    .then(response => response.text())
                    .then(() => {
                        statusDiv.textContent = "All changes are saved.";
                    })
                    .catch(() => {
                        statusDiv.textContent = "Failed to save.";
                    });
                }, 500);
            });
        </script>
    </body>
    </html>
    <?php
    exit;
}
?>

