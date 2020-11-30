<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page language="java" import="java.text.*, java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Change Password</title>
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
			width: 940px;
			padding: 5px 0px 5px 0px
		}
</style>
</head>
<body>
	<h1>비밀번호 변경</h1>
	<table class="t1">
			<tr height="2" bgcolor="#FFC8C3">
				<td colspan="2"></td>
			</tr>
			<tr>
				<th>현재 비밀번호: </th>
				<td><input type="text" name="now_password" id="now_password"></td>
			</tr>
			<tr><td><br></td></tr>
			<tr>
				<th>변경 할 비밀번호: </th>
				<td><input type="text" name="password1" id="password1"></td>
			</tr>
			<tr>
				<th>비밀번호 확인: </th>
				<td><input type="text" name="password2" id="password2"></td>
			</tr>
			<tr height="2" bgcolor="#FFC8C3">
				<td colspan="2"></td>
			</tr>
			<tr>
				<td colspan="2" align="center">
				<input type="button" value="이전으로" onclick="location.href='customer.html'">
				<input type="button" value="변경하기" onclick="change_password()">
				</td>
			</tr>
	</table>
	<script>
   	 	function change_password() {
   	 		var now_password = document.getElementById("now_password").value;
   	 		var password1 = document.getElementById("password1").value;
   	 		var password2 = document.getElementById("password2").value;
   	 		if(password1 != password2)
   	 			alert("변경할 비밀번호와 비밀번호 확인이 일치하지 않습니다.");
   	 		else{
   	 			var xhr = new XMLHttpRequest();
	  	 	    xhr.open('POST', 'change_pw_db.jsp', true);
  	 	    	xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
  	 	    	xhr.onreadystatechange = function(){
  	 	        	if(xhr.readyState == 4){
	  	 	        	if(xhr.status == 200){
  	 	            		result = xhr.responseText;
  	 	            		alert(result);
  	 	            		if(result.includes("성공"))
  	 	            			document.location.href="customer.html";
  	 					}
  	 	        	}
  	 	    	}
  	 	    	xhr.send('now_password=' + encodeURIComponent(now_password) + '&change_password=' + encodeURIComponent(password1)); 			
   	 		}
  			
    	}
	</script>
</body>
</html>