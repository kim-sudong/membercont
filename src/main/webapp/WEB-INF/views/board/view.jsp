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
<!-- <form method="get" action="/reshow"> -->
<table id='reply'>
<input type='hidden' id='bid' value="${board.id}">
<input type='text' id='ssid' value="${sessionScope.id}">
<thead>
	<tr><td colspan='4'>댓글입력</td></tr>
	<tr><td style='text-align:right;' colspan='4'><textarea id='recon' rows=5 cols=60></textarea><br>
		<input type='button' value='등록' id='btn'>
		<input type='button' value='취소' id='reset'></td></tr>
</thead>
<tbody>
	<tr><td>작성자</td><td>내용</td><td>시간</td><td>수정</td></tr>
</tbody>
<tfoot>
<input type='text' id='reid'>
	<c:forEach var='re' items='${acb}'>
		<tr><td style='display:none;'>${re.id}</td><td>${re.userid}</td><td>${re.content}</td><td>${re.updated}</td>
														<td><input type='button' id='dd' value='댓글'>
														<c:if test='${sessionScope.id == re.userid }'>
															<input type='button' id='up' value='수정'>
															<input type='button' id='del' value='삭제'>	</c:if></td></tr>
														
	</c:forEach>
</tfoot>
</table>
<!-- </form> -->
</body>
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script>
$(document)
.ready(function(){
	ddre(processData);
	//str1 = '<tr style="background-color:#fef0f6;"><td style="border:none;">zz</td><td style="border:none;">xx</td><td style="border:none;">cc</td><td style="border:none;">아 겁나짜증나</td></tr>'
	//$('#reply tfoot tr:eq('+1+')').after(str1);
	//console.log('jkjkjk',$('#reply tfoot tr:eq('+0+')').find('td:eq(0)').text());
})
.on('click','#btn',function(){
	let bid = $('#bid').val()
	let recon = $('#recon').val()
	console.log(bid,recon);
	$.post('/reshow',{bid:bid,recon:recon},function(data){
		if(data=='ok'){
			location.reload()
		}
	},'text')
})
.on('click','#dd',function(){
	console.log($('#reid').val());
	$('#reid').val($(this).closest('tr').find('td:eq(0)').text());
	let str = '<tr><td colspan=3><textarea rows=5 cols=35 id=ddcontent></textarea></td><td><input type=button id=btndd value=등록>  <input type=button id=btnc value=취소></td></tr>'
	$(this).closest('tr').after(str);
})
.on('click','#up,#btnup2',function(){
	console.log($(this).closest('tr').find('td:eq(0)').text());
	$('#reid').val($(this).closest('tr').find('td:eq(0)').text());
	let str = '<tr><td colspan=3><textarea rows=5 cols=35 id=ddup></textarea></td><td><input type=button id=btnup value=수정>  <input type=button id=upc value=취소></td></tr>'
	$(this).closest('tr').after(str);
})
.on('click','#del,#btnc2',function(){
	$('#reid').val($(this).closest('tr').find('td:eq(0)').text());
	let reid = $('#reid').val();
	console.log(reid);
	$.post('/redel',{reid:reid},function(data){
		if(data=='ok'){
			location.reload()
		}
	},'text')
})
.on('click','#btnup',function(){
	let reid = $('#reid').val();
	let ddup = $('#ddup').val();
	console.log(reid,ddup)
	$.post('/reup',{reid:reid,ddup:ddup},function(data){
		if(data=='ok'){
			location.reload()
		}
	},'text')
})
.on('click','#btndd',function(){
	let ddcon = $('#ddcontent').val()
	//let reid = $(this).closest('tr').$('#reid').val()
	let reid = $('#reid').val()
	console.log(reid,ddcon)
	if($('#ddcontent').val()==''){alert('내용을 입력해'); return false;}
	$.post('/ddinsert',{reid:reid,ddcon:ddcon},function(data){
		if(data=='ok'){
			location.reload()
		}
	},'text')
})
.on('click','#btnc,#reset,#upc,#btnc2',function(){
	$('#ddcontent,#recon,#ddup').val('');
	location.reload();
})
function reply(){
	let bid = $('#bid').val()
	$.post('/reply',{bid:bid},function(data){
		if(data=='ok'){
		}
	},'text')
}

 function ddre(callback){
	
	ar = [];
	//let str = '';
	//let i = 0;
	
		//for(i=0 ; i<$('#reply tfoot tr').length; i++){
			//(function(i) {
	 	//let id = $('#reply tfoot tr:eq('+i+')').find('td:eq(0)').text();
		//console.log('qqqqqqqqqqqqqqqqqqqqq',i);
			$.post('/ddre',{},function(data){
				ar = data;
				callback(data);
				//console.log(ar);
				/*  for(let x of ar){
					if(x.parid==id){
						console.log('zzzzz',x.Userid);
						console.log('qqqqq',x.Content);
							str = '<tr style="background-color:#fef0f6;"><td style="border:none;">'+x.Userid+'</td><td style="border:none;">'+x.Content+'</td><td style="border:none;">'+x.Updated+'</td><td style="border:none;">아 겁나짜증나</td></tr>'								
							 
							$('#reply tfoot tr:eq('+i+')').after(str);
							console.log('zzzzzzzzzzzzzzzzzzzzzzzzzzzzzz',i);
							console.log(id);		
							break;
					}
				}  */
				 
			},'json')
			//})(i); 
			
			/*  .done(function(){
						for(let x of ar){
							if(x.parid==id){
								console.log('zzzzz',x.Userid);
									str = '<tr style="background-color:#fef0f6;"><td style="border:none;">'+x.Userid+'</td><td style="border:none;">'+x.Content+'</td><td style="border:none;">'+x.Updated+'</td><td style="border:none;">아 겁나짜증나</td></tr>'								
									$('#reply tfoot tr:eq('+i+')').after(str);
									console.log(id);	
									console.log('zzzzzzzzzzzzzzzzzzzzzzzzzzzzzz',i);
							}
						}
			}) */
//		}
}	  
	

 
 
 
 function processData(data) {
	 
	console.log(ar);
	for(i=0 ; i<$('#reply tfoot tr').length; i++){
	let id = $('#reply tfoot tr:eq('+i+')').find('td:eq(0)').text();
			//console.log('qqqqqqqqqqqqqqqqqqqqq',i);
		
			for(let x of ar){
			if(x.parid==id){
				console.log('zzzzz',x.Userid);
				console.log('qqqqq',x.Content);
					if($('#ssid').val()==x.Userid){
					str = '<tr style="background-color:#fef0f6;"><td style="display:none;">'+x.id+'</td><td style="border:none;">'+x.Userid+'</td><td style="border:none;">'+x.Content+'</td><td style="border:none;">'+x.Updated+'</td><td style="border:none;"><input type=button id=btnup2 value=수정>  <input type=button id=btnc2 value=삭제></td></tr>'								 
					$('#reply tfoot tr:eq('+i+')').after(str);
					}
					else{
						str = '<tr style="background-color:#fef0f6;"><td style="display:none;">'+x.id+'</td><td style="border:none;">'+x.Userid+'</td><td style="border:none;">'+x.Content+'</td><td style="border:none;">'+x.Updated+'</td><td style="border:none;">니가쓴거 아니잖아</td></tr>'								 
						$('#reply tfoot tr:eq('+i+')').after(str);
					}
					console.log('zzzzzzzzzzzzzzzzzzzzzzzzzzzzzz',i);
					console.log(id);		
					
			}
		}  
	}
 }
 

</script>
</html>