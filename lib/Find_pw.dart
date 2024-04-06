import 'package:flutter/material.dart';

class Find_pw extends StatelessWidget {
  // StatelessWidget : 상태가 없는 위젯
  const Find_pw({super.key});

  @override
  Widget build(BuildContext context) {
    // 플러터의 모든 위젯은 build()를 구현. 위젯의 UI 생성.
    final screenHeight = MediaQuery
        .of(context)
        .size
        .height;
    return Scaffold(
      backgroundColor: Color(0xFFF2F2F2),
      body: Padding(
        padding: EdgeInsets.all(screenHeight * 0.04),
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Container(
                    height: screenHeight * 0.15,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Image.asset(
                          'assets/images/logo.png',
                          height: screenHeight * 0.1,
                        ),
                        Text(
                            '비밀번호 찾기',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF56280F)
                            )
                        ),
                      ],
                    )
                ),
                SizedBox(height : 30),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(screenHeight * 0.01),
                      child: Text(
                        '이름',
                        style: TextStyle(fontSize: 11),
                      ),
                    ),

                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: const Color(0xFF81AE17),
                            width: 2),
                      ),
                      padding: EdgeInsets.only(bottom: 10),
                      child: const TextField(
                        style: TextStyle(fontSize: 13),
                        decoration: InputDecoration(
                            hintText: '사용자 이름',
                            contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                            border: InputBorder.none
                        ),
                      ),
                    ),
                  ],
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(screenHeight * 0.01),
                      child: Text(
                        '아이디',
                        style: TextStyle(fontSize: 11),
                      ),
                    ),

                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: const Color(0xFF81AE17),
                            width: 2),
                      ),
                      padding: EdgeInsets.only(bottom: 10),
                      child: const TextField(
                        style: TextStyle(fontSize: 13),
                        decoration: InputDecoration(
                            hintText: '아이디를 입력해주세요',
                            contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                            border: InputBorder.none
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
        bottomNavigationBar:
        Container(
          margin : EdgeInsets.only(bottom : 60),
          color: Color(0xfff2f2f2),
          child : BottomAppBar(
            color: Color(0xfff2f2f2),
            elevation: 0,
            child :ElevatedButton(
              onPressed: () {}, // 로그인
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Color(0xff81AE17)), // 로그인 버튼의 색상
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0), // 버튼 테두리의 둥글기 정도 설정
                  ),
                ),
                fixedSize: MaterialStateProperty.all<Size>(Size.fromHeight(60)), // 높이 설정
              ),
              child: Text(
                '비밀번호 찾기',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFFF2F2F2)), // 로그인 버튼의 텍스트 색상
              ),
            ),
          ),
        )
    );
  }
}

