# account_book_app
<img src="https://github.com/seongchangkim/account_book_app/assets/74657556/8a28f259-dcfb-41c3-ad5f-ebfefa54ce0c" width="250" height="500">

회원 기능(로그인, 로그아웃, 회원가입, 카카오 소셜로그인)이 있고 회원으로 로그인하여 가계부를 생성할 수 뿐만 아니라 가계부 목록을 조회할 수 있고 수정 및 삭제가능한 앱 애플리케이션입니다. 
<br/>

● Android : [app-release.apk.zip](https://github.com/seongchangkim/account_book_app/files/12365272/app-release.apk.zip)<br/>
● IOS : [Runner.zip](https://github.com/seongchangkim/account_book_app/files/12365274/Runner.zip)<br/>
● 제작기간 : 2023.5.11~2023.06.19(1달, 주말 제외)(1인 프로젝트)

### 개발 환경
#### 1). Skill Stack
> 1. Dart 2.18.6
> 2. Flutter 3.3.10

#### 2). IDE
> 1. Visual Studio Code

## 앱에서 적용했던 주요 기술
● Getx 상태관리 라이브러리를 활용하여 상태관리를 적용했습니다. <br/>
● 위젯 단위로 컴포넌트화 작업을 통해 쉽게 유지보수할 수 있도록 구현했습니다. <br/>
● 불필요한 위젯 생성 방지 및 불필요한 리렌더링 방지 등을 통해 Flutter 앱 최적화 작업했습니다.

## 주요 기능 및 페이지
### 1. 스플래시 화면
<img src="https://github.com/seongchangkim/account_book_app/assets/74657556/32f54b1c-086e-49a4-92c0-bd0d07eccdf1" width="250" height="500">
<br/>
스플래시 화면에서 이 앱 안에 사용자 정보를 들어있는 Android는 KeyStore를, IOS는 KeyChain를 통해 내부 저장소를 저장합니다. 그리고 그것을 통해 로그인을 유지하는 방식으로 했습니다. 그리고 회원 인증 API를 호출하여 사용자 정보를 통해 유효하고 존재하는지 검사하고 그 사용자 정보가 유효하고 존재하면 홈 화면으로 이동하고 그렇지 않으면 로그인 페이지로 이동 합니다.

### 2. 회원가입
<img src="https://github.com/seongchangkim/account_book_app/assets/74657556/77d77fe9-045e-4fec-9659-a4db1c68ba19" width="250" height="500">
<p align="center">회원가입 유효성 검사</p>

<img src="https://github.com/seongchangkim/account_book_app/assets/74657556/de7bded3-dbb4-4256-a7d8-74718a860785" width="250" height="500">
<p align="center">회원가입 성공</p>

<br/>
- 로그인 페이지에서 회원가입 부분을 누르면 회원가입 페이지가 뜨는데 회원정보를 입력하여 회원가입 버튼을 클릭하면 회원가입 API를 POST방식으로 호출하여 입력한 회원정보를 들고 request해서 서버에서 response값을 받아서 회원가입이 성공하면 해당 회원이 생성되면서 회원가입 완료 알림창이 뜨고 확인 버튼을 누르면 로그인 페이지로 이동합니다.(유효성 검사 기능도 있습니다.)


### 3. 로그인
<img src="https://github.com/seongchangkim/account_book_app/assets/74657556/2a866838-5a3e-47f9-a5a0-cb0fad64f666" width="250" height="500">
<p align="center">로그인 유효성 검사</p>

<img src="https://github.com/seongchangkim/account_book_app/assets/74657556/786afb6e-a825-4ec2-abf9-04e012760cdd" width="250" height="500">
<p align="center">이메일 또는 비밀번호 불일치 시 로그인</p>

<img src="https://github.com/seongchangkim/account_book_app/assets/74657556/63e397dc-7880-47e8-aff5-db148a1cb3f9" width="250" height="500">
<p align="center">로그인 성공</p>

<br/>
- 로그인 페이지에서 이메일과 비밀번호를 입력하여 로그인 API를 POST방식으로 호출하여 입력한 이메일과 비밀번호를 들고 request해서 작동한 다음에 DB에서 이메일으로 일치한 데이터를 조회하고 비밀번호를 암호화하여 DB에서 암호화된 비밀번호가 있는지 조회합니다. 만약 DB에서 이메일과 비밀번호가 둘 다 일치한 DB가 있으면 로그인 성공되어 홈 화면으로 이동합니다. 그렇지 않으면 비밀번호 또는 아이디 불일치한 알림창을 뜨도록 설정합니다.(유효성 검사 기능도 있습니다.)

### 4. 로그아웃
<img src="https://github.com/seongchangkim/account_book_app/assets/74657556/85b110b9-f441-4894-8fda-04d25ec911e0" width="250" height="500">

<br/>
- 더보기 페이지에 들어가서 로그아웃 부분에 클릭하면 로그아웃 API를 POST방식으로 호출하여 사용자 id를 들고 request한 다음에 해당 회원에 대한 내부 저장소에 있는 KeyStore 또는 KeyChain이 지워지고 DB안에 해당 회원 id를 찾아서 token를 null 값으로 수정한 뒤 마지막으로 user 저장소를 빈 객체로 초기화시키고 로그인 페이지로 이동합니다.

### 5. 카카오 소셜 로그인 
<img src="https://github.com/seongchangkim/account_book_app/assets/74657556/606e0f03-2981-47ae-a248-22a639e57f93" width="250" height="500">
<p align="center">카카오 연동 계정이 없을 때 카카오 로그인</p>

<img src="https://github.com/seongchangkim/account_book_app/assets/74657556/c957630d-c602-44e7-91a1-587ad6e236fc" width="250" height="500">
<p align="center">카카오 연동 계정이 있을 때 카카오 로그인</p>

- 로그인 페이지에서 카카오 로그인을 누르면 카카오 프로필 정보 가져오기 API를 호출하여 카카오 프로필 정보를 가져와서 서버에서 카카오 계정 존재 여부 확인 API를 호출하여 DB에서 해당 카카오 계정이 있는지 확인합니다. 해당 카카오 계정이 있으면 로그인되어서 홈 화면으로 이동하고 없으면 카카오 프로필 정보를 들고 회원가입 페이지로 이동합니다. 회원가입 페이지에서 회원 정보를 입력하여 회원가입 버튼을 클릭하면 입력한 회원정보를 들고 request해서 DB에 저장되고 서버에서 response값을 받아서 이전 페이지로 이동한 뒤 회원가입 성공하므로 해당 카카오계정을 로그인하여 홈화면으로 이동합니다.
  
### 6. 프로필 상세보기, 프로필 정보 수정 및 회원 탈퇴
<img src="https://github.com/seongchangkim/account_book_app/assets/74657556/4b50aef4-4a9d-47ce-876d-5e48bfaa0aaf" width="250" height="500">
<p align="center">프로필 상세보기</p>

<img src="https://github.com/seongchangkim/account_book_app/assets/74657556/e3320909-506e-4b9d-b7f4-b7009c260bab" width="250" height="500">
<p align="center">프로필 정보 수정</p>

<img src="https://github.com/seongchangkim/account_book_app/assets/74657556/68877bca-d73b-444f-8545-cbd33e972534" width="250" height="500">
<p align="center">회원 탈퇴</p>

<br/>
1). 프로필 상세보기 : 더보기 페이지에 들어가서 프로필 정보를 클릭하면 상태관리으로 저장된 사용자 정보를 들고 프로필 상세보기 페이지에 출력합니다. <br/>
2). 프로필 정보 수정 : 프로필 상세보기 페이지에서 수정하고자 프로필 이미지 경로, 이름 및 전화번호를 수정하여 프로필 수정 버튼을 클릭하면 프로필 수정 API를 호출하여 수정하고자 프로필 이미지 경로, 이름 및 전화번호를 들고 request한 뒤에 DB에서 해당 사용자를 조회해서 해당 사용자와 일치하는 데이터에 프로필 이미지 경로, 이름 및 전화번호를 수정하고 updatedAt 컬럼을 해당 API를 호출했던 시점으로 수정한 다음에 프로필 수정이 성공하면 프로필 수정 알림창이 뜨고 프로필 정보 수정 알림창에 확인 버튼을 누르면 그 알림창은 취소가 됩니다.(유효성 검사 기능도 있습니다.)<br/>
3). 회원 탈퇴 : 프로필 상세보기 페이지에서 회원 탈퇴를 누르면 회원 탈퇴 API를 호출하여 해당 사용자 id를 들고 request한 뒤에 DB에서 해당 사용자 id로 조회하여 해당 사용자와 일치하면 조회된 데이터는 삭제된 다음에 회원 탈퇴 처리가 성공하면 회원 탈퇴 알림창을 뜨고 회원 탈퇴 알림창에서 확인 버튼을 클릭하면 로그인 페이지로 이동됩니다.

### 7. 홈 화면(가계부 목록 조회)
<img src="https://github.com/seongchangkim/account_book_app/assets/74657556/e40530a9-031c-4b09-b56f-607a36f5a5a3" width="250" height="500">
<p align="center">기존에 생성했던 가계부 목록이 있을 때</p>

<img src="https://github.com/seongchangkim/account_book_app/assets/74657556/c6bf7dc3-a078-462a-b95d-d3dd13fe6b59" width="250" height="500">
<p align="center">기존에 생성했던 가계부 목록이 없을 때</p>

<img src="https://github.com/seongchangkim/account_book_app/assets/74657556/c4f3976c-edb9-4ae3-a663-5ba4ba276db2" width="250" height="500">
<p align="center">해당 날짜 클릭 시 해당 날짜에 대한 가계부 목록 가져오기</p>

<br/>
스플래시를 통해 홈 화면으로 이동하기 전에 가계부 목록 API를 호출하여 해당 회원 id과 오늘 날짜를 들고 request한 뒤에 DB에서 해당 회원 id과 오늘 날짜에 가계부 데이터들을 조회해서  앱 클라이언트에 response 값을 뿌려서 가계부 목록을 렌더링합니다. 그리고 appbar 부분에 날짜를 누르면 날짜를 선택할 수 있는데 해당 날짜에 대한 request해서 해당 날짜에 response 값을 받아서 가계부 목록을 리렌더링합니다.

### 8. 가계부 생성
<img src="https://github.com/seongchangkim/account_book_app/assets/74657556/a18da29d-5d9d-40f4-97b6-652fe4e067b4" width="250" height="500">
<br/>
- 홈 화면에서 + 버튼을 누르면 가계부 생성 페이지를 들어갈 수 있는데 날짜 부분을 클릭하면 입력하고자 날짜를 선택할 수 있고 분류를 클릭하면 입력하고자 분류 선택하는 창이 나오는데 입력하고자 분류를 선택할 수 있습니다. 이렇게 날짜, 분류, 금액 및 내용을 입력하고 생성 버튼을 클릭하여 입력한 값들을 들고 가계부 생성 API를 호출하여 DB에 가계부를 생성되고 가계부 생성이 성공하면 이전 페이지로 이동하면서 새로고침하여 리렌더링합니다.(유효성 검사 기능도 있습니다.)

### 9. 가계부 상세보기 및 삭제
<img src="https://github.com/seongchangkim/account_book_app/assets/74657556/d1502899-6d7d-4430-a47f-aea64c1d9e14" width="250" height="500">
<p align="center">가계부 상세보기</p>

<img src="https://github.com/seongchangkim/account_book_app/assets/74657556/50da10f6-18d8-45e6-9e64-58769984d9c4" width="250" height="500">
<p align="center">가계부 삭제</p>

1). 가계부 상세보기 : 홈 화면에서 해당 가계부를 클릭하면 해당 가계부 상세 페이지에 들어가게 전에 가계부 상세보기 API를 호출하여 해당 가계부의 id값을 들고 request해서 작동한 뒤 그리고 DB에 해당 가계부으로 조회하여 해당 가계부 정보를 조회하여 Response 값을 보내어 렌더링합니다.</br>
2). 가계부 삭제 : 가계부 상세페이지에 삭제 버튼을 클릭하면 가계부 삭제 API를 호출하여 해당 가계부의 id값을 들고 request해서 작동한 뒤 DB에 해당 가계부으로 조회하여 조회된 데이터를 삭제되어 해당 가계부 삭제가 성공하면 가계부 삭제 알림창이 뜹니다. 그리고 확인 버튼을 누르면 이전 페이지로 이동하면서 새로고침되어 리렌더링됩니다.

### 10. 가계부 수정
<img src="https://github.com/seongchangkim/account_book_app/assets/74657556/18a0a7e3-1c4d-4bf7-9e31-179b9a871aa8" width="250" height="500">

해당 가계부 상세페이지에서 수정하고자 날짜, 분류, 금액 및 내용을 수정하여 수정 버튼을 누르면 가계부 수정 API을 호출하여 수정하고자 가계부 값을 들고 request해서 작동한 뒤 DB에서 해당 가계부의 id으로 조회하여 조회된 가계부 데이터에 수정하고자 가계부으로 수정되고 updatedAt가 해당 API를 호출했던 시점으로 수정됨. 그리고 가계부 수정이 성공하면 가계부 수정 알림창을 띄우고 확인 버튼을 누르면 알림창이 없어집니다. 
