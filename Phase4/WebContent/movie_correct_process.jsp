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
	
	String Title = request.getParameter("title");
	String Type = request.getParameter("type");
	String IsAdult = request.getParameter("adult");
	String StartDate = request.getParameter("startdate");
	String runTimes = request.getParameter("length");
	String Genre = request.getParameter("genre");
	
	int MovieID = (Integer)session.getAttribute("MovieID");
	String sql = "";
	
	int cnt = 0;
	if(!Title.equals("None")) cnt++;
	if(!Type.equals("None")) cnt++;
	if(!IsAdult.equals("None")) cnt++;
	if(!StartDate.equals("None")) cnt++;
	if(!runTimes.equals("None")) cnt++;
	if(!Genre.equals("None")) cnt++;
	System.out.print(cnt);
	
	try {
		Class.forName("org.postgresql.Driver");
		System.out.println("Success!");
	} catch (ClassNotFoundException e) {
		System.out.println("error = " + e.getMessage());
	}

	try {
		conn = DriverManager.getConnection(url, user, password);
		conn.setAutoCommit(false);
	} catch (SQLException ex) {
		System.err.println("Cannot get a connection : " + ex.getMessage());
	}
	
	try {
		stmt = conn.createStatement();
		sql = "UPDATE MOVIE SET ";
		int res = 0;
		int update_cnt = 0;
		int check = 0;
		if(!Title.equals("None")){
			String temp = request.getParameter("title1");
			sql += "Title = '" + temp + "' ";
			check = 1;
			if((cnt > 1 && Genre.equals("None")) || cnt > 2 && !Genre.equals("None")) sql += " , ";
			cnt--;
		}
		
		if(!Type.equals("None")){
			sql += "Type='" + Type + "' ";
			check = 1;
			if((cnt > 1 && Genre.equals("None")) || cnt > 2 && !Genre.equals("None")) sql += " , ";
			cnt--;
		} 
		
		if(!IsAdult.equals("None")){
			if (IsAdult.equals("Yes"))
				IsAdult = "t";
			else
				IsAdult = "f";
			sql += "IsAdult = '" + IsAdult + "' ";
			check = 1;
			if((cnt > 1 && Genre.equals("None")) || cnt > 2 && !Genre.equals("None")) sql += " , ";
			cnt--;
		}
		
		if(!StartDate.equals("None")){
			String temp = request.getParameter("startdate1");
			sql += "StartDate='" + temp + "' ";
			check = 1;
			if((cnt > 1 && Genre.equals("None")) || cnt > 2 && !Genre.equals("None")) sql += " , ";
			cnt--;
		}
		if(!runTimes.equals("None")){
			String temp = request.getParameter("length1");
			sql += "runTimes=" + temp + " ";
			check = 1;
			if((cnt > 1 && Genre.equals("None")) || cnt > 2 && !Genre.equals("None")) sql += " , ";
			cnt--;
		}
		if(!Genre.equals("None")){
			String temp_sql = "UPDATE BELONG  SET GenreID = (SELECT GenreID FROM GENRE WHERE Genre='"
					+ Genre + "') WHERE MovieID=" + MovieID;
			cnt--;
			res += stmt.executeUpdate(temp_sql);
			update_cnt += 1;
		}
		if(check == 1){
			sql += " WHERE MovieID =" + MovieID;
			System.out.print(sql);
			res += stmt.executeUpdate(sql);
			update_cnt += 1;
		}
		if(res == update_cnt){
			conn.commit();
			System.out.print("영상물 수정 완료");
		}
		else{
			conn.rollback();
			System.out.print("영상물 수정 실패");
		}
		stmt.close();
		conn.close();
	} catch (SQLException ex) {
		conn.rollback();
		System.err.println("sql error = " + ex.getMessage());
	}
	session.removeAttribute("MovieID");
	%>
	<script type="text/javascript">
		window.onload = function() {
			alert("영상물 수정이 완료되었습니다.");
			location.href="mainMenu.jsp";
		}
	</script>
</body>
</html>