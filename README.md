# DatabaseProject

Team15-README.txt

VM VirtualBox를 통해 생성한 가상머신으로
Linux 환경에서 PostgreSQL으로 구현하였습니다.

VM VIrtualBox 버전 : 6.1.14 r140239 (Qt5.6.2)
리눅스 버전 : Ubuntu 18.04.5 LTS
PostgreSQL 버전 : PostgreSQL 10.15 (Ubuntu 10.15-0ubuntu0.18.04.1) on x86_64-pc-linux-gnu
자바 버전 : openjdk version "1.8.0_275"
PostgreSQL JDBC Driver 버전 : 42.2.18
Eclipse IDE 2020-09 for Enterprise Java Developers 버전 : 4.17.0.v20200902-1800
Tomcat 버전 : 8.5.39

Phase2에서 만들었던 테이블에 대한 수정이 있었습니다.
수정된 내용은 다음과 같습니다.

--------------------------------------------------------------------------------------------------------------------
1. 신규회원을 구분하기 위한 가입일자 추가
---------------------------------------------------------------------------------------------------------------------

수정된 sql 파일과 tsv 파일은 sql,tsv 폴더에 있습니다.

sql파일을 실행하실 땐 접근할 계정과 데이터베이스의 이름, sql파일의 경로를 잘 확인해주셔야 합니다.
psql -h localhost -U <계정 이름> -d <데이터베이스 이름> -a -f <'sql파일 경로'>
ex) psql -h localhost -U university -d university -a -f '/home/myung4386/Data/Team15-Phase2-1.sql';

압축파일 내의 .tsv파일은 DB를 구성할 데이터들이 들어있는 파일입니다.

Team15-Phase2-2.sql에서는 .tsv파일 내에 있는 정보를 COPY하여 데이터베이스에 저장하기 때문에
저장하신 tsv파일의 경로를 sql파일 내에서 직접 수정해주셔야 합니다.
ex) \COPY ACT(ActID, MovieID, ActorID) from '/home/myung4386/Data/act.tsv'; 에서 '/home../act.tsv'부분


Phase4는 VM VirtualBox를 통해 생성한 가상머신으로
Linux 환경에서 Eclipse를 활용하여 구현하였습니다.

Phase4 프로젝트를 톰캣 서버에 추가한 후 Run On Server로 실행하면
초기화면이 나타나게 됩니다.

초기화면에서는 회원가입과 로그인을 할 수 있습니다. 

1. 회원 가입
아이디와 비밀번호, 이름과 생년월일을 입력하여 회원 가입을 할 수 있습니다.
ID 중복체크를 하여야만 회원가입을 할 수 있고, ID가 중복된다면 회원가입을 할 수 없습니다.
관리자 계정은 회원 가입 메뉴에서 만들 수 없고, 직접 DB를 조작하여야만 만들 수 있습니다.

2. 로그인
아이디와 비밀번호를 입력받아 로그인합니다.
아이디, 비밀번호가 존재하지 않거나 다르다면 로그인 할 수 없습니다.
로그인에 성공한다면 메인메뉴로 이동합니다.


메인메뉴에서는 1. 회원 관련 기능, 2. 영상물 관련 기능, 3. 평가 관련 기능, 4. 관리자 기능, 5. 영화 추천 기능 중에서 선택할 수 있습니다.



1. 회원 관련 기능
A. 비밀번호 수정, B. 회원정보 수정, C. 회원 탈퇴를 할 수 있습니다.

A. 비밀번호 수정
현재 비밀번호를 입력받아 비밀번호가 일치하는 지 확인하고,
비밀번호가 일치한다면 새로운 비밀번호를 입력받아 해당 비밀번호로 변경합니다.
비밀번호 확인 칸은 새로운 비밀번호와 일치하여야 합니다.
오타 등으로 의도치않은 비밀번호로 수정되는 것을 방지하기 위함입니다.
비밀번호가 일치하지 않는다면 비밀번호를 변경할 수 없습니다.

B. 회원정보 수정
Membership, Name, Address, Sex, BirthDate, Job, Phone을 수정할 수 있습니다.


C. 회원 탈퇴
회원 탈퇴를 진행합니다.
만약 관리자 계정으로 로그인하였고, 현재 관리자 계정이 해당 계정 하나 뿐이라면
회원 탈퇴를 진행할 수 없습니다.




2. 영상물 관련 기능
A. 전체 영상물 보기 B. 제목으로 영상물 검색 C.조건으로 영상물 검색 중에서

A. 전체 영상물 보기
회원은 로그인 이후 영상물 전체를 볼 수 있습니다. 
모든 영상물의 제목을 볼 수 있고 이후 영상물을 선택할 수 있습니다.

B. 제목으로 영상물 검색
회원은 로그인 이후 제목으로 등록된 영상물을 검색할 수 있습니다.
이후 특정 영상물을 번호로 선택할 수 있습니다.

C. 조건으로 영상물 검색
회원은 로그인 이후 특정 조건으로 영상물을 검색할 수 있습니다.
종류, 성인제한 여부, 최소 영상길이, 장르, 최소 평점, 버전을 포함한 총 6가지의 조건을
선택적으로 사용하여 영상물을 검색할 수 있습니다. 조건은 1~6가지 사용할 수 있습니다.
조건을 입력하고 나면 조건에 맞는 영상물 목록을 볼 수 있고,
특정 영상물을 번호로 선택할 수 있습니다.

A, B, C - 2. 검색한 영상물 목록에서 한 영상물 선택시
영상물에 대한 제목, 유형, 성인물 제한 여부, 상영 년도, 평균 평점, 재생시간, 장르를 포함한 자세한 정보를 볼 수 있습니다.
그 후, 이 영상물을 평가할 것인지 말 것인지 선택할 수 있습니다.

A, B, C - 3. 회원이 평가한 영상물은 이후 검색 대상에서 제외하게 됩니다.
선택한 영상물을 이후 평가할 수 있고 평가한 이후 B, C 기능에서 검색을 통한
영상물 목록에서는 영상물이 제외됩니다.

회원이 한번 평가한 영상물에 대해서는 재평가할 수 없습니다.






3. 평가 관련 기능
A. 자신의 평가 내역 확인, B. 모든 평가 내역 확인(관리자 전용) 중에서 선택할 수 있습니다.

A. 자신의 평가 내역 확인
자신이 평가한 영상물의 제목과 평점을 확인할 수 있습니다.

B. 모든 평가 내역 확인(관리자 전용)
관리자 계정만 사용할 수 있습니다.
영상물의 제목과 평가한 사람의 이름과 평점을 확인할 수 있습니다.






4. 관리자 기능 - 관리자 계정으로 접속하였을 때만 사용이 가능한 기능
A. 영상물 등록, B. 영상물 정보 수정, C. 이전으로 중에서 선택할 수 있습니다.

A. 영상물 등록
새로운 영상물을 등록할 수 있습니다.
관리자는 등록하려는 영상물의 제목, 종류, 성인제한 여부, 상영 년도, 영상 길이, 장르와 같은
영상물의 기본정보를 입력하여 등록할 수 있습니다.

B. 영상물 정보 수정
등록된 영상물의 정보를 수정할 수 있습니다.
영상물의 정보를 수정하기 전에 등록된 모든 영상물의 정보를 콘솔에 출력합니다.
그리고 이후 관리자가 수정하고 싶은 영상물을 선택하면
영상물의 제목, 유형, 성인물 제한여부, 상영년도, 재생시간, 장르를 포함한 자세한 정보를 출력합니다.
이후 총 6가지에 대한 정보중 몇개를 수정할 것인지 입력받고 1~6번에 해당하는 수정사항을 선택하여 수정할 수 있습니다.
모든 입력을 마치면 즉시 수정이 반영됩니다.


5. 영화 추천 기능
신규 가입자에게는 영화 추천 기능이 제공됩니다.
신규 가입자는 가입한 지 일주일이 되지 않은 유저로 정의합니다.
메인 메뉴는 동적으로 구성되어 신규 가입자가 아닌 유저에게는 영화 추천 기능이 보이지 않습니다.
영화 추천 기능은 각 장르별 평점이 가장 높은 영화를 7개씩 선정하여 화면에 상세정보를 출력합니다.
