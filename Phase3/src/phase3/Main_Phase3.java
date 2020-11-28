package phase3;

import java.sql.*;
import java.util.Scanner;

public class Main_Phase3 {
	public static void main(String[] args) {
		Connection conn = null;
		int rs;
		String ID;
		Scanner sc = new Scanner(System.in);
		int accountID;

		String url = "jdbc:postgresql://localhost/university";
		String user = "university";
		String password = "comp322";

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

		initMenu(conn);

	}

	//처음 실행하였을 때의 메뉴
	public static void initMenu(Connection conn) {
		Scanner sc = new Scanner(System.in);
		String ID = "";
		int accountID;
		while (true) {
			System.out.println("--------------------원하는 기능의 번호를 입력하십시오.--------------------");
			System.out.println("     1. 회원가입                2. 로그인                    3. 종료");
			System.out.println("----------------------------------------------------------------");
			char ch = sc.next().charAt(0);
			if (ch == '1') {
				Function.register(conn);
			} else if (ch == '2') {
				System.out.println("----------------------------------------------------------------");
				System.out.println("                         ID를 입력해주세요.");
				System.out.println("----------------------------------------------------------------");
				ID = sc.next();
				System.out.println("----------------------------------------------------------------");
				System.out.println("                       비밀번호를 입력해주세요.");
				System.out.println("----------------------------------------------------------------");
				String Password = sc.next();
				accountID = Function.login(conn, ID, Password);
				if (accountID != -1)
					userMenu(conn, accountID);
				else
					ID = "";
			} else if (ch == '3') {
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				System.exit(0);
			} else {
				invalidInput();
			}
		}
	}

	//부적절한 입력을 받았을 때
	public static void invalidInput() {
		System.out.println("부적절한 입력입니다.");
		System.out.println("다시 입력해주십시오.");
	}

	//로그인하였을 때의 메뉴
	public static void userMenu(Connection conn, int accountID) {
		Scanner sc = new Scanner(System.in);
		while (true) {
			System.out.println("--------------------원하는 기능의 번호를 입력하십시오.--------------------");
			System.out.println("  1. 회원 관련 기능                                     2. 영상물 관련 기능");
			System.out.println("  3. 평가 관련 기능                                     4. 관리자 기능");
			System.out.println("  5. 로그아웃");
			System.out.println("----------------------------------------------------------------");
			char ch = sc.next().charAt(0);
			if (ch == '1') {
				memberMenu(conn, accountID);
			} else if (ch == '2') {
				movieMenu(conn, accountID);
			} else if (ch == '3') {
				rateMenu(conn, accountID);
			} else if (ch == '4') {
				if(Function.authorityCheck(conn, accountID))
					adminMenu(conn,accountID);
			}

			else if (ch == '5')
				break;
			else {
				invalidInput();
			}
		}
	}

	//1. 회원 관련 기능
	public static void memberMenu(Connection conn, int accountID) {
		Scanner sc = new Scanner(System.in);
		while (true) {
			System.out.println("--------------------원하는 기능의 번호를 입력하십시오.--------------------");
			System.out.println("   1. 비밀번호 수정    2. 회원 정보 수정    3. 회원 탈퇴     4. 이전으로");
			System.out.println("----------------------------------------------------------------");
			char ch = sc.next().charAt(0);
			if (ch == '1')
				Function.modifyPassword(conn, accountID);
			else if (ch == '2')
				Function.modifyInfo(conn, accountID);
			else if (ch == '3') {
				if(Function.withdrawal(conn, accountID))
					initMenu(conn);
			} else if (ch == '4') {
				break;
			} else {
				invalidInput();
			}
		}
	}

	
	//2. 영상물 관련 기능
	public static void movieMenu(Connection conn, int accountID) {
		Scanner sc = new Scanner(System.in);
		while (true) {
			System.out.println("--------------------원하는 기능의 번호를 입력하십시오.--------------------");
			System.out.println("  1. 전체 영상물 보기                                2. 제목으로 영상물 검색");
			System.out.println("  3. 조건으로 영상물 검색                                  4. 이전으로");
			System.out.println("----------------------------------------------------------------");
			char ch = sc.next().charAt(0);
			if (ch == '1') {
				Function.See_all_movie(conn, accountID);
			} else if (ch == '2') {
				Function.search_movie_by_title(conn, accountID);
			} else if (ch == '3') {
				Function.search_by_condition(conn, accountID);
			} else if (ch == '4')
				break;
			else {
				invalidInput();
			}
		}
	}

	//3. 평가 관련 기능
	public static void rateMenu(Connection conn, int accountID) {
		Scanner sc = new Scanner(System.in);
		while (true) {
			System.out.println("--------------------원하는 기능의 번호를 입력하십시오.--------------------");
			System.out.println("  1. 자신의 평가 내역 확인                 2. 모든 평가 내역 확인(관리자 전용)");
			System.out.println("  3. 이전으로");
			System.out.println("----------------------------------------------------------------");
			char ch = sc.next().charAt(0);
			if (ch == '1') {
				Function.See_my_rate(conn, accountID);
			} else if (ch == '2') {
				if (Function.authorityCheck(conn, accountID))
					Function.See_all_rate(conn, accountID);
			} else if (ch == '3')
				break;
			else {
				invalidInput();
			}
		}
	}
	
	//4. 관리자 기능
	public static void adminMenu(Connection conn, int accountID) {
		Scanner sc = new Scanner(System.in);
		while (true) {
			System.out.println("--------------------원하는 기능의 번호를 입력하십시오.--------------------");
			System.out.println("  1. 영상물 등록                                    2. 영상물 정보 수정");
			System.out.println("  3. 이전으로");
			System.out.println("----------------------------------------------------------------");
			char ch = sc.next().charAt(0);
			if (ch == '1') {
				Function.register_movie(conn);
			} else if (ch == '2') {
				Function.update_movie(conn);
			} else if (ch == '3')
				break;
			else {
				invalidInput();
			}
		}
	}

}
