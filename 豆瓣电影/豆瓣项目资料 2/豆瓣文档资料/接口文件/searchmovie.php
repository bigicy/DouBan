<?php

	$movieId = $_GET["movieId"];
	
	//服务器本地路径
	$rootPath = $_SERVER["DOCUMENT_ROOT"];
	//文件完整路径
	$filePath = $rootPath."/teacher/yihuiyun/resource/moviefile/m".$movieId.".txt";
	
	$handle = fopen($filePath, "r");
	
	$contents = fread($handle, filesize($filePath));
	
	echo($contents);


?>