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
스플래시 화면에서 이 앱 안에 사용자 정보를 들어있는 Android는 KeyStore를, IOS는 KeyChain를 통해 내부 저장소를 저장합니다. 그리고 그것을 통해 로그인을 유지하는 방식으로 했습니다. 그리고 회원 인증 API를 호출하여 사용자 정보를 통해 유효하고 존재하는지 검사하고 그 사용자 정보가 유효하고 존재하면 홈 화면으로 이동하고 그렇지 않으면 로그인 페이지로 이동 
