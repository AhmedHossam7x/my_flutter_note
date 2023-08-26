<?php
    include "../connect.php";

    $title = filterRequest("title");
    $content = filterRequest("content");
    $userid = filterRequest("id");

    $imagename = imageUpload("file");


    // $imagename = filterRequest("file");


    // if(isset($_FILES['file'])){
    //     // if($imagename != "null"){
    //         $imagename = imageUpload("file");    
    //     // }else{
    //         // $imagename = "note.png";
    //     // }
        
    // }else{
    //     $imagename = "note.png";
    // }

    if($imagename != "faile"){
        $stmt = $con->prepare("INSERT INTO `notes`(`notes_title`, `notes_content`, `notes_user`, `notes_image`) VALUES (?, ?, ?, ?)");

        $stmt->execute(array($title, $content, $userid, $imagename));
    
        $count = $stmt->rowCount();
        if($count > 0){
            echo json_encode(array("status" => "success"));
        }else{
            echo json_encode(array("status" => "faile"));
        }
    }
    else{
        echo json_encode(array("status" => "faile"));
    }


?>