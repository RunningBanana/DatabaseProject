<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page language="java" import="java.text.*, java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>KnuMovie Site</title>
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
<h1>Welcome to KnuMovie Site</h1>
	<hr>
	<form action="register.jsp" method="POST">
		<table class="t1">
			<tr>
				<th>ID</th>
				<td><input type="text" name="ID"> <input type="button" value="ID 중복체크"></td>
			</tr>
			<tr>
				<th>비밀번호</th>
				<td><input type="text" name="Password"></td>
			</tr>
			<tr>
             <td colspan="2">
            	 <input type="button" value="회원가입" onclick="location.href='register.html'">
               <input type="submit" value="로그인">
            </td>
           </tr>
		</table>
	</form>
</body>
</html>