<?php

	$movieId = $_GET["cinemaId"];
	
	//服务器本地路径
	$rootPath = $_SERVER["DOCUMENT_ROOT"];
	//文件完整路径
	$filePath = $rootPath."/teacher/yihuiyun/resource/cinemafile/c".$movieId.".txt";
	
	$handle = fopen($filePath, "r");
	
	$contents = fread($handle, filesize($filePath));
	
	echo($contents);


?>