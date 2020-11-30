<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page language="java" import="java.sql.*"%>

<%
	Connection conn = null;
	String url = "jdbc:postgresql://localhost/university";
	String user = "university";
	String password = "comp322";
	Statement stmt = null;
	
	try {
		Class.forName("org.postgresql.Driver");
	} catch (ClassNotFoundException e) {
		out.println("error = " + e.getMessage());
	}
	
	try {
		conn = DriverManager.getConnection(url, user, password);
		conn.setAutoCommit(true);
	} catch (SQLException ex) {
		out.println("Cannot get a connection : " + ex.getMessage());
		System.exit(1);
	}
	
	try {
		String AccountID = (String)session.getAttribute("AccountID");
		int AccountID_int = Integer.parseInt(AccountID);
		String sql = "";
		PreparedStatement ps = null;
		ResultSet rs = null;
		int res = 0;
		int count = 0;
		stmt = conn.createStatement();
		stmt = conn.createStatement();
		sql = "SELECT * FROM ACCOUNT WHERE AccountID = ? AND Membership = 'Admin'";
		ps = conn.prepareStatement(sql);
		ps.setInt(1, AccountID_int);
		rs = ps.executeQuery();
		boolean isAdmin = false;
		boolean canWithdrawal = true;
		if (rs.next())
			isAdmin = true;
		if (isAdmin) {
			sql = "SELECT COUNT(*) FROM ACCOUNT WHERE Membership = 'Admin'";
			rs = stmt.executeQuery(sql);
			if (rs.next() && (rs.getInt(1) <= 1)) { //1.F 관리자 계정은 최소 1개 이상 필수
				out.println("관리자 계정은 최소 1개 이상 존재하여야 합니다.");
				canWithdrawal = false;
			}
		}
		if(canWithdrawal){
			sql = "DELETE FROM ACCOUNT WHERE AccountID = ?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, AccountID_int);
			res = ps.executeUpdate();
			if (res == 1) {
				sql = "CREATE VIEW AvgScore AS " + "SELECT MovieID, Avg(Score) AS Avg " + "FROM RATING "
						+ "GROUP BY MovieID";
				stmt.executeUpdate(sql);
				sql = "UPDATE MOVIE " + "SET AverageScore = AvgScore.Avg " + "FROM AvgScore "
						+ "WHERE MOVIE.MovieID = AvgScore.MovieID";
				stmt.executeUpdate(sql);
				sql = "DROP VIEW AvgScore;";
				stmt.executeUpdate(sql);
				out.println("회원탈퇴가 완료되었습니다.");
			} else {
				out.println("회원탈퇴에 실패하셨습니다.");
			}
		}
		ps.close();
		stmt.close();
	} catch (SQLException ex) {
		System.err.println("sql error = " + ex.getMessage());
		System.exit(1);
	}
%>