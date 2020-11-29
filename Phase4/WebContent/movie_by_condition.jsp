<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page language="java" import="java.text.*, java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>조건으로 영상물 검색</title>
<style type="text/css">

 .movie_all{
	width: 1200px;
	height: 900px;
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
<script type="text/javascript">
	function check(Join){
		var type = document.getElementsByName("type");
		var adult = document.getElementsByName("adult");
		var length = document.getElementsByName("length");
		var genre = document.getElementsByName("genre");
		var score = document.getElementsByName("score");
		var version = document.getElementsByName("version");

		if(type[type.length-1].checked == true && adult[adult.length-1].checked == true 
				&& length[length.length-1].checked == true && genre[genre.length-1].checked == true && 
				score[score.length-1].checked == true && version[version.length-1].checked == true){
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
	<h1>조건으로 영상물 검색</h1>
	<form action="condition_result.jsp" method="POST" onSubmit="return check(this)">
	<table class="t1">
			<tr height="2" bgcolor="#FFC8C3">
				<td colspan="2"></td>
			</tr>
			<tr>
				<th>종류: </th>
				<td>
					<input type="radio" name="type" value="Movie">Movie
					<input type="radio" name="type" value="KnuMovieDB">KnuMovieDB
					<input type="radio" name="type" value="TV series">TV series
					<input type="radio" name="type" value="None" checked="checked">미사용
				</td>
			</tr>
			<tr>
				<th>성인제한 여부: </th>
				<td>
					<input type="radio" name="adult" value="Yes">19세이상
					<input type="radio" name="adult" value="No">19세이하
					<input type="radio" name="adult" value="None" checked="checked">미사용
				</td>
			</tr>
			<tr>
				<th>최소영상 길이: </th>
				<td>
					<input type="radio" name="length" value="Yes">사용
					<input type="text" name="length1" placeholder="숫자 입력(영상길이)">
					<input type="radio" name="length" value="None" checked="checked">미사용
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
					<input type="radio" name="genre" value="None" checked="checked">미사용
				</td>
			</tr>
			<tr>
				<th>최소 평점: </th>
				<td>
					<input type="radio" name="score" value="Yes">사용
					<input type="text" name="score1" placeholder="평점 입력(숫자)">
					<input type="radio" name="score" value="None" checked="checked">미사용
				</td>
			</tr>
			<tr>
				<th>버전: </th>
				<td>
					<input type="radio" name="version" value="GB">GB
					<input type="radio" name="version" value="US">US
					<input type="radio" name="version" value="KR">KR
					<input type="radio" name="version" value="None" checked="checked">미사용
				</td>
			</tr>
			<tr height="2" bgcolor="#FFC8C3">
				<td colspan="2"></td>
			</tr>
			<tr>
				<td colspan="2" align="center">
				<input type="button" value="이전으로" class="subm" onclick="location.href='movie.html'">
				<input type="submit" value="검색하기">
				</td>
			</tr>
		</table>
		</form>
</body>
</html>