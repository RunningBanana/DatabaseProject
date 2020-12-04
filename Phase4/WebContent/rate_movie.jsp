<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page language="java" import="java.text.*, java.sql.*, java.util.*, java.util.Date"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>영상물 평가하기</title>
<style type="text/css">

 .movie_all{
 	margin: auto;
	width: 900px;
	height: 300px;
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

td.movie_td {
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
	width: 120px;
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
	<h1>영상물 평가</h1>
	<hr>
	<%
	Connection conn = null;
	String url = "jdbc:postgresql://localhost/university";
	String user = "university";
	String password = "comp322";
	ResultSet rs = null;
	Statement stmt = null;

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
	int rate_movieID= (Integer)session.getAttribute("MovieID");
	
	String sql = "SELECT M.Title, M.Type, M.IsAdult, M.StartDate, M.AverageScore, M.runTimes, G.Genre FROM MOVIE M, GENRE G, BELONG B WHERE M.MovieID ="
			+ rate_movieID + " AND M.MovieID = B.MovieID AND B.GenreID = G.GenreID";
	
	out.println("<div class='movie_all'>");
	out.println("<table class ='movie_table' border=\"1\">");
	try {
		stmt = conn.createStatement();
		rs = stmt.executeQuery(sql);

		while (rs.next()) {
			String Title = rs.getString(1);
			String Type = rs.getString(2);
			boolean IsAdult = rs.getBoolean(3);
			Date StartDate = rs.getDate(4);
			Double AverageScore = rs.getDouble(5);
			int runTimes = rs.getInt(6);
			String Genre = rs.getString(7);

			
			out.println("<tr class='movie_tr'>");
			out.println("<tr class='movie_tr'><th class='movie_th'>영상 제목</th><th class='movie_th'>유형</th><th class='movie_th'>성인물 제한여부</th><th class='movie_th'>상영년도</th><th class='movie_th'>평균 평점</th><th class='movie_th'>재생 시간</th><th class='movie_th'>장르</th></tr>");
			out.println("<td class='movie_td'>"+ Title + "</td>"+"<td class='movie_td'>"+ Type + "</td>"
					+"<td class='movie_td'>"+ IsAdult + "</td>"+"<td class='movie_td'>"+ StartDate + "</td>"+"<td class='movie_td'>"+ AverageScore + "</td>"
					+"<td class='movie_td'>"+ runTimes + "</td>"+"<td class='movie_td'>"+ Genre + "</td>");
			out.println("</tr>");
		}
		stmt.close();
		conn.close();
	} catch (SQLException ex) {
		System.err.println("sql error = " + ex.getMessage());
	}
	out.println("</table> </div>");
	%>
	<hr>
	<form action="rating_process.jsp" method="POST">
	<input type="number" name="rate" id="rate" placeholder="점수입력" class="text" min="0" max="10" step="0.1"><input type="submit" class="btn" value="평가하기">
	</form>
</body>
</html>