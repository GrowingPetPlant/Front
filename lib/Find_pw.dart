import 'package:flutter/material.dart';

class Find_pw extends StatelessWidget { // StatelessWidget : 상태가 없는 위젯
  const Find_pw({super.key});

  @override
  Widget build(BuildContext context) { // 플러터의 모든 위젯은 build()를 구현. 위젯의 UI 생성.
    return MaterialApp( // 앱의 기본 레이아웃 구조 제공
      title: 'MyPetPlant', // App title
      home: Scaffold (
        body: Padding( // 자식 위젯 감싸고 내부 여백 추가
          padding: EdgeInsets.all(50.0), // 양 측면에 16.0의 내부 여백 추가
          child: Column( // 세로로 위젯들을 배열
            crossAxisAlignment: CrossAxisAlignment.stretch, // 자식 위젯이 교차 축을 따라 확장
            children: [ // 자식 위젯들
              SizedBox(height: 10), // 여백 추가
              Center( // 자식을 가운데로 정렬
                child: Image.asset( // 이미지 리소스 표시
                  'assets/images/logo.png', // 로고 이미지 파일 경로
                  height: 73, // 로고 이미지의 높이
                ),
              ),
              Center(
                child: Text(
                  '비밀번호 찾기',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF56280F)),
                ),
              ),
              SizedBox(height: 60),
              Text(
                '이름', // 이름 입력창 위의 텍스트
                style: TextStyle(fontSize: 11),
              ),
              SizedBox(height: 10),
              Container(
                decoration: BoxDecoration( // 컨테이너 테두리 설정
                  borderRadius: BorderRadius.circular(10), // 테두리 둥글게
                  border: Border.all(color: Color(0xFF81AE17), width: 2), // 테두리 굵기, 색상
                ),
                child: SizedBox(
                  height: 40, // 텍스트 필드 창 높이 조절
                  child: TextField(
                    style: TextStyle(fontSize: 13), // 힌트 텍스트 폰트
                    decoration: InputDecoration(
                      hintText: '사용자 이름을 입력해주세요', // 힌트 텍스트 내용
                      contentPadding: EdgeInsets.all(10), // 텍스트 필드 창 내부 여백
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                '아이디', // 아이디 입력창 위의 텍스트
                style: TextStyle(fontSize: 11),
              ),
              SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Color(0xFF81AE17), width: 2),
                ),
                child: SizedBox(
                  height: 40, // 텍스트 필드 창 높이 조절
                  child: TextField(
                    style: TextStyle(fontSize: 13),
                    decoration: InputDecoration(
                      hintText: '아이디를 입력해주세요',
                      contentPadding: EdgeInsets.all(10),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              Spacer(), // 버튼 위젯 위의 여유 공간을 생성합니다.
              ElevatedButton( // 버튼 위젯
                onPressed: () {
                  // 버튼 클릭 시 처리할 내용
                },
                style: ButtonStyle( // 버튼 디자인
                  backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF81AE17)), // 아이디 찾기 버튼의 색상
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0), // 버튼 테두리의 둥글기 정도 설정
                    ),
                  ),
                ),
                child: Text(
                  '비밀번호 찾기', // 버튼 텍스트
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFFF2F2F2)), // 아이디 찾기 텍스트의 색상
                ),
              ),
              SizedBox(height: 70),
            ],
          ),
        ),
      ),
    );
  }
}