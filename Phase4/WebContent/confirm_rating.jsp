<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page language="java"
	import="java.text.*, java.sql.*, java.util.*, java.util.Date"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>평가내역 확인</title>
<style type="text/css">

 .movie_all{
 	margin: auto;
	width: 900px;
	height: 300px;
	overflow: scroll;
}
table.rating_table {
	border-collapse: separate;
	border-spacing: 1px;
	text-align: left;
	line-height: 1.5;
	border-top: 1px solid #ccc;
	margin: auto;
}

th.rating_th {
	width: 150px;
	padding: 10px;
	font-weight: bold;
	vertical-align: top;
	border-bottom: 1px solid #ccc;
	background: #efefef;
}

td.rating_td {
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
	width: 110px;
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
<h1>자신의 평가내역</h1>
	<%
	Connection conn = null;
	String url = "jdbc:postgresql://localhost/university";
	String user = "university";
	String password = "comp322";
	ResultSet rs = null;
	Statement stmt = null;
	PreparedStatement ps = null;
	int count = 1;
	
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
	String AccountID = (String)session.getAttribute("AccountID");
	String sql = "";
	
	out.println("<div class='movie_all'>");
	out.println("<table class ='rating_table' border=\"1\">");
	try {
		stmt = conn.createStatement();
		sql = "SELECT M.Title, R.Score FROM Movie M, Rating R WHERE R.AccountID = ? AND R.MovieID = M.MovieID";
		ps = conn.prepareStatement(sql);
		ps.setInt(1, Integer.parseInt(AccountID));
		rs = ps.executeQuery();

		out.println("<tr class='rating_tr'><th class='rating_tr'>항목 이름</th><th class='rating_tr'>영상물 제목</th><th class='rating_tr'>평점</th></tr>");
		while (rs.next()) {
			String title = rs.getString(1);
			Double AverageScore = rs.getDouble(2);
			
			out.println("<tr class='rating_tr'>");
			out.println("<th class='rating_th'>[" + count + "]" + "영상 제목: "+"</th>"+"<td class='rating_td'>"+ title + "</td>" + "<td class='rating_td'>"+ AverageScore + "</td>");
			out.println("</tr>");
			count++;
		}
		ps.close();
		stmt.close();
		conn.close();
	} catch (SQLException ex) {
		System.err.println("sql error = " + ex.getMessage());
	}
	out.println("</table> </div>");
	%>
	<hr>
	<input type="button" value="이전으로" class="btn" onclick="location.href='rating.jsp'">
</body>
</html>