<?php

    define('MB', 1048576);


    function filterRequest($requestname){
        return htmlspecialchars(strip_tags($_POST[$requestname]));
    }

    function imageUpload($imagereques){
        global $msgError;
        $imagename = rand(1,60) . $_FILES[$imagereques]['name'];
        $imagetmp = $_FILES[$imagereques]['tmp_name'];
        $imageSize = $_FILES[$imagereques]['size'];
        $allowExt = array("jpg", "png", "gif", "mp3", "pdf");
        $strtoarray = explode(".", $imagename);
        $ext = end($strtoarray);
        $ext = strtolower($ext);
        if(!empty($imagename) && !in_array($ext, $allowExt)){
            $msgError[] = "Ext";
        }
        if($imageSize > 2*MB ){
            $msgError = "size";
        }
        if(empty($msgError)){
            move_uploaded_file($imagetmp, "../uploade/".$imagename);
            return $imagename;
        }else{
            return "faile";
        }
    }

    function deleteFile($dir, $imagename){ 
        if(file_exists($dir . "/" .$imagename)){
            unlink($dir . "/" .$imagename);
        }
    }

    function checkAuthenticate(){
        if (isset($_SERVER['PHP_AUTH_USER'])  && isset($_SERVER['PHP_AUTH_PW'])) {
            if ($_SERVER['PHP_AUTH_USER'] != "Ahmed" ||  $_SERVER['PHP_AUTH_PW'] != "ah123456"){
                header('WWW-Authenticate: Basic realm="My Realm"');
                header('HTTP/1.0 401 Unauthorized');
                echo 'Page Not Found';
                exit;
            }
        } else {
            exit;
        }
    }
    
?>