package phase3;

import java.sql.*;
import java.util.Scanner;

public class test {

	public static void main(String[] args) {
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
		
		try {
			String ID = "admin";
			stmt = conn.createStatement();
			String sql = "SELECT * FROM ACCOUNT WHERE id = ?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, ID);
			rs = ps.executeQuery();
			if(rs.next())
				System.out.println("no");
			else
				System.out.println("yes");
			ps.close();
			stmt.close();
		} catch (SQLException ex) {
			System.err.println("sql error = " + ex.getMessage());
			System.exit(1);
		}
	}

}
