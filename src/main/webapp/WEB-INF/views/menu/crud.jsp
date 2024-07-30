<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메뉴관리</title>
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
a {
        font-size: 25px;
        color: black;

    }
</style>
<body>
<h1 style="font-size:36px;text-align:center;">카페 메뉴 관리</h1>
<a href="/menuct">메뉴관리</a>  <a href="/orderct">주문관리</a><br><br>
<!--<table style='width:100%'>
<tr>
	<td style='width:30%;text-align:left;border:none;'>
		<a href='/orderct'>주문관리</a>	
	</td>
	<td style='width:50%;text-align:left;border:none;'>
		<h1>메뉴관리</h1>
	</td>
</tr>
</table>-->
<input type=hidden id=id>
<table>
<tr><td>메뉴명</td><td><input type=text id=name></td></tr>
<tr><td>가격</td><td><input type=number id=price></td></tr>
<tr><td colspan=2 style=text-align:center>
		<input type=button id=add value=메뉴추가>
		<input type=button id=clear value=비우기>
		<input type=button id=del value=삭제></td></tr>
</table>
<input type=button id=btn value=메뉴보이기>
<table id=tblboard>
<thead><tr><th>번호</th><th>메뉴명</th><th>가격</th></tr></thead>
<tbody>

</tbody>
</table>
</body>
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script>
$(document)
.ready(function(){
	$.post('/getmenus',{},function(data){
		console.log(data);
		$('#tblboard tbody').empty();
		for( let x of data){
			let str = '<tr>';
			str +='<td>'+x['id']+'</td><td>'+x['name']+'</td><td>'+x['price']+'</td></tr>';
			$('#tblboard tbody').append(str);
		}
	},'json')
})
.on('click','#btn',function(){
//	$.ajax({
//		url:'/getmenus',type:'post',data:{},dataType:'json',
//		success:function(data){
//			console.log(data);
//			for( let x of data){
//				let str = '<tr>';
//				str +='<td>'+x['id']+'</td><td>'+x['name']+'</td><td>'+x['price']+'</td></tr>';
//				$('#tblboard').append(str);
//			}
//			
//		},
//		error:function(){},
//		complete:function(){}

	$.post('/getmenus',{},function(data){
		console.log(data);
		$('#tblboard tbody').empty();
		for( let x of data){
			let str = '<tr>';
			str +='<td>'+x['id']+'</td><td>'+x['name']+'</td><td>'+x['price']+'</td></tr>';
			$('#tblboard tbody').append(str);
		}
	},'json')
})
.on('click','#clear',function(){
	$('#name,#price,#id').val("");
})
.on('click','#add',function(){
		let name = $('#name').val();
		let price = $('#price').val();
		if(name=="" || price=="") return false;
	if($('#id').val()==''){	
		$.post('/addmenu',{name:name,price:price},function(data){
			if(data=='ok'){
				$('#btn,#clear').trigger('click');
			}
		},'text')
		return false;
	}
	else{
		$.post('/updatemenu',{id:$('#id').val(),name:name,price:price},function(data){
			if(data=='oko'){
				$('#btn,#clear').trigger('click');
			}
		},'text')
	}
})
.on('click','#tblboard tr',function(){
	let id = $(this).find('td:eq(0)').text();
	let name = $(this).find('td:eq(1)').text();
	let price = $(this).find('td:eq(2)').text();
	
	$('#id').val(id);
	$('#name').val(name);
	$('#price').val(price);
	})
.on('click','#del',function(){
	if(!confirm('진짜 지움?')) return false;
	let id = $('#id').val();
	$.post('/delmenu',{id:id},function(data){
		if(data=='ooo'){	
			$('#clear,#btn').trigger('click');
			}
		
	},'text')	
	})
</script>
</html>