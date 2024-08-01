<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<form method='get' action='/reup'>
<table id='upc' style='margin:auto;'>
<thead>
	<tr><td colspan='4'>댓글수정</td></tr>
	<tr><td style='text-align:right;' colspan='4'><textarea name='upcon' rows=5 cols=60></textarea><br>
		<input type='submit' value='등록' id='btn'>
		<input type='reset' value='취소' id='reset'></td></tr>
		<input type='hidden' value='${id}' name='id'>
		<input type='hidden' value='${parid}' name='parid'>
</thead>
</form>
</body>
</html>