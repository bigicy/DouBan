<?php
	
	//服务器本地路径
	$rootPath = $_SERVER["DOCUMENT_ROOT"];
	
	//文件完整路径
	$filePath = $rootPath."/teacher/yihuiyun/resource/cinemafile/cinemalist.txt";

	//指向被操作的文件
	$handle = fopen($filePath, "r");
	
	//读取文件中的内容
	$contents = fread($handle, filesize($filePath));
	
	echo($contents);

?>