<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>room</title>
</head>
<style>
table{
	border-collapse:collapse;
	border:1px solid black;
	margin:auto;
	
	
}
tr{
	/* border:1px solid black; */
}
#roomlist thead td{
	border:1px solid black;
}
td{
	text-align:center;
}
</style>
<body>
<table  style='margin-top: 75px;'>
	<tr>
		<td>
			<table id="roomlist" style='width:600px;height:650px;'>
				<thead>
					<tr><td>id</td><td>객실명</td><td>타입명</td><td>숙박인원</td><td>1박요금</td></tr>
				</thead>
				<tbody>
				</tbody>
			</table>
		</td>
		
		
		<td>
			<table style='width:600px;height:650px;'>
				<tr><td></td><td colspan="2"><input type=hidden id=id></td></tr>
				<tr><td>객실타입</td><td colspan="2"><select id=type style='width:170px;'>
													</select></td></tr>
				<tr><td>객실명</td><td colspan="2"><input type=text id=roomname></td></tr>
				<tr><td>숙박가능인원</td><td colspan="2"><input type=number id=person> 명</td></tr>
				<tr><td>1박요금</td><td colspan="2"><input type=number id=price> 원</td></tr>
				<tr><td colspan="3"><input type=button id=add value=등록>&nbsp;&nbsp;
									<input type=button id=reset value=비우기>&nbsp;&nbsp;
									<input type=button id=del value=삭제></td></tr>
				
			</table>
		</td>
	</tr>
</table>

</body>
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script>
$(document)
.ready(function(){
	loadtype();
	loadlist();
})
.on('click','#add',function(){
	let type = $('#type option:selected').text();
	let id = $('#type option:selected').val();
	let name = $('#roomname').val();
	let person = $('#person').val();
	let price = $('#price').val();
	
	if($('#id').val()==''){
		console.log(type,id);
		$.post('/insertRoom',{id:id,name:name,person:person,price:price},function(data){
			loadtype();
			loadlist();	
			clear();
		},'text')
		clear()	
	}else{
		$.post('/updateRoom',{id:id,name:name,person:person,price:price,list:$('#id').val()},function(data){
			loadtype();
			loadlist();
			clear();
		},'text')
	}
	
})
.on('click','#roomlist tbody tr',function(){
	let id = $(this).find('td:eq(0)').text();
	let name = $(this).find('td:eq(1)').text();
	let type = $(this).find('td:eq(2)').text();
	let person = $(this).find('td:eq(3)').text();
	let price = $(this).find('td:eq(4)').text();
	
	console.log(id,name,type,person,price);
	
	if(type == 'Suite Room') type = 1;
	if(type == 'Deluxe Room') type = 2;
	if(type == 'Family Room') type = 3;
	if(type == 'Double Room') type = 4;
	if(type == 'Single Room') type = 5;
	if(type == 'Domitory') type = 6;
	
	$('#id').val(id);
	$('#type').val(type);
	$('#roomname').val(name);
	$('#person').val(person);
	$('#price').val(price);
	
	
})
.on('click','#del',function(){
	let id = $('#id').val();
	console.log(id);
	
	if(id == '') return false;
	else{
		$.post('/delRoom',{id:id},function(data){
			loadtype();
			loadlist();
			clear();
		},'text')
	}
})
.on('click','#reset',function(){
	clear();
})
function loadtype(){
		$.post('/getType',{},function(data){
			console.log(data);
			$('#type').empty();
			for( let x of data){
				let str ='<option value='+x['id']+'>'+x['roomname']+'</option>';
				$('#type').append(str);
			}
		},'json')
	}
function loadlist(){
	$.post('/getRoomlist',{},function(data){
		console.log(data);
		$('#roomlist tbody').empty();
		for( let x of data){
			let str ='<tr><td>'+x['id']+'</td><td>'+x['name']+'</td><td>'+x['type']+'</td><td>'+x['person']+'</td><td>'+x['price']+'</td></tr>';
			$('#roomlist tbody').append(str);
		}
	},'json')
}
function clear(){
	$('#roomname,#person,#price,#type,#id').val('');
}

</script>
</html>