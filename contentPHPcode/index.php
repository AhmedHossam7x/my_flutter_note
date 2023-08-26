<?php

// include "connect.php";

define('MB', 1048576);


function imageUpload($imagereques){
    global $msgError;
    // $imagename = rand(1,60) . $_FILES[$imagereques]['name'];
    $imagename = $imagereques;
    $imagetmp = $_FILES[$imagereques]['tmp_name'];
    // $imagetmp = $imagereques;
    // $imageSize = $_FILES[$imagereques]['size'];
    $imageSize = strlen($imagereques);
    $allowExt = array("jpg", "png", "gif", "mp3", "pdf");
    $strtoarray = explode(".", $imagename);
    $ext = end($strtoarray);
    $ext = strtolower($ext);
    if(!empty($imagename) && !in_array($ext, $allowExt)){
        $msgError[] = "Ext";
    }
    if($imageSize > 2*MB || $imageSize < 6){
        $msgError = "size";
    }
    if(empty($msgError)){
        // move_uploaded_file($imagetmp, "../uploade/".$imagename);
        // echo $imagename;
        echo "<br>";
        echo $imagetmp; 
    }else{
        echo "faile";
        echo "<br>";
        echo $msgError;  
        echo "<br>";
        echo $imagetmp;    
    }
}


imageUpload("55images.jpg");

// $text= "ahmed hossame";
// $strtoarray = explode(" ", $text);
// echo "<pre>";
// print_r($strtoarray);
// echo "</pre>";
// echo $strtoarray[0];

// echo "<br>";
// echo "<br>";


// $file = "image.jpg";
// $splete = explode(".", $file);
// $ext = end($splete);
// $allaw = array("jpg", "png", "gif");

// if(in_array($ext, $allaw)){
//     echo "yes";
// }else{
//     echo "no";
// }

// echo "jnsdjkdbvxfjk";
    
    // $stmt = $con->prepare("SELECT * FROM users ");
    // $stmt->execute();
    // $users = $stmt->fetchAll(PDO::FETCH_ASSOC);
    // print_r($users);
    // echo json_encode($users);

    // $stmt = $con->prepare("INSERT INTO `users`(`username`, `email`) VALUES ('Nancy','nancy@gmail.com')");
    // $stmt = $con->prepare("UPDATE `users` SET `username`='Eslam',`email`='eslam@gmail.com' WHERE id= 5");
    // $stmt->execute();
    // $count = $stmt->rowCount();
    // $users = $stmt->fetchAll(PDO::FETCH_ASSOC);
    // if($count > 0){
        // print_r($users);
        // echo "1";
    // }else{
        // echo "0";
    // }
?>
    <!-- // $name="ahmed";
    // $name1="hossam";
    // function printName(){
    //     echo $GLOBALS['name'];
    //     echo"<br>";
    //     global $name1;
    //     echo $name1;
    // }


    // // printName();

    // $listName = array("ahmed", "hossam", 22);   //indexd
    // // echo $listName[0];

    // for($i=0; $i<count($listName); $i++){
    //     echo $listName[$i];
    //     echo "<br>";
    // }

    // $info = array(
    //     "name"=>"ahmed",
    //     "last"=>"hossam",
    //     "age"=>22
    // );//assoc
    // print_r($info);
    // // echo $info['name'];
    // foreach($info as $key => $value){
    //     echo "Key is $key and Value $value";
    //     echo "<br>";
    // } -->