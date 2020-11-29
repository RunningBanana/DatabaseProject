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
				<td><input type="text" name="now_password"></td>
			</tr>
			<tr><td><br></td></tr>
			<tr>
				<th>변경 할 비밀번호: </th>
				<td><input type="text" name="password1"></td>
			</tr>
			<tr>
				<th>비밀번호 확인: </th>
				<td><input type="text" name="password2"></td>
			</tr>
			<tr height="2" bgcolor="#FFC8C3">
				<td colspan="2"></td>
			</tr>
			<tr>
				<td colspan="2" align="center">
				<input type="button" value="이전으로" onclick="location.href='customer.html'">
				<input type="button" value="변경하기" onclick="location.href=''">
				</td>
			</tr>
		</table>
</body>
</html>