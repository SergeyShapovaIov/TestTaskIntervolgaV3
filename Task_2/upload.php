<html>
<head>
    <title>File Upload</title>
</head>
<body>
<h1>File Upload</h1>
<form method = "post" action="upload.php" enctype="multipart/form-data">
    <label for = "inputfile">Upload File</label>
    <input type = "file" id="inputfile" name="inputfile"></br>
    <input type = "submit" value="Отправить"></br>
</form>
</body>
</html>
<?php
// Checking for a successful file download
if(isset($_FILES) && $_FILES['inputfile']['error'] == 0){
    echo 'File Uploaded';
    // Check the file format. Only CSV format available
    if($_FILES['inputfile']['type'] === "text/csv") {
        $res = []; // Array for CSV file contents
        if (($file = fopen($_FILES['inputfile']['tmp_name'], 'r')) !== false) {
            $row = 0;
            // Reading a file and filling the resulting array
            while ($data = fgetcsv($file, 1000, ",")) {
                if ($row > 0) {
                    $res[$row - 1] = array(
                        "fail_name" => $data[0],
                        "content" => $data[1]
                    );
                }
                $row++;
            }
            // Get the list of files stored in the upload directory
            $arFileList = array(); // список файлов
            $resHandler = opendir("upload/");
            if (is_resource($resHandler)) {
                while ($FileName = readdir($resHandler)) {
                    if (!is_dir($FileName)) {
                        $arFileList[] = $FileName;
                    }
                }
                closedir($resHandler);
            }
            // Delete all the files contained in the upload folder
            for ($i = 0; $i < count($arFileList); $i++) {
                unlink("./upload/" . $arFileList[$i]);
            }
            // Creating new files in the upload folder
            for ($i = 0; $i < count($res); $i++) {
                $fail_name = $res[$i]['fail_name'];
                $text = $res[$i]['content'];
                $file = "upload/$fail_name";
                if (!file_exists($file)) {
                    $fp = fopen("$file", 'w');
                    fwrite($fp, $text);
                    fclose($fp);
                }
            }
        }
   } else {
        echo 'The file does not have a CSV extension'; // Format error message
   }
} else {
    echo 'No File Uploaded'; // Boot error message
}
?>