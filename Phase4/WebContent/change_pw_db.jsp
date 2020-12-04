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
		conn.setAutoCommit(false);
	} catch (SQLException ex) {
		out.println("Cannot get a connection : " + ex.getMessage());
	}
	
	try {
		String now_password = request.getParameter("now_password");
		String change_password = request.getParameter("change_password");
		String AccountID = (String)session.getAttribute("AccountID");
		int AccountID_int = Integer.parseInt(AccountID);
		String sql = "";
		ResultSet rs = null;
		int res = 0;
		int count = 0;
		stmt = conn.createStatement();
		sql = "SELECT * FROM ACCOUNT WHERE AccountID = ? AND PASSWORD = ?";
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setInt(1, AccountID_int);
		ps.setString(2, now_password);
		rs = ps.executeQuery();
		if (!rs.next()) {
			out.println("현재 비밀번호가 틀렸습니다.");
			conn.rollback();
		} else {
			sql = "UPDATE ACCOUNT SET PASSWORD = ? WHERE accountID = ?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, change_password);
			ps.setInt(2, AccountID_int);
			res = ps.executeUpdate();
			if (res == 1) {
				out.println("비밀번호 변경에 성공하셨습니다.");
				conn.commit();
			} else {
				out.println("비밀번호 변경에 실패하셨습니다.");
				conn.rollback();
			}
		}
		ps.close();
		stmt.close();
		conn.close();
	} catch (SQLException ex) {
		conn.rollback();
		System.err.println("sql error = " + ex.getMessage());
	}
%>