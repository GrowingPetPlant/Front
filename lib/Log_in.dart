import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Log_in extends StatelessWidget {
  const Log_in({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyPetPlant',
      home: Scaffold(
        backgroundColor: Color(0xFFF2F2F2),
        body: Padding(
          padding: const EdgeInsets.all(30),
          child: Container(
            margin: EdgeInsets.fromLTRB(0, 195, 0, 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                  Container(
                    alignment: Alignment.center,
                    child: Image(
                      image: AssetImage('assets/images/logo.png'),
                      height: 100,
                      width: 92, // 로고 이미지의 높이
                      alignment: Alignment.center,
                    ),
                  ),
                SizedBox(height: 40),
                Container(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Color(0xFFADC178), width: 2),
                      ),
                      child: SizedBox(
                        height: 50, // 텍스트 필드 창 높이 조절
                        child: TextField(
                          style: TextStyle(fontSize: 16),
                          decoration: InputDecoration(
                            hintText: '아이디',
                            contentPadding: EdgeInsets.all(10),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                      SizedBox(height: 10),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Color(0xFFADC178), width: 2),
                        ),
                        child: SizedBox(
                          height: 50, // 텍스트 필드 창 높이 조절
                          child: TextField(
                            style: TextStyle(fontSize: 16),
                            decoration: InputDecoration(
                              hintText: '비밀번호',
                              contentPadding: EdgeInsets.all(10),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {}, // 아이디찾기 화면으로 이동
                            child: Text(
                              '아이디찾기',
                              style: TextStyle(fontSize: 14, color: Color(0xFF515151)),
                            ),
                          ),
                          Container(
                            height: 1, // 구분 선의 높이
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(width: 1, color: Color(0xFFC0C0C0)), // 구분 선의 높이와 색상 설정
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {}, // 비밀번호찾기 화면으로 이동
                            child: Text(
                              '비밀번호찾기',
                              style: TextStyle(fontSize: 14, color: Color(0xFF515151)),
                            ),
                          ),
                          Container(
                            height: 1, // 구분 선의 높이
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(width: 1, color: Color(0xFFC0C0C0)), // 구분 선의 높이와 색상 설정
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {}, // 회원가입 화면으로 이동
                            child: Text(
                              '회원가입',
                              style: TextStyle(fontSize: 14, color: Color(0xFF515151)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Spacer(),
                ElevatedButton(
                  onPressed: () {}, // 로그인
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Color(0x8081AE17)), // 로그인 버튼의 색상
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0), // 버튼 테두리의 둥글기 정도 설정
                      ),
                    ),
                    fixedSize: MaterialStateProperty.all<Size>(Size.fromHeight(60)), // 높이 설정
                  ),
                  child: Text(
                    '로그인',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFFF2F2F2)), // 로그인 버튼의 텍스트 색상
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}