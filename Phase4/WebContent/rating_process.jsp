<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page language="java"
	import="java.text.*, java.sql.*, java.util.*, java.util.Date"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>�� ó����..</title>
</head>
<body>
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
		System.exit(1);
	}
	double score = Double.parseDouble(request.getParameter("rate"));
	String AccountID = (String)session.getAttribute("AccountID");
	int MovieID = (Integer)session.getAttribute("MovieID");
	String sql = "";
	
	try {
		stmt = conn.createStatement();
		sql = "INSERT INTO RATING (MovieID, AccountID, Score) VALUES(" + MovieID + ", " + AccountID + ", " + score + ")";
		stmt.executeUpdate(sql);
		System.out.println("-----------------------------�� �Ϸ�--------------------------------");
		sql = "CREATE VIEW AvgScore AS " + "SELECT MovieID, Avg(Score) AS Avg " + "FROM RATING "
				+ "GROUP BY MovieID";
		stmt.executeUpdate(sql);
		sql = "UPDATE MOVIE " + "SET AverageScore = AvgScore.Avg " + "FROM AvgScore "
				+ "WHERE MOVIE.MovieID = AvgScore.MovieID";
		stmt.executeUpdate(sql);
		sql = "DROP VIEW AvgScore;";
		stmt.executeUpdate(sql);
		stmt.close();
		
		System.out.print("�� �Ϸ�");
	} catch (SQLException ex) {
		System.err.println("sql error = " + ex.getMessage());
		System.exit(1);
	}
	session.removeAttribute("MovieID");
	%>
	<script type="text/javascript">
		window.onload = function() {
			alert("�� �Ϸ�Ǿ����ϴ�.");
			location.href="mainMenu.jsp";
		}
	</script>
</body>
</html>