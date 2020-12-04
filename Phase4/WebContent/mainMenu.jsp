<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page language="java" import="java.text.*, java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
<h1>Welcome to KnuMovie Main Menu Page</h1>
<%
	String ID = (String)session.getAttribute("ID");
	out.println("<h3>"+ ID +" 회원님 반갑습니다." +"</h3>");
%>
	<table class="t1">
			<tr height="2" bgcolor="#FFC8C3">
				<td colspan="2"></td>
			</tr>
			<tr>
				<th>회원관련 기능: </th>
				<td><input type="button" class="subm" value="회원관련 기능" onclick="location.href='customer.html'"></td>
			</tr>
			<tr>
				<th>영상물관련 기능: </th>
				<td><input type="button" class="subm" value="영상물관련 기능" onclick="location.href='movie.html'"></td>
			</tr>
			<tr>
				<th>평가관련 기능: </th>
				<td><input type="button" class="subm" value="평가관련 기능" onclick="location.href='rating.jsp'"></td>
			</tr>
			<tr>
				<th>관리자 기능: </th>
				<td><form action='administrator.html' method="POST" onSubmit="return check(this)"><input type="submit" class="subm" value="관리자기능"></form></td>
			</tr>
			<tr>
			<%
				if((int)session.getAttribute("isNewUser") == 1){
					out.println("<th>영화추천 기능: </th>");
					out.println("<td><input type=\"button\" class=\"subm\" value=\"영화추천 기능\" onclick=\"location.href=\'recommend.jsp\'\"></td>");
				}
			%>
			</tr>
			<tr height="2" bgcolor="#FFC8C3">
				<td colspan="2"></td>
			</tr>
			<tr>
				<td colspan="2" align="center">
				<input type="button" value="로그아웃" onclick="location.href='Introduction.jsp'">
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