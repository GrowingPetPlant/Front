import 'package:flutter/material.dart';
import 'package:mypetplant/user_service.dart';
import 'package:mypetplant/widget.dart';
import 'user.dart';

String text="";

class Find_id extends StatefulWidget {
  const Find_id({super.key});

  @override
  _Find_idState createState() => _Find_idState();
}

class _Find_idState extends State<Find_id> {
  String validPhoneNumber = "";
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  DBService dbService = DBService(); // DBService 인스턴스 생성

  void _find_id() async {
    String userName = _nameController.text;
    String phoneNumber = _phoneNumberController.text;



    // 아이디와 비밀번호를 모두 입력했는지 확인
    if (userName.isEmpty || phoneNumber.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('이름과 전화번호를 입력하세요')),
      );
      return;
    }

    // 아이디찾기 시도
    String? loginResult = await dbService.find_Id(findId(name: userName, phone_number: phoneNumber));

    if (loginResult!=null && loginResult!="") {
      // 아이디찾기 성공 시 팝업창에 아이디 띄우기
      text = loginResult;
      findIdDialog(context);
    }
    else if(loginResult==""){
      text = "존재하지 않는 사용자입니다";
      findIdDialog(context);
    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('아이디 찾기 실패')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery
        .of(context)
        .size
        .height;
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      body: Padding(
        padding: EdgeInsets.all(screenHeight * 0.04),
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                logoTitle(text: '아이디 찾기', screenHeight: screenHeight),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    titleInputBox(title: '이름', screenHeight: screenHeight),
                    inputBox(
                      hint: '사용자 이름',
                      controller: _nameController,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        titleInputBox(
                            title: '전화번호', screenHeight: screenHeight),
                        warningText(
                            text: validPhoneNumber, screenHeight: screenHeight),
                      ],
                    ),
                    inputBox(
                      hint: '전화번호를 입력해주세요',
                      controller: _phoneNumberController,
                      function: _validatePhoneNumber,
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
          margin : const EdgeInsets.only(bottom : 60),
          color: const Color(0xfff2f2f2),
          child : BottomAppBar(
            color: const Color(0xfff2f2f2),
            elevation: 0,
            child :ElevatedButton(
              onPressed: () {
              _find_id();
              }, // 로그인
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(const Color(0xff81AE17)), // 로그인 버튼의 색상
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0), // 버튼 테두리의 둥글기 정도 설정
                  ),
                ),
                fixedSize: MaterialStateProperty.all<Size>(const Size.fromHeight(60)), // 높이 설정
              ),
              child: const Text(
                '비밀번호 찾기',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFFF2F2F2)), // 로그인 버튼의 텍스트 색상
              ),
            ),
          ),
        )
    );
  }
  String _validatePhoneNumberLogic(String value) {
    if (value == null || value.isEmpty) {
      return '전화번호를 입력해주세요.';
    } else if (!RegExp(r'^\d{3}-\d{4}-\d{4}$').hasMatch(value)) {
      return '전화번호 형식은 000-0000-0000으로 입력해주세요.';
    }
    return "";
  }

  void _validatePhoneNumber(String value){
    setState(() {
      validPhoneNumber = _validatePhoneNumberLogic(value);
    });
  }
}

void findIdDialog(context){
  showDialog(context: context, builder: (context){
    return Dialog(
      child : Container(
        padding: const EdgeInsets.fromLTRB(30,30,30,20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(text,textAlign : TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xff515151)),),
            TextButton(onPressed: (){
              Navigator.of(context).pop();
            },
                child: const Text("확인",style: TextStyle(fontSize: 16, color: Color(0xff81ae17)),)),
            ],
          ),
        )
      );
    }
  );
}