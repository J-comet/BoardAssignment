# BoardAssignment
   
<br>

### 프로젝트
 - 기간 : 2023.11.17 ~ 2023.11.22 (6일) <br>
 - 최소지원버전 : iOS 14 <br>
 <br>

### 미리보기
![이미지](https://github.com/J-comet/SearchiTunesRx/assets/67407666/f774cca9-3c19-48f9-ae33-bf6ca56ac5f4)

<br>

### 기술
| Category | Stack |
|:----:|:-----:|
| Architecture | `MVVM` |
|  UI  | `SnapKit` |
|  DB  | `Realm` |
| Reactive | `RxSwift` |
|  Network  | `Alamofire` `Codable` |
|  Image  | `Kingfisher` |
|  Dependency Manager  | `SPM` |
| Etc | `Then` |

<br>

### 개발 고려사항
- RxSwift + MVVM 
- DTO 개념을 적용해 서버의 파라미터명이 변경되어도 앱 강제종료 방지
- 스플래시 화면에서 게시판 메뉴 API 한번만 호출 후 Realm 에 저장 후 캐싱데이터로 사용
- 재사용을 고려한 CustomView 만들어서 사용
- repository 패턴 적용
- 검색어 중복입력 방지 / API 연속 호출 방지
- 라이트모드 고정 / 로컬라이징

