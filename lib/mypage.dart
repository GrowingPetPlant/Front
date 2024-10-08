import 'dart:ui' as ui;

import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:mypetplant/Home.dart';
import 'package:mypetplant/Log_in.dart';
import 'package:mypetplant/token.dart';
import 'package:mypetplant/user.dart';
import 'package:mypetplant/user_service.dart';
import 'package:mypetplant/widget.dart';

String text = "";

class My_page extends StatefulWidget {
  final UserInfo? userinfo;
  const My_page({super.key, this.userinfo});

  @override
  State<My_page> createState() => _My_page_view();
}

class _My_page_view extends State<My_page> {
  late TextEditingController _idController;
  late TextEditingController _passwordController;
  late TextEditingController _nameController;
  late TextEditingController _phoneNumberController;
  String validPassword = "";
  String validName = "";
  String validPhoneNumber = "";
  String validPlantName = "";
  bool auto = false;

  DBService dbService = DBService(); // DBService 인스턴스 생성

  void _logout() async {
    String? logout = await dbService.logout();
    if (logout != null) {
      text = "로그아웃 되었습니다";
    } else {
      text = "로그아웃 실패";
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
      ),
    );
  }

  void _deleteUser(String id) async {
    String? deleteUser = await dbService.deleteUser(id);
    if (deleteUser != null) {
      text = "사용자 탈퇴가 완료되었습니다";
    } else {
      text = "사용자 탈퇴 실패";
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
      ),
    );
  }

  void _mypage() async {
    int userNumber = widget.userinfo!.userNumber;
    String id = widget.userinfo!.id;
    String password = _passwordController.text;
    String name = _nameController.text;
    String phoneNumber = _phoneNumberController.text;

    // 모두 입력했는지 확인
    if (id.isEmpty ||
        password.isEmpty ||
        name.isEmpty ||
        phoneNumber.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('수정할 내용을 입력하세요')),
      );
      return;
    }

    String? editResult = await dbService.mypage(UserInfo(
        userNumber: userNumber,
        id: id,
        password: password,
        userName: name,
        phoneNumber: phoneNumber,
        auto: auto
        ));

    if (editResult != null) {
      // 마이페이지 수정 성공 시 Home 화면으로 이동
      // 로그인 성공 시 Home 화면으로 이동
      //UserPlant? userplant = await findUserPlant(UserNumber(userNumber: loginResult));
      //String plantName = userplant!.plantName;
      List<HomeInfo>? homeInfo = await dbService.home();
      if (homeInfo != null)
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) =>
              Home(homeinfo: homeInfo, userNumber: homeInfo[0].userNumber)),
        );
    }
     else {
      // 로그인 실패 시 사용자에게 알림
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('마이페이지 수정 실패')),
      );
    }
  }

  String _validatePasswordLogic(String value) {
    if (value == null || value.isEmpty) {
      return '비밀번호를 입력해주세요.';
    } else if (value.length < 8 || value.length > 16) {
      return "비밀번호를 8~16자리로 입력해주세요";
    } else if (!RegExp(
            r'^(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&#])[A-Za-z\d@$!%*?&#]*$')
        .hasMatch(value)) {
      return '비밀번호는 소문자, 숫자, 특수문자를 모두 포함해야합니다';
    } else
      return "";
  }

  void _validatePassword(String value) {
    setState(() {
      validPassword = _validatePasswordLogic(value);
    });
  }

  String _validateUserNameLogic(String value) {
    if (value == null || value.isEmpty) {
      return '이름을 입력해주세요.';
    }
    return "";
  }

  void _validateUserName(String value) {
    setState(() {
      validName = _validateUserNameLogic(value);
    });
  }

  String _validatePhoneNumberLogic(String value) {
    if (value == null || value.isEmpty) {
      return '전화번호를 입력해주세요.';
    } else if (!RegExp(r'^\d{3}-\d{4}-\d{4}$').hasMatch(value)) {
      return '전화번호 형식은 000-0000-0000으로 입력해주세요.';
    }
    return "";
  }

  void _validatePhoneNumber(String value) {
    setState(() {
      validPhoneNumber = _validatePhoneNumberLogic(value);
    });
  }

  @override
  void initState() {
    super.initState();
    _idController = TextEditingController(text: widget.userinfo!.id);
    _passwordController =
        TextEditingController(text: widget.userinfo!.password);
    _nameController =
        TextEditingController(text: widget.userinfo!.userName);
    _phoneNumberController =
        TextEditingController(text: widget.userinfo!.phoneNumber);
  }

  @override
  void dispose() {
    // 위젯이 dispose될 때 TextEditingController를 해제합니다.
    _idController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: const Color(0xFFF2F2F2),
        body: Padding(
          padding: EdgeInsets.all(screenHeight * 0.04),
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                  children: [
                    logoTitle(text: '회원정보수정', screenHeight: screenHeight),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            titleInputBox(title: '아이디', screenHeight: screenHeight),
                          ],
                        ),
                        inputBox(hint: '아이디를 입력해주세요', controller: _idController, enabled : false)
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            titleInputBox(title: '비밀번호', screenHeight: screenHeight),
                            warningText(text: validPassword, screenHeight: screenHeight)
                          ],
                        ),
                        inputBox(hint: '비밀번호를 입력해주세요', controller: _passwordController, function: _validatePassword,obscure: true,)
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            titleInputBox(title: '닉네임', screenHeight: screenHeight),
                            warningText(text: validName, screenHeight: screenHeight)
                          ],
                        ),
                        inputBox(hint: '닉네임을 입력해주세요', controller: _nameController, function: _validateUserName,)
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            titleInputBox(title: '전화번호', screenHeight: screenHeight),
                            warningText(text: validPhoneNumber, screenHeight: screenHeight)
                          ],
                        ),
                        inputBox(hint: '전화번호를 입력해주세요', controller: _phoneNumberController, function: _validatePhoneNumber,)
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children : [
                            Padding(padding: EdgeInsets.symmetric(horizontal: 5, vertical: 20),
                              child : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                    Text(
                                      "자동화 설정",
                                      style: TextStyle(fontSize: 14, fontWeight: ui.FontWeight.bold),
                                    ),
                                    Text(
                                      "식물이 자라는 최적의 환경을 자동으로 유지해줍니다!",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ],
                                ),
                            ),
                            Switch(
                              value: auto,
                              onChanged: (value) { setState(() { auto = value; });
                                print(auto);
                              },
                              inactiveTrackColor: Color(0xffffffff),
                              inactiveThumbColor: Color(0x8081AE17),
                              activeTrackColor: Color(0x8081AE17),
                              trackOutlineColor: MaterialStateColor.resolveWith((states) => Color(0x8081AE17)),
                            )
                          ]

                          )
                        ]
                        ),
                      ],
                    ),

              ),
            ),
          ),
        bottomNavigationBar: Container(
          color: const Color(0xfff2f2f2),
          padding: EdgeInsets.only(
              bottom: screenHeight * 0.02,
              left: screenHeight * 0.02,
              right: screenHeight * 0.02),
          child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                BottomAppBar(
                  elevation: 0,
                  color: const Color(0xFFF2F2F2),
                  child: ElevatedButton(
                    onPressed: () {
                      _mypage();
                    }, // 수정하기
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color(0x8081AE17)), // 로그인 버튼의 색상
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(10.0), // 버튼 테두리의 둥글기 정도 설정
                        ),
                      ),
                      fixedSize: MaterialStateProperty.all<ui.Size>(
                          const ui.Size.fromHeight(60)), // 높이 설정
                    ),
                    child: const Text(
                      '수정하기',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Color(0xFFF2F2F2)), // 로그인 버튼의 텍스트 색상
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        _logout();
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Log_in()));
                      },
                      child: const Text(
                        '로그아웃',
                        style:
                            TextStyle(fontSize: 14, color: Color(0xFF515151)),
                      ),
                    ),
                    Container(
                      height: 20,
                      width: 1,
                      color: const Color(0xffc0c0c0),
                    ),
                    TextButton(
                      onPressed: () {
                        _deleteUser(widget.userinfo!.id);
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Log_in()));
                      },
                      child: const Text(
                        '탈퇴하기',
                        style:
                            TextStyle(fontSize: 14, color: Color(0xFF515151)),
                      ),
                    ),
                  ],
                )
              ]),
        ));
  }
}
