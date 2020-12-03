<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page language="java"
	import="java.text.*, java.sql.*, java.util.*, java.util.Date"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>영상물 등록 처리중...</title>
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
	String AccountID = (String)session.getAttribute("AccountID");
	String sql = "";
	
	try {
		stmt = conn.createStatement();
		String Title = request.getParameter("title");
		String Type = request.getParameter("type");
		String IsAdult = request.getParameter("adult");
		String StartDate = request.getParameter("startdate");
		String runTimes = request.getParameter("length");
		String Genre = request.getParameter("genre");
		int GenreID= 0, MovieID = 0;
		
		
		sql = "INSERT INTO MOVIE (Title, Type, IsAdult, StartDate, runTimes) VALUES('" + Title + "', '" + Type
				+ "', '" + IsAdult + "', '" + StartDate + "', " + runTimes + ")";
		stmt.executeUpdate(sql);
		sql = "SELECT MovieID FROM MOVIE WHERE Title='" + Title + "' AND Type='" + Type + "' AND StartDate='"
				+ StartDate + "' AND runTimes=" + runTimes;
		rs = stmt.executeQuery(sql);
		while (rs.next()) {
			MovieID = rs.getInt(1);
		}
		sql = "SELECT GenreID FROM GENRE WHERE Genre='" + Genre + "'";
		rs = stmt.executeQuery(sql);
		while (rs.next()) {
			GenreID = rs.getInt(1);
		}
		sql = "INSERT INTO BELONG (MovieID, GenreID) VALUES(" + MovieID + ", " + GenreID + ")";
		stmt.executeUpdate(sql);
		
		System.out.print("영상물 등록 완료");
		stmt.close();
	} catch (SQLException ex) {
		System.err.println("sql error = " + ex.getMessage());
		System.exit(1);
	}
	session.removeAttribute("MovieID");
	%>
	<script type="text/javascript">
		window.onload = function() {
			alert("영상물 등록이 완료되었습니다.");
			location.href="mainMenu.jsp";
		}
	</script>
</body>
</html>