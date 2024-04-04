import 'package:flutter/material.dart';

class Find_id extends StatelessWidget {
  const Find_id({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyPetPlant',
      home: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 40),
              Center(
                child: Image.asset(
                  'assets/images/logo.png', // 로고 이미지 파일 경로
                  height: 73, // 로고 이미지의 높이
                ),
              ),
              SizedBox(height: 10),
              Center(
                child: Text(
                  '아이디 찾기',
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
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Color(0xFF81AE17), width: 2),
                ),
                child: SizedBox(
                  height: 40, // 텍스트 필드 창 높이 조절
                  child: TextField(
                    style: TextStyle(fontSize: 13),
                    decoration: InputDecoration(
                      hintText: '사용자 이름을 입력하세요',
                      contentPadding: EdgeInsets.all(10),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                '전화번호', // 전화번호 입력창 위의 텍스트
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
                      hintText: '전화번호를 입력하세요',
                      contentPadding: EdgeInsets.all(10),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              Spacer(), // 버튼 위젯 위의 여유 공간을 생성합니다.
              ElevatedButton(
                onPressed: () {
                  // 버튼 클릭 시 처리할 내용
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF81AE17)), // 아이디 찾기 버튼의 색상
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0), // 버튼 테두리의 둥글기 정도 설정
                    ),
                  ),
                ),
                child: Text(
                  '아이디 찾기', // 버튼 텍스트
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