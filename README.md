# todo-list
그룹프로젝트 #1

## 개발
- BE - [@Dong](https://github.com/d-h-k), [@Marco](https://github.com/95degree)
- iOS - [@Neo](https://github.com/d-h-k/todo-list/commits?author=HoonHaChoi), [@쑤](https://github.com/lenaios)

## BE
### 프로그래밍 요구사항
- Spring boot 사용한다.
- 데이터베이스는 Spring Data JDBC를 통해 연동한다.
- 모바일에서 필요한 API를 제공한다.
- [옵션] JWT를 이용한 토큰 방식 인증을 구현한다.
- [옵션] 스프링 인터셉터의 사용법을 학습하고 인증에 이를 적용한다.
- spring security는 사용을 금지한다.
- mockup API를 이용해서 개발한다. 백엔드에서 프론트 및 모바일에서 필요한 API를 제공한다.
- AWS EC2를 이용해 배포한다. 수동으로 배포를 진행하며 자동배포는 금지, 배포도구 사용도 금지한다.
- MySQL 사용, 데이터베이스와 웹 서버 모두 동일한 인스턴스를 사용한다.
- 리눅스 서버에서 소스를 가져올 때는 git을 사용한다.
- 배포 서버에는 항상 동작하고 있는 버전이 배포되어 있어야 한다. 또한 master 브랜치를 이용해서 서비스를 배포한다.

## iOS
### 프로그래밍 요구사항
- 아이패드 Pro(11inch) 화면 사이즈를 기준으로 스토리보드에서 작업한다.
- 오토레이아웃을 적용한다.
- 화면별로 MVC 구조를 명확하게 구분한다.
- Delegate 프로토콜 구현을 별도의 클래스 등으로 분리하여 ViewController에 모든 Delegate를 포함하지 않도록 한다.
- 전체 화면에 대한 ViewController와 각 카드 리스트 화면을 담당하는 ViewController를 구분하고 embed 된 구조로 구현한다.
- 카드 리스트 화면은 TableView를 사용한다.
- 카드 리스트 TableView 사이에 Drag & Drop이 가능하게 한다.
- Context Menu를 구현한다.
- 서버에 데이터를 요청할 때는 URLSession 클래스를 활용한다.

### 개발 중 고민한 것
- 카드 리스트를 보여줄 TableView를 하나만 생성해서 재사용 할 수 있지 않을까?
- 각 카드 리스트의 Delegate, DataSource 파일도 1개로 줄일 수 있지 않을까?
- Delegate가 되는 객체의 역할 분리 - 네트워크 통신을 위한 Use Case를 만들자

## 회고
- 쑤 : 개발 일정을 더 세세하게 나눠서 단계별로 구현하지 못한 것 같아 아쉽다. 이후에는 요구사항에 따른 개발 일정을 작은 단위로 나눠 작업해야겠다.
- Marco : [회고록](https://www.notion.so/To-do-List-99cdcdf3c6714f69b3ae17e78f1e9f2c)

## 발표 자료
- [ppt](https://drive.google.com/file/d/15AzrEOCYkTzSvODTuxxgbdd-m283bbFm/view)

## 결과물
<img width="1048" alt="" src="https://user-images.githubusercontent.com/75113784/115102520-5840ae00-9f86-11eb-9cd1-643cb0ff4e37.png">
