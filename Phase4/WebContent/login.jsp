<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page language="java" import="java.sql.*"%>

<%

	Connection conn = null;
	String url = "jdbc:postgresql://localhost/university";
	String user = "university";
	String password = "comp322";
	ResultSet rs = null;
	Statement stmt = null;
	int res = 0;
		
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
		String ID = request.getParameter("id");
		String Password = request.getParameter("password");
		stmt = conn.createStatement();
		String sql = "SELECT AccountID FROM ACCOUNT WHERE ID = ? AND PASSWORD = ?";
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setString(1, ID);
		ps.setString(2, Password);
		rs = ps.executeQuery();
		if (rs.next()) {
			session.setAttribute("ID", ID);
			out.println("로그인하였습니다.");
		} else {
			out.println("존재하지 않는 ID거나 비밀번호가 일치하지 않습니다.");
		}
		ps.close();
		stmt.close();
	} catch (SQLException ex) {
		System.err.println("sql error = " + ex.getMessage());
		System.exit(1);
	}
%>