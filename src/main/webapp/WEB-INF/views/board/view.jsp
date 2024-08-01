<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글보기</title>
</head>
<style>
table{
	border-collapse:collapse;
	margin:auto;
}
#reply thead td{
	text-align:left;
}
#reply tbody td{
	text-align:center;
}
#reply tfoot td{
	text-align:center;
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
<table>
<tr><td>제목</td><td><input type=text name=title value="${board.title}" readonly></td></tr>
<tr><td>작성자</td><td><input type=text name=writer value="${board.writer}" readonly></td></tr>
<tr><td>게시글</td><td><textarea name=content rows=20 cols=50 readonly>${board.content}</textarea></td></tr>
<tr><td>작성시각</td><td>${board.created}</td></tr>
<tr><td>수정시각</td><td>${board.updated}</td></tr>
<tr><td colspan=2 style='text-align:center'>
<a href="/">목록으로 돌아가기</a>&nbsp;&nbsp;&nbsp;
<c:if test='${sessionScope.id == board.writer }'>
	<a href="/update?id=${board.id}">수정하기</a>&nbsp;&nbsp;&nbsp;
	<a href="/delete?id=${board.id}">삭제하기</a>
</c:if>
</td></tr>
</table><br><br>
<form method="get" action="/reshow">
<table id='reply'>
<input type='hidden' name='bid' value="${board.id}">
<thead>
	<tr><td colspan='4'>댓글입력</td></tr>
	<tr><td style='text-align:right;' colspan='4'><textarea name='recon' rows=5 cols=60></textarea><br>
		<input type='submit' value='등록' id='btn'>
		<input type='reset' value='취소' id='reset'></td></tr>
</thead>
<tbody>
	<tr><td>작성자</td><td>내용</td><td>시간</td><td>수정</td></tr>
</tbody>
<tfoot>
	<c:forEach var='re' items='${acb}'>
		<tr><td>${re.userid}</td><td>${re.content}</td><td>${re.updated}</td>
														<td>
														<a href='/view?id=${board.id}'>댓글</a>
														<c:if test='${sessionScope.id == re.userid }'>
															<a href='/upc?id=${re.id}&parid=${re.par_id}''>수정</a>
															<a href='/redel?id=${re.id}&parid=${re.par_id}'>삭제</a></c:if></td></tr>
	</c:forEach>
</tfoot>
</table>
</form>
</body>
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script>
$(document)
.ready(function(){
})


</script>
</html>