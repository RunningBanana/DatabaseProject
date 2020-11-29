<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page language="java" import="java.sql.*"%>

<%

	String check = request.getParameter("check");
	System.out.println(check);
	if(check.equals("-1")){
		out.println("ID 중복체크를 진행해주세요");
	}
	else if(check.equals("0")){
		out.println("사용할 수 없는 ID입니다.");
	}
	else{
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
			String Name = request.getParameter("name");
			String BirthDate = request.getParameter("birth");
			String sql = "INSERT INTO ACCOUNT(Id, Password, Name, BirthDate) VALUES(?, ?, ?, ?)";
			stmt = conn.createStatement();
			PreparedStatement ps = conn.prepareStatement(sql);

			Date date = Date.valueOf(BirthDate);
			ps.setString(1, ID);
			ps.setString(2, Password);
			ps.setString(3, Name);
			ps.setDate(4, date);
			res = ps.executeUpdate();
			out.println("회원가입이 완료되었습니다.");
			ps.close();
			stmt.close();
		} catch (SQLException ex) {
			System.err.println("sql error = " + ex.getMessage());
		}
	}
%>