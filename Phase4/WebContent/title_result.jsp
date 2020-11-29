<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page language="java" import="java.text.*, java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>���� �˻� ���</title>
<style type="text/css">
 .movie_all{
	width: 100%;
	height: 80%;
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
	<h1>���� �˻� ���</h1>
	<hr>
	<%
	Connection conn = null;
	String url = "jdbc:postgresql://localhost/university";
	String user = "university";
	String password = "comp322";
	ResultSet rs = null;
	Statement stmt = null;
	String AccountID = (String)session.getAttribute("AccountID");
	String search_title = request.getParameter("title");
	String sql = "SELECT M.MovieID, M.Title FROM MOVIE M WHERE M.Title='" + search_title + "' "
			+ "AND M.MovieID Not in (SELECT R.MovieID FROM RATING R WHERE R.AccountID = " + AccountID + ")";
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
			out.println("<th class='movie_th'>[" + count + "]" + "���� ����: "+"</th>"+"<td class='movie_td'>"+ Title + "</td>");
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
	<p>�ڼ��� ��������:</p> <input type="text" placeholder="�����ȣ �Է�"  class="text"><input type="button" class="btn" value="����">
	<input type="button" class="btn" value="��������" onclick="location.href='movie.html'">
	</div>
</body>
</html>