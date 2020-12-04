<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page language="java" import="java.text.*, java.sql.*, java.util.*, java.util.Date"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>All Movie</title>
<style type="text/css">

 .movie_all{
 	margin: auto;
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
	background-color:#AAAAAA;  /* 배경색 */
	border:1px solid #000000;  /* 테두리 */
	color:#000000; /* 글자색 */
}
.btn{
	margin: 5px;
	border-radius: 4/4px;
	width: 70px;
	height: 40px;
}
.text{
	width: 100px;
	height: 40px;
}
p{
	size: 40px;
	display: inline;
}
</style>
</head>
<body>
	<h1>All movie</h1>
	<hr>
	<%
	Connection conn = null;
	String url = "jdbc:postgresql://localhost/university";
	String user = "university";
	String password = "comp322";
	ResultSet rs = null;
	Statement stmt = null;
	String sql = "SELECT MovieID, TiTle FROM MOVIE ORDER BY MovieID ASC";
	int res = 0;
	int count = 0;
	int[] Movie = new int[500];

	try {
		Class.forName("org.postgresql.Driver");
		System.out.println("Success!");
	} catch (ClassNotFoundException e) {
		System.out.println("error = " + e.getMessage());
	}

	try {
		conn = DriverManager.getConnection(url, user, password);
		conn.setAutoCommit(true);
	} catch (SQLException ex) {
		System.err.println("Cannot get a connection : " + ex.getMessage());
	}

	out.println("<div class='movie_all'>");
	out.println("<table class ='movie_table' border=\"1\">");
	try {
		stmt = conn.createStatement();
		rs = stmt.executeQuery(sql);

		while (rs.next()) {
			int MovieID = rs.getInt(1);
			String Title = rs.getString(2);
			Movie[++count] = MovieID;
			out.println("<tr class='movie_tr'>");
			out.println("<th class='movie_th'>[" + count + "]" + "영상 제목: "+"</th>"+"<td class='movie_td'>"+ Title + "</td>");
			out.println("</tr>");
		}
		stmt.close();
		conn.close();
	} catch (SQLException ex) {
		System.err.println("sql error = " + ex.getMessage());
	}
	out.println("</table> </div>");
	ArrayList<String> mm = new ArrayList<String>(500);
	for(int i=0; i<=count; i++){
		mm.add(Integer.toString(Movie[i]));
	}
	session.setAttribute("MovieID", mm);
	%>
	<hr>
	<div align="left">
	<form action="detail_movie_ad.jsp" method="POST">
	<p>영상물 수정하기:</p> <input name="num" type="text" placeholder="영상번호 입력"  class="text"><input type="submit" class="btn" value="선택">
	<input type="button" class="btn" value="이전으로" onclick="location.href='administrator.html'">
	</form>
	</div>
</body>
</html>