import 'package:flutter/material.dart';
import 'package:mypetplant/user_service.dart';
import 'package:mypetplant/widget.dart';
import 'user.dart';

String text = "";

class Find_pw extends StatefulWidget {
  const Find_pw({super.key});

  @override
  _Find_pwState createState() => _Find_pwState();
}

class _Find_pwState extends State<Find_pw> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _idController = TextEditingController();
  DBService dbService = DBService(); // DBService 인스턴스 생성

  void _find_pw() async {
    String userName = _nameController.text;
    String id = _idController.text;

    // 아이디와 이름을 모두 입력했는지 확인
    if (userName.isEmpty || id.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('이름과 아이디를 입력하세요')),
      );
      return;
    }

    // 비밀번호찾기 시도
    String? loginResult =
        await dbService.find_pw(findPw(name: userName, id: id));

    if (loginResult != null && loginResult != "") {
      // 비밀번호찾기 성공 시 팝업창에 비밀번호 띄우기
      text = loginResult;
      findPWDialog(context);
    } else if (loginResult == "") {
      text = "존재하지 않는 사용자입니다";
      findPWDialog(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('비밀번호 찾기 실패')),
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
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                logoTitle(text: '비밀번호 찾기', screenHeight: screenHeight),
                const SizedBox(height: 30),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    titleInputBox(title: '이름', screenHeight: screenHeight),
                    inputBox(hint: '사용자이름', controller: _nameController),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    titleInputBox(title: '아이디', screenHeight: screenHeight),
                    inputBox(hint: '아이디를 입력해주세요', controller: _idController),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar:
          bottomGreenButton(text: '비밀번호 찾기', onPressed: _find_pw),
    );
  }
}

void findPWDialog(context) {
  showDialog(
      context: context,
      builder: (context) {
        return Dialog(
            child: Container(
          padding: const EdgeInsets.fromLTRB(30, 30, 30, 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Color(0xff515151)),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    "확인",
                    style: TextStyle(fontSize: 16, color: Color(0xff81ae17)),
                  )),
            ],
          ),
        ));
      });
}
