<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page language="java" import="java.text.*, java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>�������� �˻�</title>
<style type="text/css">

 .movie_all{
	width: 900px;
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
	background-color:#AAAAAA;  /* ���� */
	border:1px solid #000000;  /* �׵θ� */
	color:#000000; /* ���ڻ� */
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
	width: 250px;
	height: 40px;
}
p{
	size: 45px;
	display: inline;
}
</style>
</head>
<body>
	<h1>�������� �˻�</h1>
	<form action="" method="POST">
	<p>���� �Է�: </p><input type="text" placeholder="���� �Է�"  class="text_title" name="title"><input type="submit" class="search_btn" value="�˻�" >
	</form>
	<hr>
	<input type="button" class="btn" value="��������" onclick="location.href='movie.html'">
</body>
</html>