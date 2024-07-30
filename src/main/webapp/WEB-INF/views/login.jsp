<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
table{
	border-collapse:collapse;
	margin:auto;
}
td:nth-child(1){
	text-align:right;
}
td{
	border:1px solid black;
}
td:nth-child(1){
	text-align:right;
}
</style>
<body>
<form method="post" action="/dologin">
<table>
<tr><td>아이디</td><td><input type=text name=id></td></tr>
<tr><td>비밀번호</td><td><input type=password name=pass></td></tr>
<tr><td colspan=2 style='text-align:center'><input type=submit value="로그인">
<input type=reset value="비우기">
<input type=button value="취소" id="xx">
</td></tr>
</table>
</form>
</body>
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script>
$(document)
.on("click","#xx",function(){
	location.href="/"
})
</script>
</html>