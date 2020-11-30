<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page language="java" import="java.text.*, java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Change Information</title>
<style>
		.subm{  /* 버튼 스타일 */
			display:block;  /* 블록 레벨 요소 */
			background-color:#fff;  /* 배경색 */
			border:1px solid #dedede;  /* 테두리 */
			cursor:pointer;  /* 마우스 포인터 */
			padding:5px 10px 6px 7px;	/* 패딩 */
		}
		.subm:hover{  /* 버튼 위로 마우스 포인터 올렸을 때 스타일 */
			background-color:#AAAAAA;  /* 배경색 */
			border:1px solid #000000;  /* 테두리 */
			color:#000000; /* 글자색 */
		}
		.t1{
			width: 1200px;
			padding: 5px 0px 5px 0px
		}
</style>
</head>
<body>
	<h1>회원 정보 변경</h1>
	<form action="" method="POST">
	<table class="t1">
			<tr height="2" bgcolor="#FFC8C3">
				<td colspan="2"></td>
			</tr>
			<tr>
				<th>Membership: </th>
				<td>
					<input type="radio" name="membership" value="Basic">Basic
					<input type="radio" name="membership" value="Premium">Premium
					<input type="radio" name="membership" value="Prime">Prime
					<input type="radio" name="membership" value="No" checked="checked">미변경
				</td>
			</tr>
			<tr>
				<th>Name: </th>
				<td>
					<input type="radio" name="name" value="Yes">변경
					<input type="text" name="nametext" id="name" placeholder="이름 입력">
					<input type="radio" name="name" value="No" checked="checked">미변경
				</td>
			</tr>
			<tr>
				<th>Address: </th>
				<td>
					<input type="radio" name="address" value="Yes">변경
					<input type="text" name="address" id="address" placeholder="주소 입력(영어)">
					<input type="radio" name="address" value="No" checked="checked">미변경
				</td>
			</tr>
			<tr>
				<th>Sex: </th>
				<td>
					<input type="radio" name="sex" value="Male">Male
					<input type="radio" name="sex" value="Female">Female
					<input type="radio" name="sex" value="No" checked="checked">미변경
				</td>
			</tr>
			<tr>
				<th>BirthDate: </th>
				<td>
					<input type="radio" name="birthdate" value="Yes">변경
					<input type="date" name="birthdate" id="birthdate">
					<input type="radio" name="birthdate" value="No" checked="checked">미변경
				</td>
			</tr>
			<tr>
				<th>Job: </th>
				<td>
					<input type="radio" name="job" value="Yes">변경
					<input type="text" name="job" id="job" placeholder="직업 입력(영어)">
					<input type="radio" name="job" value="No" checked="checked">미변경
				</td>
			</tr>
			<tr>
				<th>Phone: </th>
				<td>
					<input type="radio" name="phone" value="Yes">변경
					<input type="tel" name="phone1" id="phone1" placeholder="숫자입력" width="15px">-<input type="tel" name="phone2" id="phone2" placeholder="숫자입력">-<input type="tel" name="phone3" id="phone3" placeholder="숫자입력">
					<input type="radio" name="phone" value="No" checked="checked">미변경
				</td>
			</tr>
			<tr height="2" bgcolor="#FFC8C3">
				<td colspan="2"></td>
			</tr>
			<tr>
				<td colspan="2" align="center">
				<input type="button" value="이전으로" onclick="location.href='customer.html'">
				<input type="button" value="변경하기" onclick="change_info()">
				</td>
			</tr>
			
	</table>
	</form>
	<script>
   	 	function change_info() {
			var membership_count = document.getElementsByName("membership").length;
			var membership;
   	 		for (var i=0; i<membership_count; i++) {
				if (document.getElementsByName("membership")[i].checked == true) {
					membership = document.getElementsByName("membership")[i].value;
				}
   	 		}
      		var name_count = document.getElementsByName("name").length;
      		var name;
      		for (var i=0; i<name_count; i++) {
	          	if (document.getElementsByName("name")[i].checked == true) {
             		name = document.getElementsByName("name")[i].value;
             		if(name.includes("Yes")){
             			name = document.getElementById("name").value;
             		}
      	 		}
       		}
      		
      		var address_count = document.getElementsByName("address").length;
      		var address;
      		for (var i=0; i<address_count; i++) {
	          	if (document.getElementsByName("address")[i].checked == true) {
             		address = document.getElementsByName("address")[i].value;
             		if(address.includes("Yes")){
             			address = document.getElementById("address").value;
             		}
      	 		}
       		}
      		var sex_count = document.getElementsByName("sex").length;
			var sex;
   	 		for (var i=0; i<sex_count; i++) {
				if (document.getElementsByName("sex")[i].checked == true) {
					sex = document.getElementsByName("sex")[i].value;
				}
   	 		}
   	 		var birthdate_count = document.getElementsByName("birthdate").length;
  			var birthdate;
  			for (var i=0; i<birthdate_count; i++) {
	          	if (document.getElementsByName("birthdate")[i].checked == true) {
         			birthdate = document.getElementsByName("birthdate")[i].value;
         			if(birthdate.includes("Yes")){
	         			birthdate = document.getElementById("birthdate").value;
         			}
  	 			}
   			}
  			var job_count = document.getElementsByName("job").length;
  			var job;
  			for (var i=0; i<job_count; i++) {
	          	if (document.getElementsByName("job")[i].checked == true) {
         			job = document.getElementsByName("job")[i].value;
         			if(job.includes("Yes")){
	         			job = document.getElementById("job").value;
         			}
  	 			}
   			}
  			var phone_count = document.getElementsByName("phone").length;
  			var phone;
  			for (var i=0; i<phone_count; i++) {
	          	if (document.getElementsByName("phone")[i].checked == true) {
         			phone = document.getElementsByName("phone")[i].value;
         			if(phone.includes("Yes")){
	         			var phone1 = document.getElementById("phone1").value;
	         			var phone2 = document.getElementById("phone2").value;
	         			var phone3 = document.getElementById("phone3").value;
	         			phone = phone1 + '-' + phone2 + '-' + phone3;
         			}
  	 			}
   			}
  			
  			var xhr = new XMLHttpRequest();
  	 	    xhr.open('POST', 'change_info_db.jsp', true);
  	 	    xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
  	 	    xhr.onreadystatechange = function(){
  	 	        if(xhr.readyState == 4){
  	 	        	if(xhr.status == 200){
  	 	            	result = xhr.responseText;
  	 	            	alert(result);
  	 	            	document.location.href="customer.html";
  	 				}
  	 	        }
  	 	    }
  	 	    xhr.send('membership=' + encodeURIComponent(membership) + '&name=' + encodeURIComponent(name) + '&address=' + encodeURIComponent(address) + 
  	 	    		'&sex=' + encodeURIComponent(sex) + '&birthdate=' + encodeURIComponent(birthdate) + '&job=' + encodeURIComponent(job) + '&phone=' + encodeURIComponent(phone));
    	}
	</script>
		
		
</body>
</html>