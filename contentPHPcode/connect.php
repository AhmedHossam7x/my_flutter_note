<?php
    $dsn = "mysql:host=localhost;dbname=noteapp";
    $user = "root";
    $password = "";
    $option = array(
        PDO::MYSQL_ATTR_INIT_COMMAND => "SET NAMES UTF8" //FOR ARABIC
    );

    try{
        $con = new PDO($dsn, $user, $password, $option);
        $con->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

        header("Access-Control-Allow-Origin: *");
        header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With, Access-Control-Allow-Origin");
        header("Access-Control-Allow-Methods: POST, OPTIONS , GET");

        include "function.php";
        checkAuthenticate();
        
    }catch(PDOException $e){
        echo $e->getMessage();
    }
?>