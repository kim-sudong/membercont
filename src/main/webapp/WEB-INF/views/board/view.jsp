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
		<tr><td style='display:none;'>${re.id}</td><td>${re.userid}</td><td>${re.content}</td><td>${re.updated}</td>
														<td><input type='hidden' id='reid' value='${re.id}'>
														<a id='dd' style='cursor: pointer;'>댓글</a>
														<c:if test='${sessionScope.id == re.userid }'>
															<a href='/upc?id=${re.id}&parid=${re.par_id}'>수정</a>
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
	ddre();
})
.on('click','#dd',function(){
	console.log($('#reid').val());
	let str = '<tr><td colspan=3><textarea rows=5 cols=35 id=ddcontent></textarea></td><td><input type=button id=btndd value=등록></td></tr>'
	//$('#reply tfoot').append(str);
	$(this).closest('tr').after(str);
})
.on('click','#btndd',function(){
	let ddcon = $('#ddcontent').val()
	let reid = $('#reid').val()
	if($('#ddcontent').val()==''){alert('내용을 입력해'); return false;}
	$.post('/ddinsert',{reid:reid,ddcon:ddcon},function(data){
		if(data=='ok'){
			location.reload()
		}
	},'text')
})
/* function ddre(){
	 let ar = [];
	let str = '';
	
	$('#reply tfoot tr').each(function(){
		let id = $(this).find('td:eq(0)').text();
		let tr = $(this);
		console.log(id);
			$.post('/ddre',{id:id},function(data){
				ar = data;
			},'json').done(function(){
						for(let x of ar){
							if(x.parid==id){
								console.log('zzzzz',x.Userid);
									str = '<tr style="background-color:#fef0f6;"><td style="border:none;">'+x.Userid+'</td><td style="border:none;">'+x.Content+'</td><td style="border:none;">'+x.Updated+'</td><td style="border:none;">아 겁나짜증나</td></tr>'								
									
									tr.after(str);
									console.log(id);		
							}
						}
					}) 
	}) 
		 */
	/* console.log($('#reply tfoot tr').length);
	let tl = $('#reply tfoot tr').length;
	for(let i = 0 ; i<tl ; i++ ){
		console.log( $('#reply tfoot tr:eq('+i+')').find('td:eq(0)').text())
		let id = $('#reply tfoot tr:eq('+i+')').find('td:eq(0)').text();
		$.post('/ddre',{id:id},function(data){
			ar = data;
		},'json').done(function(){
					for(let x of ar){
						if(x.parid==id){
							console.log(x.Writer);
								str = '<tr style="background-color:#fef0f6;"><td style="border:none;">'+x.Userid+'</td><td style="border:none;">'+x.Content+'</td><td style="border:none;">'+x.Updated+'</td><td style="border:none;">아 겁나짜증나</td></tr>'								
								if($('#reply tfoot tr:eq('+i+')').find('td:eq(0)').text()==x.parid){
								$(this).after(str);
								}
								console.log(i);
						}
						
					}
				})  
	} */
//}
function ddre() {
    $('#reply tfoot tr').each(function() {
        let id = $(this).find('td:eq(0)').text();
        let tr = $(this); // 현재 tr 요소를 저장

        console.log('Requesting ID:', id);

        $.post('/ddre', { id: id }, function(data) {
            // 데이터 요청이 성공적으로 완료된 후
            console.log('Received data for ID', id, ':', data);

            let str = ''; // HTML 문자열을 누적할 변수

            // 받은 데이터 배열을 순회
            for (let x of data) {
                if (x.parid == id) {
                    console.log('Matching data:', x.Userid);
                    // HTML 문자열 생성
                    str += '<tr style="background-color:#fef0f6;">' +
                           '<td style="border:none;">' + x.Userid + '</td>' +
                           '<td style="border:none;">' + x.Content + '</td>' +
                           '<td style="border:none;">' + x.Updated + '</td>' +
                           '<td style="border:none;">아 겁나짜증나</td>' +
                           '</tr>';
                }
            }

            // 생성한 HTML 문자열을 현재 tr의 뒤에 추가
            if (str) {
                tr.after(str); // 현재 tr의 뒤에 추가
            }
        }, 'json').fail(function(jqXHR, textStatus, errorThrown) {
            console.error('Request failed for ID', id, ':', textStatus, errorThrown);
        });
    });
}

</script>
</html>