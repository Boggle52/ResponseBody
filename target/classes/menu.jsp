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
th,td{
	border:1px solid black;
}
</style>
<body>
<table id=tblEdit>
<tr><td>메뉴명</td><td><input type=text id=name></td></tr>
<tr><td>가격</td><td><input type=number id=price></td></tr>
<tr><td colspan=2><input type=button id=btnAdd value='추가'>
	<input type=button id=btnReset value='비우기'></td></tr>
</table>
<input type=hidden id='seqno' value=''>
<br><br>
<table id=tblData>
<tr><th>번호</th><th>메뉴명</th><th>가격</th><th></th></tr>
</table>
</body>
<script src='https://code.jquery.com/jquery-3.4.1.js'></script>
<script>
$(document)
.ready(function(){
	showMenu()
})
.on('click','#btnAdd',function(){
	if($('#name').val()==''||$('#price').val()==''){
		alert('메뉴명과 가격은 모두 입력되어야 합니다.')
	}
	if($(this).val()=='추가'){
/* 		$.ajax({
			url:'addnew',
			data:'name='+$('#name').val()+'&price='+$('#price').val(),
			//data:{name:$('#name').val(), price:$('#price').val()},
			dataType:'json',type:'get',
			success:function(data){
				showMenu()
				$('#btnReset').trigger('click')
			}
		}) */
		$.get('addnew',
			'name='+$('#name').val()+'&price='+$('#price').val(),
			function(data){
				showMenu()
				$('#btnReset').trigger('click')
			},'json')
	} else {
/* 		$.ajax({
			url:'change',type:'get',dataType:'json',
			data:{name:$('#name').val(),price:$('#price').val(),seqno:$('#seqno').val()},
			success:function(data){
				showMenu()
				$('#btnReset').trigger('click')
			}
		}) */
		$.get('change',
			'name='+$('#name').val()+'&price='+$('#price').val()+'&seqno='+$('#seqno').val(),
			function(data){
				showMenu()
				$('#btnReset').trigger('click')
			},'json')
	}
})
.on('click','#btnReset',function(){
	$('#name,#price,#seqno').val('')
})
.on('click','#btnDelete',function(){
	let seqno = $(this).attr('seqno')
	/* $.ajax({
		url:'delete',data:{seqno:seqno},type:'get',dataType:'json',
		success:function(data){
			console.log(data)
			showMenu()
		}
	}) */
	$.get('delete','seqno='+seqno,function(){
		showMenu()
	},'json')
})
.on('click','#tblData tr:gt(0)',function(){
	let seqno=$(this).find('td:eq(0)').text()
	$('#seqno').val(seqno)
	let name = $(this).find('td:eq(1)').text()
	$('#name').val(name)
	let price = $(this).find('td:eq(2)').text()
	$('#price').val(price)
	$('#btnAdd').val('수정')
})

function showMenu(){
	/* $.ajax({
		url:'menulist',data:'',dataType:'json',type:'get',
		beforeSend:function(){
			$('#tblData tr:gt(0)').remove()
		},
		success:function(data){
			for(let i=0; i<data.length; i++){
				menuitem=data[i]
				let str = '<tr><td>'+menuitem['seqno']+'</td><td>'+menuitem['name']+
				'</td><td>'+menuitem['price']+'</td>'
				+'<td><button id=btnDelete seqno='+menuitem['seqno']+'>삭제</a></td></tr>'
				$('#tblData').append(str)
			}
		}
	}) */
	$('#tblData tr:gt(0)').remove()
	$.get('menulist','',function(data){
		for(let i=0; i<data.length; i++){
			menuitem=data[i]
			let str = '<tr><td>'+menuitem['seqno']+'</td><td>'+menuitem['name']+
			'</td><td>'+menuitem['price']+'</td>'
			+'<td><button id=btnDelete seqno='+menuitem['seqno']+'>삭제</a></td></tr>'
			$('#tblData').append(str)
		}
	},'json')
}
</script>
</html>