# UsedOpenApi

- - -
### explanation

- 공공데이터 포털의 OpenAPI 중 "공공데이터활용지원센터"에서 제공하는 "좌표(위/경도) 기준 공적 마스크 판매정보 제공 서비스" Open API를 이용한 앱
  1. Data 객체에서 제공되는 Data(contentsOf:) 초기화 구문을 이용하여 REST API를 호출하고 응답을 받아왔습니다.
  2. JSON 데이터를 Foundation 프레임워크에서 제공하는 JSONSerialization 객체의 jsonObject() 메서드를 사용하여 파싱 하였습니다.
  3. 목록 탭에서는 Pagination을 구현하여 모든 데이터를 읽어오기 전까지 스크롤이 계속 될 수 있도록 했습니다.
  4. 검색 탭에서는 모든 데이터를 불러와 검색에 따른 결과의 개수와 검색 결과만을 테이블 뷰에 보여주게 구현했습니다.

- 공공데이터 포털에서 제공한 API가 더 이상 API를 제공하지 않아 mask app 이 정상적으로 동작하지 않습니다.(200813 Update)

- - -
### Purpose

- Open API를 이용하여 API 기본 정보 학습.
- 네트워크 객체를 통한 데이터 요청 기능 구현 및 학습.
- 전달받은 데이터를 파싱하여 화면에 출력 구현 및 학습.
- 추가 데이터를 다시 요청하는 방식인 페이징(Paging)처리 구현 및 학습.

- - -
공공 데이터 포털에서 제공하는 Open API 중 "좌표(위/경도) 기준 공적 마스크 판매정보 제공 서비스 API"를 사용하여 공적 마스크를 판매하는 곳의 판매처명, 판매처 유형, 판매처 주소를 보여주는 앱 입니다.

- 기간 : 2020.06.19 ~ 2020.06.30
- 역활 : 앱 전체 구현
- 사용기술 : Swift, Foundation, JSONSerialization, UIKit
- 프로젝트 인원 : 1명
- [공적 마스크 앱](https://github.com/VincentGeranium/UsedOpenApi)

| 목록 | 검색 |
|:---:|:---:|
<img width="200" alt="mask-1" src="https://github.com/VincentGeranium/Resume/blob/master/IMAGE/mask-1.png?raw=true">|<img width="200" alt="mask-3" src="https://github.com/VincentGeranium/Resume/blob/master/IMAGE/mask-3.png?raw=true">
