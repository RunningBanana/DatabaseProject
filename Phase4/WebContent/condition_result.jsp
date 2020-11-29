<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page language="java" import="java.text.*, java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>영상물 검색 결과</title>
<style type="text/css">
 .movie_all{
	width: 1200px;
	height: 800px;
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
	<h1>영상물 검색 결과</h1>
	<hr>
	<%
	Connection conn = null;
	String url = "jdbc:postgresql://localhost/university";
	String user = "university";
	String password = "comp322";
	ResultSet rs = null;
	Statement stmt = null;
	String AccountID = (String)session.getAttribute("AccountID");
	String type = request.getParameter("type");
	String adult = request.getParameter("adult");
	String length = request.getParameter("length");
	String genre = request.getParameter("genre");
	String score = request.getParameter("score");
	String version = request.getParameter("version");
	String sql = "SELECT MovieID, Title FROM MOVIE WHERE ";
	int cnt = 0;
	if(!type.equals("None")) cnt++;
	if(!adult.equals("None")) cnt++;
	if(!length.equals("None")) cnt++;
	if(!genre.equals("None")) cnt++;
	if(!score.equals("None")) cnt++;
	if(!version.equals("None")) cnt++;
	System.out.print(cnt);
	
	if(!type.equals("None")){
		sql += ("Type ='" + type + "' ");
		cnt--;
		if(cnt > 0) sql += " AND ";
	}
	
	if(!adult.equals("None")){
		if(adult.equals("Yes")){
			sql += ("IsAdult= '" + "t" + "' ");
			cnt--;
		}
		else if(adult.equals("No")){
			sql += ("IsAdult= '" + "f" + "' ");
			cnt--;
		}
		if(cnt > 0) sql += " AND ";
	} 
	
	if(!length.equals("None")){
		sql += ("runTimes >=" + request.getParameter("length1") + " ");
		cnt--;
		if(cnt > 0) sql += " AND ";
	}
	
	if(!genre.equals("None")){
		sql += ("MovieID in(SELECT B.MovieID FROM BELONG B, GENRE G WHERE B.GenreID = G.GenreID AND G.Genre ='"
				+ genre + "') ");
		cnt--;
		if(cnt > 0) sql += " AND ";
	}
	if(!score.equals("None")){
		sql += ("AverageScore >=" + request.getParameter("score1") + " ");
		cnt--;
		if(cnt > 0) sql += " AND ";
	}
	if(!version.equals("None")){
		sql += ("MovieID in (SELECT MovieID FROM VERSION WHERE Region='" + version + "') ");
	}
	sql += ("AND MovieID Not in (SELECT R.MovieID FROM RATING R WHERE R.AccountID = " + AccountID + ")");
	System.out.print(sql);
	
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
		System.exit(1);
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
	} catch (SQLException ex) {
		System.err.println("sql error = " + ex.getMessage());
		System.exit(1);
	}
	out.println("</table> </div>");
	%>
	<hr>
	<div align="left">
	<p>자세한 정보보기:</p> <input type="text" placeholder="영상번호 입력"  class="text"><input type="button" class="btn" value="선택">
	<input type="button" class="btn" value="이전으로" onclick="location.href='movie.html'">
	</div>
</body>
</html>