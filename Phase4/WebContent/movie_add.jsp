<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page language="java" import="java.text.*, java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>영상물 등록</title>
<style type="text/css">

 .movie_all{
	width: 1200px;
	height: 1200px;
	overflow: scroll;
}
table.movie_table {
	border-collapse: separate;
	border-spacing: 1px;
	text-align: left;
	line-height: 1.5;
	border-top: 1px solid #ccc;
	margin: auto;
}

th.movie_th {
	width: 150px;
	padding: 10px;
	font-weight: bold;
	vertical-align: top;
	border-bottom: 1px solid #ccc;
	background: #efefef;
}

td.movie_th {
	width: 350px;
	padding: 10px;
	vertical-align: top;
	border-bottom: 1px solid #ccc;
}
.btn:hover{
	background-color:#AAAAAA;  /* 배경색 */
	border:1px solid #000000;  /* 테두리 */
	color:#000000; /* 글자색 */
}
.btn, .search_btn{
	margin: 5px;
	border-radius: 4/4px;
	width: 70px;
	height: 40px;
}
.text{
	width: 80px;
	height: 40px;
}
.text_title{
	width: 200px;
	height: 40px;
}
p{
	size: 45px;
	display: inline;
}
.t1{
	width: 1200px;
	padding: 5px 0px 5px 0px
}
</style>
</head>
<body>
	<h1>영상물 등록</h1>
	<form action="" method="POST" onSubmit="return check(this)">
	<table class="t1">
			<tr height="2" bgcolor="#FFC8C3">
				<td colspan="2"></td>
			</tr>
			<tr>
				<th>영상 제목: </th>
				<td>
					<input type="text" name="title" placeholder="제목 입력(영어)">
				</td>
			</tr>
			<tr>
				<th>종류: </th>
				<td>
					<input type="radio" name="type" value="Movie">Movie
					<input type="radio" name="type" value="KnuMovieDB">KnuMovieDB
					<input type="radio" name="type" value="TV series">TV series
				</td>
			</tr>
			<tr>
				<th>성인제한 여부: </th>
				<td>
					<input type="radio" name="adult" value="Yes">19세이상
					<input type="radio" name="adult" value="No">19세이하
				</td>
			</tr>
			<tr>
				<th>상영 년도: </th>
				<td>
					<input type="date" name="startdate">
				</td>
			</tr>
			<tr>
				<th>영상 길이: </th>
				<td>
					<input type="text" name="length" placeholder="숫자 입력(영상길이)">
				</td>
			</tr>
			<tr>
				<th>장르: </th>
				<td>
					<input type="radio" name="genre" value="Action">Action
					<input type="radio" name="genre" value="Comedy">Comedy
					<input type="radio" name="genre" value="Romance">Romance
					<input type="radio" name="genre" value="SF">SF
					<input type="radio" name="genre" value="Horror">Horror
				</td>
			</tr>
			<tr height="2" bgcolor="#FFC8C3">
				<td colspan="2"></td>
			</tr>
			<tr>
				<td colspan="2" align="center">
				<input type="submit" value="등록하기">
				</td>
			</tr>
		</table>
		</form>
</body>
</html>