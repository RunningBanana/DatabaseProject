<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page language="java"
	import="java.text.*, java.sql.*, java.util.*, java.util.Date"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>평가 메뉴</title>
<style>
		.subm{  /* 버튼 스타일 */
			display:block;  /* 블록 레벨 요소 */
			background-color:#fff;  /* 배경색 */
			border:1px solid #dedede;  /* 테두리 */
			cursor:pointer;  /* 마우스 포인터 */
			padding:5px 10px 6px 7px;	/* 패딩 */
		}
		.subm:hover{  /* 버튼 위로 마우스 포인터 올렸을 때 스타일 */
			background-color:#AAAAAA;  /* 배경색 */
			border:1px solid #000000;  /* 테두리 */
			color:#000000; /* 글자색 */
		}
		.t1{
			width: 940px;
			padding: 5px 0px 5px 0px
		}
</style>
</head>
<body>
	<h1>Welcome to KnuMovie Rating Page</h1>
	<table class="t1">
			<tr height="2" bgcolor="#FFC8C3">
				<td colspan="2"></td>
			</tr>
			<tr>
				<th>자신의 평가내역 확인: </th>
				<td><input type="button" class="subm" value="평가내역 확인" onclick="location.href='confirm_rating.jsp'"></td>
			</tr>
			<tr>
				<th>모든 평가내역 확인(관리자 전용): </th>
				<td><form action='admin_ratingview.jsp' method="POST" onSubmit="return check(this)"><input type="submit" class="subm" value="모든 평가내역"></form></td>
			</tr>
			<tr height="2" bgcolor="#FFC8C3">
				<td colspan="2"></td>
			</tr>
			<tr>
				<td colspan="2" align="center">
				<input type="button" value="이전으로" onclick="location.href='mainMenu.jsp'">
				</td>
			</tr>
		</table>
		<%
		Connection conn = null;
		String url = "jdbc:postgresql://localhost/university";
		String user = "university";
		String password = "comp322";
		ResultSet rs = null;
		Statement stmt = null;
		PreparedStatement ps = null;
		String sql = "";
		int isAdmin = 0;
		int AccountID = Integer.parseInt((String)session.getAttribute("AccountID"));
		
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
		}
		
		try {
			stmt = conn.createStatement();
			sql = "SELECT * FROM ACCOUNT WHERE AccountID = ? AND Membership = 'Admin'";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, AccountID);
			rs = ps.executeQuery();
			if (rs.next())
				isAdmin = 1;
			else 
				isAdmin = 0;
			ps.close();
			stmt.close();
			conn.close();
		} catch (SQLException ex) {
			System.err.println("sql error = " + ex.getMessage());
		}
		%>
		<script type="text/javascript">
		function check(Join){
			var rating_num = <%=isAdmin%>;
			if(rating_num == 0){
				alert("관리자가 아닐 시 열람할 수 없습니다..");
				return false;
			}
		}
	</script>
</body>
</html>