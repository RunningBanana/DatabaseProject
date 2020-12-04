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
	}
	
	try {
		String ID = request.getParameter("id");
		stmt = conn.createStatement();
		String sql = "SELECT * FROM ACCOUNT WHERE id = ?";
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setString(1, ID);
		rs = ps.executeQuery();
		if(rs.next()){
			out.println("no");
			System.out.print("no");
		}
		else{
			out.println("yes");
			System.out.print("yes");
		}
		ps.close();
		stmt.close();
		conn.close();
	} catch (SQLException ex) {
		System.err.println("sql error = " + ex.getMessage());
	}
%>