<?php
    include "../connect.php";

    // $noteid = filterRequest("id");
    // $title = filterRequest("title");
    // $content = filterRequest("content");

    $stmt = $con->prepare("SELECT `notes_image` FROM `notes` WHERE `notes_id` = 20 ");
    //
    // $stmt->execute(array($noteid));



    $stmt->execute();
    $users = $stmt->fetchAll(PDO::FETCH_ASSOC);

    $count = $stmt->rowCount();
    if($count > 0){
        // echo json_encode(array("status" => "success"));
        echo json_encode($users);
        
    }else{
        echo json_encode(array("status" => "faile"));
    }
?>