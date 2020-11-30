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
		String membership = request.getParameter("membership");
		String name = request.getParameter("name");
		String address = request.getParameter("address");
		String sex = request.getParameter("sex");
		String birthdate = request.getParameter("birthdate");
		String job = request.getParameter("job");
		String phone = request.getParameter("phone");
		String AccountID = (String)session.getAttribute("AccountID");
		int AccountID_int = Integer.parseInt(AccountID);
		int res = 0;
		int count = 0;
		stmt = conn.createStatement();
		String sql = "";
		if(!membership.equals("No")){
			sql = "UPDATE ACCOUNT SET Membership = ? WHERE AccountID = ?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, membership);
			ps.setInt(2,AccountID_int);
			res = ps.executeUpdate();
			count++;
			ps.close();
		}
		if(!name.equals("No")){
			sql = "UPDATE ACCOUNT SET Name = ? WHERE AccountID = ?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, name);
			ps.setInt(2,AccountID_int);
			res += ps.executeUpdate();
			count++;
			ps.close();
		}
		if(!address.equals("No")){
			sql = "UPDATE ACCOUNT SET Address = ? WHERE AccountID = ?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, address);
			ps.setInt(2,AccountID_int);
			res += ps.executeUpdate();
			count++;
			ps.close();
		}
		if(!sex.equals("No")){
			sql = "UPDATE ACCOUNT SET Sex = ? WHERE AccountID = ?";
			PreparedStatement ps = conn.prepareStatement(sql);
			if(sex.equals("Male"))
				ps.setString(1, "M");
			else 
				ps.setString(1, "F");
			ps.setInt(2,AccountID_int);
			res += ps.executeUpdate();
			count++;
			ps.close();
		}
		if(!birthdate.equals("No")){
			sql = "UPDATE ACCOUNT SET Birthdate = ? WHERE AccountID = ?";
			PreparedStatement ps = conn.prepareStatement(sql);
			Date date = Date.valueOf(birthdate);
			ps.setDate(1, date);
			ps.setInt(2,AccountID_int);
			res += ps.executeUpdate();
			count++;
			ps.close();
		}
		if(!job.equals("No")){
			sql = "UPDATE ACCOUNT SET Job = ? WHERE AccountID = ?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, job);
			ps.setInt(2,AccountID_int);
			res += ps.executeUpdate();
			count++;
			ps.close();
		}
		if(!phone.equals("No")){
			sql = "UPDATE ACCOUNT SET Phone = ? WHERE AccountID = ?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, phone);
			ps.setInt(2,AccountID_int);
			res += ps.executeUpdate();
			count++;
			ps.close();
		}
		if(count == res){
			out.println("정보 변경에 성공하였습니다.");
		}
		else
			out.println("정보 변경에 실패하였습니다.");
		stmt.close();
	} catch (SQLException ex) {
		System.err.println("sql error = " + ex.getMessage());
		System.exit(1);
	}
%>