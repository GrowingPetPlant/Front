import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:mypetplant/Find_id.dart';
import 'package:mypetplant/Find_pw.dart';
import 'package:mypetplant/Sign_in.dart';
import 'package:mypetplant/user.dart';
import 'package:mypetplant/user_service.dart';
import 'package:mypetplant/home.dart';

class Log_in extends StatefulWidget {
  const Log_in({Key? key}) : super(key: key);

  @override
  _Log_inState createState() => _Log_inState();
}

class _Log_inState extends State<Log_in> {
  TextEditingController _idController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  DBService dbService = DBService(); // DBService 인스턴스 생성

  void _login() async {
    String id = _idController.text;
    String password = _passwordController.text;

    // 아이디와 비밀번호를 모두 입력했는지 확인
    if (id.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('아이디와 비밀번호를 입력하세요')),
      );
      return;
    }

    // 로그인 시도
    bool loginResult = await dbService.login(User(id: id, password: password));

    if (loginResult) {
      // 로그인 성공 시 Home 화면으로 이동
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Home()),
      );
    } else {
      // 로그인 실패 시 사용자에게 알림
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('로그인 실패')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                          controller: _idController,
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
                          controller: _passwordController,
                          obscureText: true,
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
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Find_id()),
                            );
                          }, // 아이디찾기 화면으로 이동
                          child: Text(
                            '아이디찾기',
                            style: TextStyle(
                                fontSize: 14, color: Color(0xFF515151)),
                          ),
                        ),
                        Container(
                          height: 1, // 구분 선의 높이
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                  width: 1,
                                  color: Color(0xFFC0C0C0)), // 구분 선의 높이와 색상 설정
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Find_pw()),
                            );
                          }, // 비밀번호찾기 화면으로 이동
                          child: Text(
                            '비밀번호찾기',
                            style: TextStyle(
                                fontSize: 14, color: Color(0xFF515151)),
                          ),
                        ),
                        Container(
                          height: 1, // 구분 선의 높이
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                  width: 1,
                                  color: Color(0xFFC0C0C0)), // 구분 선의 높이와 색상 설정
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Sign_in()),
                            );
                          }, // 회원가입 화면으로 이동
                          child: Text(
                            '회원가입',
                            style: TextStyle(
                                fontSize: 14, color: Color(0xFF515151)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Spacer(),
              ElevatedButton(
                onPressed: _login, // 로그인
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Color(0x8081AE17)), // 로그인 버튼의 색상
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(10.0), // 버튼 테두리의 둥글기 정도 설정
                    ),
                  ),
                  fixedSize: MaterialStateProperty.all<Size>(
                      Size.fromHeight(60)), // 높이 설정
                ),
                child: Text(
                  '로그인',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Color(0xFFF2F2F2)), // 로그인 버튼의 텍스트 색상
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
