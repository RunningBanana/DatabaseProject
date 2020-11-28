package phase3;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Scanner;
import java.sql.Date;

public class Function {
	//1.A 회원 가입
	public static void register(Connection conn) {
		Statement stmt = null;
		String sql = "";
		int res = 0;
		StringBuffer sb = new StringBuffer();
		Scanner sc1 = new Scanner(System.in);
		try {
			String ID = "";
			String Password = "";
			String Name = "";
			String BirthDate = "";
			stmt = conn.createStatement();
			System.out.println("----------------------------------------------------------------");
			System.out.println("                       ID를 입력해주세요.");
			System.out.println("----------------------------------------------------------------");
			ID = sc1.next();
			System.out.println("----------------------------------------------------------------");
			System.out.println("                      비밀번호를 입력해주세요.");
			System.out.println("----------------------------------------------------------------");
			Password = sc1.next();
			System.out.println("----------------------------------------------------------------");
			System.out.println("                       이름을 입력해주세요.");
			System.out.println("----------------------------------------------------------------");
			Name = sc1.next();
			System.out.println("----------------------------------------------------------------");
			System.out.println("          생일을 입력해주세요. (YYYY-MM-DD 형식으로 입력해주세요.)");
			System.out.println("----------------------------------------------------------------");
			BirthDate = sc1.next();
			sql = "INSERT INTO ACCOUNT(Id, Password, Name, BirthDate) VALUES(?, ?, ?, ?)";
			PreparedStatement ps = conn.prepareStatement(sql);

			Date date = Date.valueOf(BirthDate);
			ps.setString(1, ID);
			ps.setString(2, Password);
			ps.setString(3, Name);
			ps.setDate(4, date);
			res = ps.executeUpdate();
			System.out.println("회원가입이 완료되었습니다.");
			ps.close();
			stmt.close();
		} catch (SQLException ex) {
			System.err.println("sql error = " + ex.getMessage());
		}
	}

	//1.D 로그인
	public static int login(Connection conn, String ID, String Password) {
		Statement stmt = null;
		String sql = "";
		ResultSet rs = null;
		StringBuffer sb = new StringBuffer();
		Scanner sc1 = new Scanner(System.in);
		try {
			stmt = conn.createStatement();
			sql = "SELECT AccountID FROM ACCOUNT WHERE ID = ? AND PASSWORD = ?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, ID);
			ps.setString(2, Password);
			rs = ps.executeQuery();
			if (rs.next()) {
				clear();
				System.out.println("----------------------------------------------------------------");
				System.out.println("                          로그인하였습니다.");
				System.out.println("----------------------------------------------------------------");
				return rs.getInt(1);
			} else {
				clear();
				System.out.println("----------------------------------------------------------------");
				System.out.println("                   ID나 Password가 일치하지 않습니다.");
				System.out.println("----------------------------------------------------------------");
			}
			ps.close();
			stmt.close();
		} catch (SQLException ex) {
			System.err.println("sql error = " + ex.getMessage());
			System.exit(1);
		}
		return -1;
	}

	//1.C 비밀번호 수정
	public static void modifyPassword(Connection conn, int accountID) {
		Statement stmt = null;
		String sql = "";
		ResultSet rs = null;
		int res = 0;
		StringBuffer sb = new StringBuffer();
		Scanner sc1 = new Scanner(System.in);
		try {
			String Password = "";
			stmt = conn.createStatement();
			System.out.println("----------------------------------------------------------------");
			System.out.println("                      현재 비밀번호를 입력해주세요.");
			System.out.println("----------------------------------------------------------------");
			Password = sc1.next();
			sql = "SELECT * FROM ACCOUNT WHERE AccountID = ? AND PASSWORD = ?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, accountID);
			ps.setString(2, Password);
			rs = ps.executeQuery();
			if (rs.next()) {
				System.out.println("----------------------------------------------------------------");
				System.out.println("                      변경할 비밀번호를 입력해주세요.");
				System.out.println("----------------------------------------------------------------");
			} else {
				Function.clear();
				System.out.println("----------------------------------------------------------------");
				System.out.println("                        Password가 틀렸습니다.");
				System.out.println("----------------------------------------------------------------");
				return;
			}
			Password = sc1.next();
			sql = "UPDATE ACCOUNT SET PASSWORD = ? WHERE accountID = ?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, Password);
			ps.setInt(2, accountID);
			res = ps.executeUpdate();
			if (res == 1) {
				clear();
				System.out.println("----------------------------------------------------------------");
				System.out.println("                     비밀번호 변경에 성공하였습니다.");
				System.out.println("----------------------------------------------------------------");
			} else {
				clear();
				System.out.println("----------------------------------------------------------------");
				System.out.println("                     비밀번호 변경에 실패하셨습니다.");
				System.out.println("----------------------------------------------------------------");
			}
			ps.close();
			stmt.close();
		} catch (SQLException ex) {
			System.err.println("sql error = " + ex.getMessage());
		}
	}

	//1.B 회원 정보 수정
	public static void modifyInfo(Connection conn, int accountID) {
		Statement stmt = null;
		String sql = "";
		int res = 0;
		StringBuffer sb = new StringBuffer();
		Scanner sc1 = new Scanner(System.in);
		String Modify = "";
		String data = "";
		char ch;
		try {
			stmt = conn.createStatement();
			while (true) {
				System.out.println("-----------------수정을 원하는 정보의 번호를 입력하십시오.------------------");
				System.out.println("1. Membership               2. Name                3. Address");
				System.out.println("4. Sex          5. BirthDate          6.Job         7. Phone");
				System.out.println("----------------------------------------------------------------");
				ch = sc1.next().charAt(0);
				if (ch == '1') {
					sql = "UPDATE ACCOUNT SET Membership = ? WHERE AccountID = ?";
					break;
				} else if (ch == '2') {
					sql = "UPDATE ACCOUNT SET Name = ? WHERE AccountID = ?";
					break;
				} else if (ch == '3') {
					sql = "UPDATE ACCOUNT SET Address = ? WHERE AccountID = ?";
					break;
				} else if (ch == '4') {
					sql = "UPDATE ACCOUNT SET Sex = ? WHERE AccountID = ?";
					break;
				} else if (ch == '5') {
					sql = "UPDATE ACCOUNT SET BirthDate = ? WHERE ACcountID = ?";
					break;
				} else if (ch == '6') {
					sql = "UPDATE ACCOUNT SET Job = ? WHERE AccountID = ?";
					break;
				} else if (ch == '7') {
					sql = "UPDATE ACCOUNT SET Phone = ? WHERE AccountID = ?";
					break;
				} else {
					System.out.println("부적절한 입력입니다.");
					System.out.println("다시 입력해주십시오.");
				}
			}

			while (true) {
				if (ch == '1') {
					System.out.println("-------------------------번호를 입력하십시오.---------------------------");
					System.out.println("       1. Basic             2. Premium            3. Prime");
					System.out.println("----------------------------------------------------------------");
					char ch2 = sc1.next().charAt(0);
					if (ch2 == '1') {
						data = "Basic";
						break;
					} else if (ch2 == '2') {
						data = "Premium";
						break;
					} else if (ch2 == '3') {
						data = "Prime";
						break;
					} else {
						System.out.println("부적절한 입력입니다.");
						System.out.println("다시 입력해주십시오.");
					}
				} else if (ch == '4') {
					System.out.println("-------------------------번호를 입력하십시오.---------------------------");
					System.out.println("       1. Male                                2. Female");
					System.out.println("----------------------------------------------------------------");
					char ch2 = sc1.next().charAt(0);
					if (ch2 == '1') {
						data = "M";
						break;
					} else if (ch2 == '2') {
						data = "F";
						break;
					} else {
						System.out.println("부적절한 입력입니다.");
						System.out.println("다시 입력해주십시오.");
					}
				} else {
					System.out.println("----------------------------------------------------------------");
					System.out.println("                       정보를 입력해 주세요.");
					System.out.println("       (단, BirthDate는 YYYY-MM-DD 형식으로만 입력이 가능합니다.)");
					System.out.println("----------------------------------------------------------------");
					data = sc1.next();
					break;
				}
			}

			PreparedStatement ps = conn.prepareStatement(sql);

			ps.setString(1, Modify);
			Date date;
			if (ch == '5') {
				date = Date.valueOf(data);
				ps.setDate(1, date);
			} else {
				ps.setString(1, data);
			}
			ps.setInt(2, accountID);
			res = ps.executeUpdate();
			if (res == 1) {
				clear();
				System.out.println("----------------------------------------------------------------");
				System.out.println("                      정보 변경에 성공하였습니다.");
				System.out.println("----------------------------------------------------------------");
			} else {
				clear();
				System.out.println("----------------------------------------------------------------");
				System.out.println("                      정보 변경에 실패하셨습니다.");
				System.out.println("----------------------------------------------------------------");
			}
			ps.close();
			stmt.close();
		} catch (SQLException ex) {
			System.err.println("sql error = " + ex.getMessage());
		}
	}

	//1.E 회원 탈퇴
	public static boolean withdrawal(Connection conn, int accountID) {
		Statement stmt = null;
		String sql = "";
		int res = 0;
		StringBuffer sb = new StringBuffer();
		Scanner sc1 = new Scanner(System.in);
		ResultSet rs = null;
		boolean isAdmin = false;
		PreparedStatement ps = null;
		try {
			stmt = conn.createStatement();
			sql = "SELECT * FROM ACCOUNT WHERE AccountID = ? AND Membership = 'Admin'";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, accountID);
			rs = ps.executeQuery();
			if (rs.next())
				isAdmin = true;
			if (isAdmin) {
				sql = "SELECT COUNT(*) FROM ACCOUNT WHERE Membership = 'Admin'";
				rs = stmt.executeQuery(sql);
				if (rs.next() && (rs.getInt(1) <= 1)) { //1.F 관리자 계정은 최소 1개 이상 필수
					clear();
					System.out.println("----------------------------------------------------------------");
					System.out.println("                관리자 계정은 최소 1개 이상 존재하여야 합니다.");
					System.out.println("----------------------------------------------------------------");
					return false;
				}
			}
			sql = "DELETE FROM ACCOUNT WHERE AccountID = ?";
			ps = conn.prepareStatement(sql);

			ps.setInt(1, accountID);
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
				clear();
				System.out.println("----------------------------------------------------------------");
				System.out.println("                     회원탈퇴가 완료되었습니다.");
				System.out.println("----------------------------------------------------------------");
				ps.close();
				stmt.close();
				return true;
			} else {
				clear();
				System.out.println("----------------------------------------------------------------");
				System.out.println("                     회원탈퇴에 실패하셨습니다.");
				System.out.println("----------------------------------------------------------------");
				ps.close();
				stmt.close();
				return false;
			}
		} catch (SQLException ex) {
			System.err.println("sql error = " + ex.getMessage());
		}
		return false;
	}

	// 2.A 로그인 이후 영상물 전체를 볼 수 있다.
	public static void See_all_movie(Connection conn, int ID) {
		ResultSet rs = null;
		Statement stmt = null;
		Scanner sc1 = new Scanner(System.in);
		String sql = "SELECT MovieID, TiTle FROM MOVIE ORDER BY MovieID ASC";
		int res = 0;
		int count = 0;
		int[] Movie = new int[500];

		try {
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			System.out.println("-------------------------영상물 목록--------------------------");
			while (rs.next()) {
				int MovieID = rs.getInt(1);
				String Title = rs.getString(2);
				Movie[++count] = MovieID;
				System.out.println("[" + count + "]" + "영상 제목: " + Title);
			}
			stmt.close();
		} catch (SQLException ex) {
			System.err.println("sql error = " + ex.getMessage());
			System.exit(1);
		}
		System.out.println("----------------------------------------------------------------");
		System.out.println("영상물을 선택하시겠습니까?: [Y/N] ");
		String choice;
		while (true) {
			choice = sc1.next();
			if (!(choice.equals("y") || choice.equals("Y") || choice.equals("n") || choice.equals("N")))
				System.out.println("다시 입력해주세요.");
			else
				break;
		}
		int num;
		if (choice.equals("Y") || choice.equals("y")) {
			System.out.println("----------------------------------------------------------------");
			System.out.println("어느 영상물을 선택하시겠습니까?(숫자입력): ");
			num = sc1.nextInt();
			choice_movie(conn, ID, Movie[num]);
		}
	}

	// 2.B 제목으로 등록된 영상물을 검색하는 것이 가능하다. 2.E 자신이 평가한 영상물 제외
	public static void search_movie_by_title(Connection conn, int ID) {
		ResultSet rs = null;
		Statement stmt = null;
		int[] Movie = new int[500];
		Scanner sc1 = new Scanner(System.in);
		System.out.println("----------------------------------------------------------------");
		System.out.println("검색하고자 하는 영상제목을 입력해주세요.");
		System.out.println("----------------------------------------------------------------");
		String search_title = sc1.nextLine();
		String sql = "SELECT M.MovieID, M.Title FROM MOVIE M WHERE M.Title='" + search_title + "' "
				+ "AND M.MovieID Not in (SELECT R.MovieID FROM RATING R WHERE R.AccountID = " + ID + ")";
		int res = 0;
		int count = 0;

		try {
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			System.out.println("-------------------------영상물 목록--------------------------");
			while (rs.next()) {
				int MovieID = rs.getInt(1);
				String Title = rs.getString(2);
				Movie[++count] = MovieID;
				System.out.println("[" + count + "]" + "영상 제목: " + Title);
			}
			stmt.close();
		} catch (SQLException ex) {
			System.err.println("sql error = " + ex.getMessage());
			System.exit(1);
		}
		System.out.println("----------------------------------------------------------------");
		System.out.println("영상물을 선택하시겠습니까?: [Y/N] ");
		String choice;
		int num;
		while (true) {
			choice = sc1.next();
			if (!(choice.equals("y") || choice.equals("Y") || choice.equals("n") || choice.equals("N")))
				System.out.println("다시 입력해주세요.");
			else
				break;
		}
		if (choice.equals("Y") || choice.equals("y")) {
			System.out.println("----------------------------------------------------------------");
			System.out.println("어느 영상물을 선택하시겠습니까? 해당하는 영상물의 번호를 입력해주세요.");
			num = sc1.nextInt();
			choice_movie(conn, ID, Movie[num]);
		}
	}

	// 2.C 로그인 이후 특정 조건으로 영상물을 검색할 수 있다. 2.E 자신이 평가한 영상물 제외
	public static void search_by_condition(Connection conn, int ID) {
		ResultSet rs = null;
		Statement stmt = null;
		int[] Movie = new int[500];
		Scanner sc1 = new Scanner(System.in);
		int[] condition = new int[7]; // index 1~6사용, 0미사용
		String[] detail_condition = new String[7]; // index 1~6사용, 0미사용
		System.out.println("------------------------검색 조건 목록----------------------------");
		System.out.println("1. 종류(Movie, KnuMovieDB Original, TV series)");
		System.out.println("2. 성인제한 여부[Y/N]");
		System.out.println("3. 최소 영상 길이");
		System.out.println("4. 장르(Action, Comedy, Romance, SF, Horror)");
		System.out.println("5. 최소 평점");
		System.out.println("6. 버전(GB, US, KR)");
		System.out.println("----------------------------숫자 입력--------------------------");
		System.out.println("몇가지 조건을 사용하시겠습니까?(숫자)  ");
		int condition_num;
		while (true) {
			condition_num = sc1.nextInt();
			if (!(condition_num >= 1 && condition_num <= 6))
				System.out.println("다시 입력해주세요.");
			else
				break;
		}
		int idx = 1;
		int count = 0;
		int temp;
		for (int i = 0; i < condition_num; i++) {
			System.out.println("----------------------------------------------------------------");
			System.out.printf("              사용할 %d번째 조건을 입력해주세요(숫자) \n", i + 1);
			System.out.println("----------------------------------------------------------------");
			while (true) {
				temp = sc1.nextInt();
				if (!(temp >= 1 && temp <= 6))
					System.out.println("다시 입력해주세요.");
				else
					break;
			}
			condition[idx++] = temp;
		}
		String sql = "";
		if (condition_num > 0)
			sql = "SELECT MovieID, Title FROM MOVIE WHERE ";
		else
			sql = "SELECT MovieId, Title FROM MOVIE WHERE MovieID Not in (SELECT R.MovieID FROM RATING R WHERE R.AccountID = "
					+ ID + ")";

		for (int i = 1; i < idx; i++) {
			int temp2;
			if (i != 1)
				sql += " AND ";
			if (condition[i] == 1) {
				System.out.println("--------------------------번호를 입력해주세요.--------------------------");
				System.out.println("         1. Movie, 2. KnuMovieDB Original, 3. TV series ");
				while (true) {
					temp2 = sc1.nextInt();
					if (!(temp2 >= 1 && temp2 <= 3))
						System.out.println("다시 입력해주세요.");
					else
						break;
				}
				if (temp2 == 1)
					detail_condition[i] = "Movie";
				else if (temp2 == 2)
					detail_condition[i] = "KnuMovieDB Original";
				else if (temp2 == 3)
					detail_condition[i] = "TV series";
				sql += ("Type ='" + detail_condition[i] + "' ");
			} else if (condition[i] == 2) {
				System.out.println("---------------------------문자를 입력해주세요.---------------------------");
				System.out.println("                        성인제한 여부[Y/N] ");
				while (true) {
					detail_condition[i] = sc1.next();
					if (!(detail_condition[i].equals("y") || detail_condition[i].equals("Y")
							|| detail_condition[i].equals("n") || detail_condition[i].equals("N")))
						System.out.println("다시 입력해주세요.");
					else
						break;
				}
				if (detail_condition[i].equals("Y") || detail_condition[i].equals("y"))
					detail_condition[i] = "t";
				else
					detail_condition[i] = "f";
				sql += ("IsAdult= '" + detail_condition[i] + "' ");
			} else if (condition[i] == 3) {
				System.out.println("--------------------------숫자를 입력해주세요.--------------------------");
				System.out.println("                          최소 영상 길이(분) ");
				while (true) {
					detail_condition[i] = sc1.next();
					if (Integer.parseInt(detail_condition[i]) <= 0)
						System.out.println("다시 입력해주세요.");
					else
						break;
				}
				sql += ("runTimes >=" + detail_condition[i] + " ");
				System.out.println("----------------------------------------------------------------");
			} else if (condition[i] == 4) {
				System.out.println("--------------------------번호를 입력해주세요.--------------------------");
				System.out.println("         1. Action, 2. Comedy, 3. Romance, 4. SF, 5. Horror ");
				while (true) {
					temp2 = sc1.nextInt();
					if (!(temp2 >= 1 && temp2 <= 5))
						System.out.println("다시 입력해주세요.");
					else
						break;
				}
				if (temp2 == 1)
					detail_condition[i] = "Action";
				else if (temp2 == 2)
					detail_condition[i] = "Comedy";
				else if (temp2 == 3)
					detail_condition[i] = "Romance";
				else if (temp2 == 4)
					detail_condition[i] = "SF";
				else if (temp2 == 5)
					detail_condition[i] = "Horror";
				sql += ("MovieID in(SELECT B.MovieID FROM BELONG B, GENRE G WHERE B.GenreID = G.GenreID AND G.Genre ='"
						+ detail_condition[i] + "') ");
				System.out.println("----------------------------------------------------------------");
			} else if (condition[i] == 5) {
				System.out.println("--------------------------숫자를 입력해주세요.--------------------------");
				System.out.println("                          최소 평점(0 ~ 10) ");
				while (true) {
					detail_condition[i] = sc1.next();
					if (Double.parseDouble(detail_condition[i]) < 0 || Double.parseDouble(detail_condition[i]) > 10)
						System.out.println("다시 입력해주세요.");
					else
						break;
				}
				sql += ("AverageScore >=" + detail_condition[i] + " ");
				System.out.println("----------------------------------------------------------------");
			} else if (condition[i] == 6) {
				System.out.println("--------------------------번호를 입력해주세요.--------------------------");
				System.out.println("                       1. GB, 2. US, 3. KR");
				while (true) {
					temp2 = sc1.nextInt();
					if (!(temp2 >= 1 && temp2 <= 3))
						System.out.println("다시 입력해주세요.");
					else
						break;
				}
				if (temp2 == 1)
					detail_condition[i] = "GB";
				else if (temp2 == 2)
					detail_condition[i] = "US";
				else if (temp2 == 3)
					detail_condition[i] = "KR";
				sql += ("MovieID in (SELECT MovieID FROM VERSION WHERE Region='" + detail_condition[i] + "') ");
				System.out.println("----------------------------------------------------------------");
			}
		}
		if (condition_num > 0)
			sql += ("AND MovieID Not in (SELECT R.MovieID FROM RATING R WHERE R.AccountID = " + ID + ")");

		try {
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			System.out.println("-------------------------영상물 목록--------------------------");
			while (rs.next()) {
				int MovieID = rs.getInt(1);
				String Title = rs.getString(2);
				Movie[++count] = MovieID;
				System.out.println("[" + count + "]" + "영상 제목: " + Title);
				stmt.close();
			}
		} catch (SQLException ex) {
			System.err.println("sql error = " + ex.getMessage());
			System.exit(1);
		}
		System.out.println("----------------------------------------------------------------");
		System.out.println("영상물을 선택하시겠습니까?: [Y/N] ");
		String choice;
		while (true) {
			choice = sc1.next();
			if (!(choice.equals("y") || choice.equals("Y") || choice.equals("n") || choice.equals("N")))
				System.out.println("다시 입력해주세요.");
			else
				break;
		}
		int num;
		if (choice.equals("Y") || choice.equals("y")) {
			System.out.println("----------------------------------------------------------------");
			System.out.println("어느 영상물을 선택하시겠습니까? 해당하는 영상물의 번호를 입력해주세요.");
			num = sc1.nextInt();
			choice_movie(conn, ID, Movie[num]);
		}
	}

	// 2.D 검색한 영상물 목록에서 한 영상물을 선택하면 그 영상물의 정보를 확인, 영상물 평가가능 3.D 평균 평점을 확인할 수 있다.
	public static void choice_movie(Connection conn, int ID, int MovieID) {
		ResultSet rs = null;
		Statement stmt = null;
		Scanner sc1 = new Scanner(System.in);
		String sql = "SELECT M.Title, M.Type, M.IsAdult, M.StartDate, M.AverageScore, M.runTimes, G.Genre FROM MOVIE M, GENRE G, BELONG B WHERE M.MovieID ="
				+ MovieID + " AND M.MovieID = B.MovieID AND B.GenreID = G.GenreID";
		int res = 0;

		try {
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			System.out.println("-------------------------영상물 정보--------------------------");
			while (rs.next()) {
				String Title = rs.getString(1);
				String Type = rs.getString(2);
				boolean IsAdult = rs.getBoolean(3);
				Date StartDate = rs.getDate(4);
				Double AverageScore = rs.getDouble(5);
				int runTimes = rs.getInt(6);
				String Genre = rs.getString(7);

				System.out.println("제목: " + Title);
				System.out.println("유형: " + Type);
				System.out.println("성인물 제한여부(0 전체이용, 1 성인): " + IsAdult);
				System.out.println("상영년도: " + StartDate);
				System.out.println("평균 평점: " + AverageScore);
				System.out.println("재생 시간: " + runTimes);
				System.out.println("장르: " + Genre);
				System.out.println("----------------------------------------------------------------");
				System.out.println("영상물을 평가하시겠습니까?: [Y/N] ");
				String choice;
				while (true) {
					choice = sc1.next();
					if (!(choice.equals("y") || choice.equals("Y") || choice.equals("n") || choice.equals("N")))
						System.out.println("다시 입력해주세요.");
					else
						break;
				}
				if (choice.equals("Y") || choice.equals("y")) {
					rate_movie(conn, ID, MovieID);
				}
			}
			stmt.close();
		} catch (SQLException ex) {
			System.err.println("sql error = " + ex.getMessage());
			System.exit(1);
		}
	}

	// 2.D RATING에 AccountID와 MovieID를 인자로 받고 평점을 남기면 된다.
	public static void rate_movie(Connection conn, int ID, int MovieID) {
		Statement stmt = null;
		double score = 0.0;
		String sql = "";
		Scanner sc1 = new Scanner(System.in);
		System.out.println("----------------------------------------------------------------");
		System.out.println("               영상물에 대한 평점을 적어주세요. (0 ~ 10) :");
		while (true) {
			score = sc1.nextDouble();
			if (!(score >= 0.0 && score <= 10.0))
				System.out.println("다시 입력해주세요.");
			else
				break;
		}
		try {
			stmt = conn.createStatement();
			sql = "INSERT INTO RATING (MovieID, AccountID, Score) VALUES(" + MovieID + ", " + ID + ", " + score + ")";
			stmt.executeUpdate(sql);
			System.out.println("-----------------------------평가 완료--------------------------------");
			sql = "CREATE VIEW AvgScore AS " + "SELECT MovieID, Avg(Score) AS Avg " + "FROM RATING "
					+ "GROUP BY MovieID";
			stmt.executeUpdate(sql);
			sql = "UPDATE MOVIE " + "SET AverageScore = AvgScore.Avg " + "FROM AvgScore "
					+ "WHERE MOVIE.MovieID = AvgScore.MovieID";
			stmt.executeUpdate(sql);
			sql = "DROP VIEW AvgScore;";
			stmt.executeUpdate(sql);
			stmt.close();
		} catch (SQLException ex) {
			System.err.println("sql error = " + ex.getMessage());
			System.exit(1);
		}
	}

	//3.A 모든 평가 내역은 로그아웃, Application 종료 등을 한 뒤에도 유지된다.
	//3.B 회원은 자신의 평가 내역을 확인할 수 있다
	public static void See_my_rate(Connection conn, int ID) {
		Statement stmt = null;
		double score = 0.0;
		String sql = "";
		PreparedStatement ps = null;
		Scanner sc1 = new Scanner(System.in);
		ResultSet rs = null;
		try {
			stmt = conn.createStatement();
			sql = "SELECT M.Title, R.Score FROM Movie M, Rating R WHERE R.AccountID = ? AND R.MovieID = M.MovieID";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, ID);
			rs = ps.executeQuery();
			System.out.println("-----------------------------평가 목록--------------------------------");
			System.out.println("             Title            | Score");
			while (rs.next()) {
				System.out.printf("%30s| %4.2f\n", rs.getString(1), rs.getDouble(2));
			}
			stmt.close();
		} catch (SQLException ex) {
			System.err.println("sql error = " + ex.getMessage());
			System.exit(1);
		}
	}

	//3.C 관리자는 모든 평가 내역을 확인할 수 있다. 
	public static void See_all_rate(Connection conn, int ID) {
		Statement stmt = null;
		double score = 0.0;
		String sql = "";
		Scanner sc1 = new Scanner(System.in);
		ResultSet rs = null;
		try {
			stmt = conn.createStatement();
			sql = "SELECT M.Title, A.Name, R.Score FROM Movie M, Account A, Rating R WHERE R.AccountID = A.AccountID AND R.MovieID = M.MovieID";
			rs = stmt.executeQuery(sql);
			System.out.println("--------------------------------------평가 목록-----------------------------------------");
			System.out.println("                  Title                 |              Name             | Score");
			while (rs.next()) {
				System.out.printf("%40s| %30s| %4.2f\n", rs.getString(1), rs.getString(2), rs.getDouble(3));
			}
			System.out.println("-------------------------------------------------------------------------------");
			stmt.close();
		} catch (SQLException ex) {
			System.err.println("sql error = " + ex.getMessage());
			System.exit(1);
		}
	}

	//권한이 관리자인지 체크
	public static boolean authorityCheck(Connection conn, int accountID) {
		Statement stmt = null;
		double score = 0.0;
		String sql = "";
		Scanner sc1 = new Scanner(System.in);
		ResultSet rs = null;
		PreparedStatement ps = null;
		try {
			stmt = conn.createStatement();
			sql = "SELECT * FROM ACCOUNT WHERE AccountID = ? AND Membership = 'Admin'";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, accountID);
			rs = ps.executeQuery();
			if (rs.next()) {
				ps.close();
				stmt.close();
				return true;
			} else {
				System.out.println();
				System.out.println();
				System.out.println();
				System.out.println();
				System.out.println();
				System.out.println();
				System.out.println();
				System.out.println("-------------------------------------------------------------------------------");
				System.out.println("                        선택하신 기능은 관리자 전용 기능입니다.");
				System.out.println("-------------------------------------------------------------------------------");
				ps.close();
				stmt.close();
				return false;
			}
		} catch (SQLException ex) {
			System.err.println("sql error = " + ex.getMessage());
			System.exit(1);
		}

		return false;
	}

	// 4.A 관리자기능: 새로운 영상물을 등록할 수 있다.
	public static void register_movie(Connection conn) {
		ResultSet rs = null;
		Statement stmt = null;
		String sql = "";
		String Title = "", Type = "", IsAdult = "", StartDate = "", Genre = "";
		int runTimes = 0, temp = 0, MovieID = 0, GenreID = 0;
		Scanner sc1 = new Scanner(System.in);

		System.out.println("---------------------영상물 등록 서비스-----------------------");
		System.out.println("                 영상물에대한 정보를 입력해주세요");
		System.out.println("--------------------------제목을 입력해주세요.--------------------------");
		System.out.println("1. 영상물 제목 ");
		Title = sc1.nextLine();
		System.out.println("--------------------------번호를 입력해주세요.--------------------------");
		System.out.println("2. 종류(1. Movie, 2. KnuMovieDB Original, 3. TV series) ");
		temp = sc1.nextInt();
		if (temp == 1)
			Type = "Movie";
		else if (temp == 2)
			Type = "KnuMovieDB Original";
		else if (temp == 3)
			Type = "TV series";
		System.out.println("--------------------------문자를 입력해주세요.--------------------------");
		System.out.println("3. 성인제한 여부[Y/N] ");
		IsAdult = sc1.next();
		if (IsAdult.equals("Y") || IsAdult.equals("y"))
			IsAdult = "t";
		else
			IsAdult = "f";
		System.out.println("--------------------------날짜를 입력해주세요.--------------------------");
		System.out.println("4. 상영년도(YYYY-MM-DD 형식으로 입력) ");
		StartDate = sc1.next();
		System.out.println("--------------------------정수를 입력해주세요.--------------------------");
		System.out.println("5. 영상 길이(분) ");
		runTimes = sc1.nextInt();
		System.out.println("--------------------------번호를 입력해주세요.--------------------------");
		System.out.println("6. 장르(1. Action, 2. Comedy, 3. Romance, 4. SF, 5. Horror) ");
		temp = sc1.nextInt();
		if (temp == 1)
			Genre = "Action";
		else if (temp == 2)
			Genre = "Comedy";
		else if (temp == 3)
			Genre = "Romance";
		else if (temp == 4)
			Genre = "SF";
		else if (temp == 5)
			Genre = "Horror";

		try {
			stmt = conn.createStatement();
			sql = "INSERT INTO MOVIE (Title, Type, IsAdult, StartDate, runTimes) VALUES('" + Title + "', '" + Type
					+ "', '" + IsAdult + "', '" + StartDate + "', " + runTimes + ")";
			stmt.executeUpdate(sql);
			sql = "SELECT MovieID FROM MOVIE WHERE Title='" + Title + "' AND Type='" + Type + "' AND StartDate='"
					+ StartDate + "' AND runTimes=" + runTimes;
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				MovieID = rs.getInt(1);
			}
			sql = "SELECT GenreID FROM GENRE WHERE Genre='" + Genre + "'";
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				GenreID = rs.getInt(1);
			}
			sql = "INSERT INTO BELONG (MovieID, GenreID) VALUES(" + MovieID + ", " + GenreID + ")";
			stmt.executeUpdate(sql);
			System.out.println("영상물 등록이 완료 되었습니다.");
			stmt.close();
		} catch (SQLException ex) {
			System.err.println("sql error = " + ex.getMessage());
			System.exit(1);
		}
	}

	// 4.B 등록된 영상물을 보여주고 정보를 수정할 수 있다.
	public static void update_movie(Connection conn) {
		ResultSet rs = null;
		Statement stmt = null;
		Scanner sc1 = new Scanner(System.in);
		String sql = "";
		int[] Movie = new int[600]; // index 1부터 사용
		int[] change = new int[10];
		String[] change_s = new String[10];
		int count = 1, temp;
		System.out.println("---------------------영상물 수정 서비스-----------------------");

		try {
			stmt = conn.createStatement();
			sql = "SELECT M.MovieID, M.Title, M.Type, M.IsAdult, M.StartDate, M.runTimes, G.Genre FROM MOVIE M, GENRE G, BELONG B WHERE  M.MovieID = B.MovieID AND B.GenreID = G.GenreID";
			System.out.println("-------------------------영상물 정보--------------------------");
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				System.out.println("[" + count + "]번 영상물");
				Movie[count++] = rs.getInt(1);
				String Title = rs.getString(2);
				String Type = rs.getString(3);
				boolean IsAdult = rs.getBoolean(4);
				Date StartDate = rs.getDate(5);
				int runTimes = rs.getInt(6);
				String Genre = rs.getString(7);

				System.out.println("제목: " + Title);
				System.out.println("유형: " + Type);
				System.out.println("성인물 제한여부(0 전체이용, 1 성인): " + IsAdult);
				System.out.println("상영년도: " + StartDate);
				System.out.println("재생 시간: " + runTimes);
				System.out.println("장르: " + Genre);
				System.out.println("----------------------------------------------------------------");
			}
			System.out.println("몇번째 영상물을 수정하시겠습니까?(숫자입력): ");
			int num = sc1.nextInt();
			sql = "SELECT M.Title, M.Type, M.IsAdult, M.StartDate, M.runTimes, G.Genre FROM MOVIE M, GENRE G, BELONG B WHERE  M.MovieID = B.MovieID AND B.GenreID = G.GenreID AND M.MovieID ="
					+ Movie[num];
			System.out.println("-------------------------영상물 정보--------------------------");
			while (rs.next()) {
				System.out.println("[" + num + "]번 영상물");
				String Title = rs.getString(1);
				String Type = rs.getString(2);
				boolean IsAdult = rs.getBoolean(3);
				Date StartDate = rs.getDate(4);
				int runTimes = rs.getInt(5);
				String Genre = rs.getString(6);

				System.out.println("제목: " + Title);
				System.out.println("유형: " + Type);
				System.out.println("성인물 제한여부(0 전체이용, 1 성인): " + IsAdult);
				System.out.println("상영년도: " + StartDate);
				System.out.println("재생 시간: " + runTimes);
				System.out.println("장르: " + Genre);
				System.out.println("----------------------------------------------------------------");
			}
			System.out.println("몇개 내용을 수정하시겠습니까?");
			System.out.println("1.제목, 2.유형, 3.성인물 제한여부, 4.상영년도 5.재생시간 6.장르");
			int modify_num = sc1.nextInt();
			if (modify_num <= 0)
				System.out.println("1이상 입력해주세요.");
			int idx = 1;
			for (int i = 0; i < modify_num; i++) {
				System.out.println("----------------------------------------------------------------");
				System.out.printf("              사용할 %d번째 조건을 입력해주세요(숫자) \n", i + 1);
				System.out.println("----------------------------------------------------------------");
				change[idx++] = sc1.nextInt();
			}
			sql = "UPDATE MOVIE SET ";
			for (int i = 1; i < idx; i++) {
				if (change[i] == 1) {
					System.out.println("변경하고 싶은 제목이름으로 입력하세요: ");
					sc1.nextLine();
					change_s[i] = sc1.nextLine();
					sql += "Title = '" + change_s[i] + "' ";
				} else if (change[i] == 2) {
					System.out.println("변경하고 싶은 종류로 입력하세요(1. Movie, 2. KnuMovieDB Original, 3. TV series): ");
					temp = sc1.nextInt();
					if (temp == 1)
						change_s[i] = "Movie";
					else if (temp == 2)
						change_s[i] = "KnuMovieDB Original";
					else if (temp == 3)
						change_s[i] = "TV series";
					sql += "Type='" + change_s[i] + "' ";
				} else if (change[i] == 3) {
					System.out.println("변경하고 싶은 성인제한 여부[Y/N]): ");
					change_s[i] = sc1.next();
					if (change_s[i].equals("Y") || change_s[i].equals("y"))
						change_s[i] = "t";
					else
						change_s[i] = "f";
					sql += "IsAdult = '" + change_s[i] + "' ";
				} else if (change[i] == 4) {
					System.out.println("변경하고 싶은 상영년도를 입력(YYYY-MM-DD): ");
					change_s[i] = sc1.next();
					sql += "StartDate='" + change_s[i] + "' ";
				} else if (change[i] == 5) {
					System.out.println("변경하고 싶은 상영시간 숫자입력(분): ");
					change_s[i] = sc1.next();
					sql += "runTimes=" + change_s[i] + " ";
				} else if (change[i] == 6) {
					System.out.println("변경하고 싶은 장르입력(1. Action, 2. Comedy, 3. Romance, 4. SF, 5. Horror): ");
					temp = sc1.nextInt();
					if (temp == 1)
						change_s[i] = "Action";
					else if (temp == 2)
						change_s[i] = "Comedy";
					else if (temp == 3)
						change_s[i] = "Romance";
					else if (temp == 4)
						change_s[i] = "SF";
					else if (temp == 5)
						change_s[i] = "Horror";
					String temp_sql = "UPDATE BELONG  SET GenreID = (SELECT GenreID FROM GENRE WHERE Genre='"
							+ change_s[i] + "') WHERE MovieID=" + Movie[num];
					stmt.executeUpdate(temp_sql);
				}
				if (!(change[i] == 6 || (i + 1) == idx)) {
					sql += " , ";
				}
			}
			if (!(idx == 2 && change[1] == 6)) {
				sql += " WHERE MovieID =" + Movie[num];
				stmt.executeUpdate(sql);
			}

			System.out.println("영상물 정보 수정이 완료되었습니다.");
			stmt.close();
		} catch (SQLException ex) {
			System.err.println("sql error = " + ex.getMessage());
			System.exit(1);
		}
	}

	public static void clear() {
		System.out.println();
		System.out.println();
		System.out.println();
		System.out.println();
		System.out.println();
		System.out.println();
		System.out.println();
		System.out.println();
		System.out.println();
		System.out.println();
	}
}