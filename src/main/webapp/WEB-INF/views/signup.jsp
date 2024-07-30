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
	
}
td{
	border:1px solid black;
}
td:nth-child(1){
	text-align:right;
}
</style>
<body>
<form method=post action="/dosignup">
<table>
<tr><td>아이디 </td><td><input type=text name=id></td></tr>
<tr><td>비밀번호 </td><td><input type=password name=pass></td></tr>
<tr><td>비밀번호 확인 </td><td><input type=password name=pass2></td></tr>
<tr><td>실명 </td><td><input type=text name=name></td></tr>
<tr><td>생년월일 </td><td><input type=date name=birth></td></tr>
<tr><td>성별 </td><td><input type=radio name=gender value="남자">남자
			<input type=radio name=gender value="여자">여자</td></tr>
<!--  <tr><td>지역 </td><td><select name=region>
					<option value="일산동구">일산동구</option>
					<option value="일산서구">일산서구</option>
					<option value="덕양구">덕양구</option>
					</select></td></tr>-->
<tr><td>모바일번호</td><td><input type=text name=mobile></td></tr>
<tr><td>관심분야 </td><td>
				<input type=checkbox name=fav value=java>java
				<input type=checkbox name=fav value=javascript>javascript
				<input type=checkbox name=fav value=python>python <br>
				<input type=checkbox name=fav value=mysql>mysql
				<input type=checkbox name=fav value=oracle>oracle
				<input type=checkbox name=fav value=react>react<br>
				<input type=checkbox name=fav value=spring>spring
				<input type=checkbox name=fav value=node.js>node.js
				<input type=checkbox name=fav value=nest.js>nest.js</td></tr>
<tr><td colspan="2" style=text-align:center;> 
		 <input type=submit value="가입">
		 <input type=reset value="비우기">
		 <input type=button value="취소" id="xx"></td></tr>
		 
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