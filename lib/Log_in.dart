import 'package:flutter/material.dart';

import 'package:mypetplant/Find_id.dart';
import 'package:mypetplant/Find_pw.dart';
import 'package:mypetplant/Home.dart';
import 'package:mypetplant/Sign_in.dart';
import 'package:mypetplant/token.dart';
import 'package:mypetplant/user.dart';
import 'package:mypetplant/user_service.dart';
import 'package:mypetplant/widget.dart';

class Log_in extends StatefulWidget {
  const Log_in({super.key});

  @override
  _Log_inState createState() => _Log_inState();

}

class _Log_inState extends State<Log_in> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  DBService dbService = DBService(); // DBService 인스턴스 생성

  void _login() async {
    String id = _idController.text;
    String password = _passwordController.text;

    // 아이디와 비밀번호를 모두 입력했는지 확인
    if (id.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('아이디와 비밀번호를 입력하세요')),
      );
      return;
    }

    // 로그인 시도
    await dbService.login(User(id: id, password: password));

    if (accessToken != null) {
      // 로그인 성공 시 Home 화면으로 이동
      //UserPlant? userplant = await findUserPlant(UserNumber(userNumber: loginResult));
      //String plantName = userplant!.plantName;
      List<HomeInfo>? homeInfo = await dbService.home();
      print(homeInfo);
      if(homeInfo!=null)
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Home(homeinfo: homeInfo, userNumber: homeInfo[0].userNumber)),
        );
    } else {
      // 로그인 실패 시 사용자에게 알림
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('로그인 실패')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      body: Padding(
        padding: EdgeInsets.all(screenHeight * 0.04),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 0),
            alignment: Alignment.center,
            child: const Image(
              image: AssetImage('assets/images/logo.png'),
              height: 100,
              alignment: Alignment.center,
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: Column(
              children: [
                inputBox(hint: '아이디', controller: _idController, margin: 10,),
                inputBox(hint: '비밀번호', controller: _passwordController, margin: 10,obscure: true,),

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
                          child: const Text(
                            '아이디찾기',
                            style: TextStyle(
                                fontSize: 14, color: Color(0xFF515151)),
                          ),
                        ),

                        Container(height : 20, width : 1, color : const Color(0xffc0c0c0),),

                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Find_pw()),
                            );
                          }, // 비밀번호찾기 화면으로 이동
                          child: const Text(
                            '비밀번호찾기',
                            style: TextStyle(
                                fontSize: 14, color: Color(0xFF515151)),
                          ),
                        ),

                        Container(height : 20, width : 1, color : const Color(0xffc0c0c0),),

                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Sign_in()),
                            );
                          }, // 회원가입 화면으로 이동
                          child: const Text(
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
              ]
            ),
          ),

        bottomNavigationBar:
          Container(
            margin : const EdgeInsets.only(bottom : 60),
            color: const Color(0xfff2f2f2),
            child : BottomAppBar(
              color: const Color(0xfff2f2f2),
              elevation: 0,
              child :ElevatedButton(
                onPressed: _login, // 로그인
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(const Color(0xff81AE17)), // 로그인 버튼의 색상

                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(10.0), // 버튼 테두리의 둥글기 정도 설정
                    ),
                  ),
                  fixedSize: MaterialStateProperty.all<Size>(
                      const Size.fromHeight(60)), // 높이 설정
                ),
                child: const Text(
                  '로그인',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Color(0xFFF2F2F2)), // 로그인 버튼의 텍스트 색상
                ),
              ),
            ),
          )
    );
  }
}
