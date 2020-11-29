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
<script type="text/javascript">
	function check(Join){
		var membership = document.getElementsByName("membership");
		var name = document.getElementsByName("name");
		var address = document.getElementsByName("address");
		var sex = document.getElementsByName("sex");
		var birthdate = document.getElementsByName("birthdate");
		var job = document.getElementsByName("job");
		var phone = document.getElementsByName("phone");
		if(membership[membership.length-1].checked == true && name[name.length-1].checked == true 
				&& address[address.length-1].checked == true && phone[phone.length-1].checked == true && 
				sex[sex.length-1].checked == true && birthdate[birthdate.length-1].checked == true && job[job.length-1].checked == true){
			alert("하나 이상 선택해주세요.");
			return false;
		}
		else{
			return true;
		}
	}
</script>
</head>
<body>
	<h1>회원 정보 변경</h1>
	<form action="" method="POST" onSubmit="return check(this)">
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
					<input type="radio" name="membership" value="None" checked="checked">미변경
				</td>
			</tr>
			<tr>
				<th>Name: </th>
				<td>
					<input type="radio" name="name" value="Yes">변경
					<input type="text" name="name" value="이름 입력">
					<input type="radio" name="name" value="No" checked="checked">미변경
				</td>
			</tr>
			<tr>
				<th>Address: </th>
				<td>
					<input type="radio" name="address" value="Yes">변경
					<input type="text" name="address" placeholder="주소 입력(영어)">
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
					<input type="date" name="birthdate">
					<input type="radio" name="birthdate" value="No" checked="checked">미변경
				</td>
			</tr>
			<tr>
				<th>Job: </th>
				<td>
					<input type="radio" name="job" value="Yes">변경
					<input type="text" name="job" placeholder="직업 입력(영어)">
					<input type="radio" name="job" value="No" checked="checked">미변경
				</td>
			</tr>
			<tr>
				<th>Phone: </th>
				<td>
					<input type="radio" name="phone" value="Yes">변경
					<input type="tel" name="phone1" placeholder="숫자입력" width="15px">-<input type="tel" name="phone2" placeholder="숫자입력">-<input type="tel" name="phone3" placeholder="숫자입력">
					<input type="radio" name="phone" value="No" checked="checked">미변경
				</td>
			</tr>
			<tr height="2" bgcolor="#FFC8C3">
				<td colspan="2"></td>
			</tr>
			<tr>
				<td colspan="2" align="center">
				<input type="button" value="이전으로" onclick="location.href='customer.html'">
				<input type="submit" value="변경하기">
				</td>
			</tr>
			
		</table>
		</form>
</body>
</html>