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
td{
	border:1px solid black;
	text-align:center;
}
th{
	color:white; background-color:black;
	border:1px solid white;
}

</style>
<body>
<input type=text id=id>
<table>
<tr><td>제목</td><td><input type=text id=title></td></tr>
<tr><td>게시글</td><td><textarea id=content rows=20 cols=50></textarea></td></tr>
<tr><td colspan=2 style='text-align:center'>
<input type=button value='추가' id=add>&nbsp;&nbsp;
<input type=button value='비우기' id=clear>&nbsp;&nbsp;
<input type=button value='삭제하기' id=del>
</td></tr>
</table>
<input type=button id=btn value=목록보이기>
<table id=tblboard>
<thead><tr><th>번호</th><th>제목</th><th>작성자</th><th>작성시각</th><th>조회수</th></tr></thead>
<tbody></tbody>

</table>
</body>
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script>
$(document)
.on('click','#btn',function(){
	$.ajax({
		url:'/list',type:'post',data:{},dataType:'json',
		success:function(data){
			$('#tblboard tbody').empty();
			console.log(data);
			for( let x of data){
				let str = '<tr>';
				str +='<td>'+x['id']+'</td><td>'+x['title']+'</td><td>'+
						x['writer']+'</td><td>'+x['created']+'</td><td>'+x['hit']+'</td></tr>';
				$('#tblboard tbody').append(str);
			}
			
		},
		error:function(){},
		complete:function(){}
	})
	
})
.on('click','#clear',function(){
	$('#title,#content,#id').val("");
})
.on('click','#add',function(){
	let title = $('#title').val();
	let content = $('#content').val();
	console.log(title);
	console.log(content);
	if(title=="" || content==""){ 
		alert("빈칸없이 입력하세요")
		return false;
		}
	if($('#id').val()==''){
		$.post('/addcon',{title:title,content:content},function(data){
			if(data=='oo'){
				$('#clear,#btn').trigger('click');
			}		
		},'text')	
	return false;
	}
	else{
		$.post('/upcon',{id:$('#id').val(),title:title,content:content},function(data){
			if(data=='oox'){
				$('#clear,#btn').trigger('click');
			}		
		},'text')
	}
})
.on('click','#tblboard tbody tr',function(){
	let id=$(this).find('td:eq(0)').text();
	let title=$(this).find('td:eq(1)').text();
	$('#id').val(id);
	$('#title').val(title);
	$.post('/delboard',{id:id},function(data){
		console.log(data);
		$('#content').val(data)
	})
})
.on('click','#del',function(){
	if(!confirm('진짜 지움?')) return false;
	let id = $('#id').val();
	$.post('/delboardx',{id:id},function(data){
		console.log(data);
		if(data=='ox'){
			$('#clear,#btn').trigger('click');	
		}
		
		
	},'text')
	
})

</script>
</html>