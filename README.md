# account_book_app
<img src="https://github.com/seongchangkim/account_book_app/assets/74657556/8a28f259-dcfb-41c3-ad5f-ebfefa54ce0c" width="250" height="500">

회원 기능(로그인, 로그아웃, 회원가입, 카카오 소셜로그인)이 있고 회원으로 로그인하여 가계부를 생성할 수 뿐만 아니라 가계부 목록을 조회할 수 있고 수정 및 삭제가능한 앱 애플리케이션입니다. 
<br/>
● 제작기간 : 2023.5.11~2023.06.19(1달, 주말 제외)(1인 프로젝트)

### 개발 환경
#### 1). Skill Stack
> 1. Dart 2.18.6
> 2. Flutter 3.3.10

#### 2). IDE
> 1. Visual Studio Code

## 주요 기능 및 페이지
### 1. 스플래시 화면
<img src="https://github.com/seongchangkim/account_book_app/assets/74657556/32f54b1c-086e-49a4-92c0-bd0d07eccdf1" width="250" height="500">
<br/>
스플래시 화면에서 이 앱 안에 사용자 정보를 들어있는 Android는 KeyStore를, IOS는 KeyChain를 통해 내부 저장소를 저장합니다. 그리고 그것을 통해 로그인을 유지하는 방식으로 했습니다. 그리고 회원 인증 API를 호출하여 사용자 정보를 통해 유효하고 존재하는지 검사하고 그 사용자 정보가 유효하고 존재하면 홈 화면으로 이동하고 그렇지 않으면 로그인 페이지로 이동 합니다.

### 2. 회원가입
![user-register-vaildate-ezgif com-video-to-gif](https://github.com/seongchangkim/account_book_app/assets/74657556/77d77fe9-045e-4fec-9659-a4db1c68ba19)
<p align="center">회원가입 유효성 검사</p>

![user-register-ezgif com-video-to-gif](https://github.com/seongchangkim/account_book_app/assets/74657556/de7bded3-dbb4-4256-a7d8-74718a860785)
<p align="center">회원가입 성공</p>

<br/>
- 로그인 페이지에서 회원가입 부분을 누르면 회원가입 페이지가 뜨는데 회원정보를 입력하여 회원가입 버튼을 클릭하면 회원가입 API를 POST방식으로 호출하여 입력한 회원정보를 들고 request해서 서버에서 response값을 받아서 회원가입이 성공하면 해당 회원이 생성되면서 회원가입 완료 알림창이 뜨고 확인 버튼을 누르면 로그인 페이지로 이동합니다.(유효성 검사 기능도 있습니다.)


### 3. 로그인
https://user-images.githubusercontent.com/74657556/220310852-30a94987-7a47-4959-92e8-e32eb8633679.mp4

<br/>
- 로그인 페이지에서 이메일과 비밀번호를 입력하여 로그인 API를 POST방식으로 호출하여 입력한 이메일과 비밀번호를 들고 request해서 작동함. 그 다음에 DB에서 이메일으로 일치한 데이터를 조회하여 비밀번호를 암호화하여 DB에서 암호화된 비밀번호가 있는지 조회함. DB에서 이메일과 비밀번호가 둘 다 일치한 DB가 있으면 로그인 성공되어 홈 화면으로 이동함. 그렇지 않으면 상황별로 알림창을 뜨도록 설정함.(유효성 검사 기능도 있음.)

### 4. 로그아웃
<img src="https://user-images.githubusercontent.com/74657556/220315562-49fd4889-1b48-4529-b417-0902c87d560f.gif" width="250" height="500">

<br/>
- 더보기 페이지에 들어가서 로그아웃 부분에 클릭하면 로그아웃 API를 POST방식으로 호출하여 사용자 id를 들고 request해서 작동함. 그 다음에 해당 회원에 대한 앱 쿠키가 지워지고 DB안에 해당 회원 id를 찾아서 token를 빈 값으로 수정함. 마지막으로 user 저장소를 빈 객체로 초기화시키고 로그인 페이지로 이동함.

### 5. 프로필 상세보기, 프로필 정보 수정 및 회원 탈퇴
<img src="https://user-images.githubusercontent.com/74657556/220316730-e103610f-068c-4b1d-8a40-3d9f01c9614c.jpeg" width="250" height="500">
<p align="center">프로필 상세보기</p>


https://user-images.githubusercontent.com/74657556/220317161-ee49de4f-f5a6-4675-ab85-858a0fc64e39.mp4
<p align="center">프로필 정보 수정</p>

<img src="https://user-images.githubusercontent.com/74657556/220350951-b6ea53ec-9429-42b7-a5b5-33f46befc233.gif" width="250" height="500">
<p align="center">프로필 상세보기</p>


<br/>
1). 프로필 상세보기 : 더보기 페이지에 들어가서 프로필 정보를 클릭하면 상태관리으로 저장된 사용자 정보를 들고 프로필 상세보기 페이지에 출력함. 
2). 프로필 정보 수정 : 프로필 상세보기 페이지에서 수정하고자 이름과 전화번호를 수정하여 프로필 수정 버튼을 클릭하면 프로필 수정 API를 호출하여 수정하고자 이름과 전화번호를 들고 request해서 작동함. 그리고 DB에서 해당 사용자를 조회해서 해당 사용자와 일치하는 데이터에 이름과 전화번호를 수정하고 updatedAt 컬럼을 해당 API를 호출했던 시점으로 수정됨. 그 다음에 프로필 정보 수정이 성공하면 프로필 정보 수정 알림창이 뜸. 그리고 프로필 정보 수정 알림창에 확인 버튼을 누르면 그 부분이 취소가 됨.(유효성 검사 기능도 있음.)
3). 회원 탈퇴 : 프로필 상세보기 페이지에서 회원 탈퇴를 누르면 회원 탈퇴 API를 호출하여 해당 사용자 id를 들고 request해서 작동함. 그리고 DB에서 해당 사용자 id로 조회하여 해당 사용자와 일치하면 deletedAt를 해당 API를 호출했던 시점으로 저장되고 회원 탈퇴 처리가 성공하면 회원 탈퇴 알림창을 뜸. 회원 탈퇴 알림창에서 확인 버튼을 클릭하면 로그인 페이지로 이동됨.
