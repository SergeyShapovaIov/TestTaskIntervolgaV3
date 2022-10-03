<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Document</title>
</head>
<body>
<?php

    $a = "After number two";
    $array = array(56,0,2,2423);
    print_r($array);
    echo "<br />";
    for($i = 0; $i < count($array); $i++){
        if(strpos($array[$i],'2') !== false){
            insert_element_by_index($array, $i+1,$a);
            print_r( $array[$i+1]);
            echo "<br />";
        }
    }
    print_r($array);
    echo "<br />";

    //
    function insert_element_by_index(& $array, $index, $element){
        for($i = count($array); $i > $index; $i--){
            $array[$i] = $array[$i-1];
            print_r("Step");
            echo "<br />";
        }
        $array[$index] = $element;
    }
?>
</body>
</html>