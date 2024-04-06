import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mypetplant/Find_id.dart';
import 'package:mypetplant/Find_pw.dart';
import 'package:mypetplant/Sign_in.dart';

class Log_in extends StatelessWidget {
  const Log_in({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xFFF2F2F2),
      body: Padding(
        padding: EdgeInsets.all(screenWidth*0.04),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 30,horizontal: 0),
                  alignment: Alignment.center,
                  child: Image(
                    image: AssetImage('assets/images/logo.png'),
                    height: 100,
                    alignment: Alignment.center,
                  ),
                ),

                Container(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(0,0,0,10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Color(0xFF81AE17), width: 2),
                        ),
                        child: Container(
                          height: 50, // 텍스트 필드 창 높이 조절
                          child: TextField(
                          style: TextStyle(fontSize: 16),
                          decoration: InputDecoration(
                            hintText: '아이디',
                            contentPadding: EdgeInsets.fromLTRB(10,0,10,0),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Color(0xFF81AE17), width: 2),
                      ),
                      child : SizedBox(
                        height: 50, // 텍스트 필드 창 높이 조절
                        child: TextField(
                          obscureText: true,
                          style: TextStyle(fontSize: 16),
                          decoration: InputDecoration(
                            hintText: '비밀번호',
                            contentPadding: EdgeInsets.fromLTRB(10,0,10,0),
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
                              MaterialPageRoute(builder: (context) => const Find_id()),
                            );
                          }, // 아이디찾기 화면으로 이동
                          child: Text(
                            '아이디찾기',
                            style: TextStyle(fontSize: 14, color: Color(0xFF515151)),
                          ),
                        ),
                        Container(height : 20, width : 1, color : Color(0xffc0c0c0),),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const Find_pw()),
                            );
                          }, // 비밀번호찾기 화면으로 이동
                          child: Text(
                            '비밀번호찾기',
                            style: TextStyle(fontSize: 14, color: Color(0xFF515151)),
                          ),
                        ),
                        Container(height : 20, width : 1, color : Color(0xffc0c0c0),),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const Sign_in()),
                            );
                          }, // 회원가입 화면으로 이동
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
            ]
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
                  '로그인',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFFF2F2F2)), // 로그인 버튼의 텍스트 색상
                ),
              ),
            ),
          )
    );
  }
}