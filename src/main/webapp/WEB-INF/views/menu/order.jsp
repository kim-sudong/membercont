<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문관리</title>
</head>
<style>
    table {
        border-collapse: collapse;
        margin: auto;
    }
    td {
        width: 600px;
        vertical-align: top;
        text-align: center;
    }

    select {
        width: 570px;
        height: 600px;
    }

    input {
        vertical-align: middle;
    }

    option {
        font-size: 15px;
    }
    a {
        font-size: 25px;
        color: black;

    }  
 
</style>

<body>
	<input type=hidden id=id>
    <h1 style="font-size:36px;text-align:center;">카페 주문 관리</h1>
    <a href="/menuct">메뉴관리</a>  <a href="/orderct">주문관리</a><br><br>
    <table style="border:1px solid black;">
        <tr>
            <td>
                <table>
                    <tr>
                        <td colspan="2" style=font-size:25px;padding-bottom:15px;>메뉴목록</td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <select size="25" id="menu" style='max-height: 600px; overflow-y: auto;'>
                                <!--<option onclick="func0()">Latte,3000</option>
                                <option onclick="func0()">Mocca,3500</option>
                                <option onclick="func0()">Espresso,2400</option>
                                <option onclick="func0()">Americano,2500</option>
                                <option onclick="func0()">Green Tea,2400</option> -->
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td style=text-align:right;padding-right:15px;>메뉴명</td>
                        <td style="text-align:left"><input type=text id="name" readonly></td>
                    </tr>
                    <tr>
                        <td style=text-align:right;padding-right:15px;>수량</td>
                        <td style="text-align:left"><input type="number" min="1" id="cnt" onchange="func1()" value="1">
                        </td>
                    </tr>
                    <tr>
                        <td style=text-align:right;padding-right:15px;>금액</td>
                        <td style="text-align:left"><input type=text id="sum" readonly value="0"></td>
                    </tr>
                    <tr>
                        <td colspan="2" style="text-align:center">
                            <input type="button" value="주문완료" id="btnOrder" onclick="func3()">
                            <input type="button" value="취소" id="btnCancel" onclick="func4()">
                        </td>
                    </tr>
                </table>
            </td>
            <td>
                <table>
                    <tr>
                        <td colspan="2" style=font-size:25px;padding-bottom:15px;>주문내역</td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <select size="30" id="order" >

                            </select>
                        </td>
                    </tr>
            </td>
        </tr>
        <tr>
            <td style=text-align:right;padding-right:15px;>총액</td>
            <td style="text-align:left"><input type=text id="chong" readonly value="0"></td>
        </tr>
        <tr>
            <td style=text-align:right;padding-right:15px;>모바일번호</td>
            <td style="text-align:left"><input type="number" id="mobile"></td>
        </tr>
        <tr>
            <td colspan="2" style="text-align:center">
                <input type="button" value="주문완료" id="comp" onclick="func5()">
                <input type="button" value="취소" id="canc" onclick="func2()">
            </td>
        </tr>
    </table>
    </td>
    <td>
        <table>
            <tr>
                <td colspan="2" style=font-size:25px;padding-bottom:15px;>매출내역</td>
            </tr>
            <tr>
                <td colspan="2">
                   <!--  <select size="30" id="sales" >
                    </select> -->
                    <div  style="max-height: 600px;overflow-y: auto;border: 1px solid black;width: 570px;">
                    <table id=sales style='height:600px; width:570px; border:1px solid black;'>
                    	<thead style='border:1px solid black;'>
                    		<tr><td>번호</td><td>모바일</td><td>메뉴</td><td>수량</td><td>금액</td><td>일시</td></tr>
                    	</thead>
                    	<tbody>
                    	</tbody>
                    </table>
                    </div>
                </td>
            </tr>
            <tr>
                <td style=text-align:right;padding-right:15px;>총매출</td>
                <td style="text-align:left"><input type=text id="zx" readonly> 원</td>
            </tr>


        </table>
    </td>

    </tr>

    </table>
    </form>
</body>
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script>
$(document)
.ready(function(){
	loadmenu();
	getSales();
})
.on('click','#menu option',function() {
        let menu = getId("menu")
        let name = getId("name")
        let cnt = getId("cnt")
        let me;
		$('#id').val($(this).val());
		
        for (let i = 0; i < menu.length; i++) {
            if (menu[i].selected) {
                me = menu[i].text.split(",");
            }
        }
        me[1] = parseInt(me[1]);
        name.value = me[0]; sum.value = me[1];
})

	function loadmenu(){
		$.post('/getmenus',{},function(data){
			console.log(data);
			$('#menu').empty();
			for( let x of data){
				let str ='<option value='+x['id']+'>'+x['name']+','+x['price']+'</option>';
				$('#menu').append(str);
			}
		},'json')
	}

	
    function getId(id) {
        return document.getElementById(id);
    }

    function func1() {
        let sum = getId("sum");
        let menu = getId("menu");
        let cnt = getId("cnt")
        let me;

        for (let i = 0; i < menu.length; i++) {
            if (menu[i].selected) {
                me = menu[i].text.split(",")
            }
        }
        me[1] = parseInt(me[1]);
        sum.value = cnt.value * me[1];
    }

    function func2() {
        let chong = getId("chong");
        let mobile = getId("mobile");
        let order = getId("order");
        let id = getId("id");

        chong.value = 0;
        mobile.value = "";
        order.innerHTML = "";
    }

    function func3() {
        let name = getId("name");
        let cnt = getId("cnt");
        let sum = getId("sum");
        let chong = getId("chong");
        let id = getId("id");
        let total = 0;

        if (name.value == "") {
            alert("제대로 주문해라")
            return;
        }
        let op = document.createElement("option");
        op.text = name.value + " x " + cnt.value + " ," + sum.value;
        op.value = id.value;
        order.appendChild(op);
        name.value = "";
        cnt.value = 1;
        sum.value = 0;
		
        
        for (let i = 0; i < order.length; i++) {
            let me = order[i].text.split(",");
            me[1] = parseInt(me[1]);
            total += me[1];
        }
        chong.value = total;
       
    }

    function func4() {
        let name = getId("name");
        let cnt = getId("cnt");
        let sum = getId("sum");

        name.value = "";
        cnt.value = 1;
        sum.value = 0;
    }


    function func5() {
        let zx = getId("zx");
        let sales = getId("sales");
        let mobile = getId("mobile");
        let chong = getId("chong");
        let order = getId("order");
        let total = 0;
       /*  let salesop; */


       /*  for (let i = 0; i < order.length; i++) {
            let me = order[i].text.split(",");
            salesop = document.createElement("option");
            salesop.text = "모바일번호: " + mobile.value + ", 메뉴명: " + me[0] + ", 합계:" + me[1];
            sales.appendChild(salesop);


        } */
        for (let i = 0; i < order.length; i++) {
            	let me = order[i].text.split(",");
            	let mid = order[i].value;
            	/* 폰번호 mobile.value
            	메뉴명 me[0]
            	합계 me[1] */
            	let mee = me[0].split("x");
            	mee[1] = mee[1].replace(" ","");
            	mee[1] = mee[1].replace(" ","");
            	$.post('/addsales',{id:mid,qty:mee[1],price:me[1],mobile:mobile.value},function(data){
        				getSales();		
        		},'text')
        		console.log(order.length+"["+mid+"]["+mee[1]+"]["+me[1]+"]["+mobile.value+"]");
            	/* if(i == order.length-1)getSales(); */
        }
        
  /*       for (let i = 0; i < sales.length; i++) {
            let me1 = sales[i].text.split(":");
            total += parseInt(me1[3]);
        }


        zx.value = total; */
        order.innerHTML = "";
        mobile.value = "";
        chong.value = "";
      /*   $.post('/addsales2',{1:1},function(data){
        	if(data=="ok")getSales();
		},'text') */

    }
    function getSales(){
    /* 	let total = 0;
    	$.post('/getsales',{},function(data){
    		$('#sales').empty();
			console.log(data);
			for( let x of data){
				if(x['mobile']=='')x['mobile'] = '------------------';
				str ='<option>'+x['id']+'. 모바일: '+x['mobile']+', '+x['name']+', '+x['qty']+', '+x['price']+
						'원, '+x['create']+'</option>';
				$('#sales').append(str);
				total += parseInt(x['price']);
				console.log(total);
				$('#zx').val(total);
			}
		},'json') */
		let total = 0;
    	$.post('/getsales',{},function(data){
    		$('#sales tbody').empty();
			console.log(data);
			for( let x of data){
				if(x['mobile']=='')x['mobile'] = '------------------';
				str ='<tr><td>'+x['id']+'</td><td>'+x['mobile']+'</td><td>'+x['name']+'</td><td>'+x['qty']+'</td><td>'+x['price']+
						'</td><td>'+x['create']+'</td></tr>';
				$('#sales tbody').prepend(str);
				total += parseInt(x['price']);
				console.log(total);
				$('#zx').val(total);
			}
		},'json')
    }
		
//function gettest(){
//   	    	$.post('/qtest',{},function(data){
//  	    		console.log('zzzzzzzzzzzzzzzzz',data)
// 			},'text')
    			
//}
		
	
    


</script>
</html>