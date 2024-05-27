import 'package:flutter/material.dart';
import 'package:mypetplant/user_service.dart';
import 'user.dart';

String text="";

class Find_pw extends StatefulWidget {
  const Find_pw({super.key});

  @override
  _Find_pwState createState() => _Find_pwState();
}

class _Find_pwState extends State<Find_pw>{

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
    String? loginResult = await dbService.find_pw(findPw(name: userName, id: id));

    if (loginResult!=null && loginResult!="") {
      // 비밀번호찾기 성공 시 팝업창에 비밀번호 띄우기
      text = loginResult;
      findPWDialog(context);
    }
    else if(loginResult==""){
      text = "존재하지 않는 사용자입니다";
      findPWDialog(context);
    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('비밀번호 찾기 실패')),
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
                SizedBox(
                    height: screenHeight * 0.15,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Image.asset(
                          'assets/images/logo.png',
                          height: screenHeight * 0.1,
                        ),
                        const Text(
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
                const SizedBox(height : 30),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(screenHeight * 0.01),
                      child: const Text(
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
                      padding: const EdgeInsets.only(bottom: 10),
                      child: TextField(
                        controller: _nameController,
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
                      child: const Text(
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
                      padding: const EdgeInsets.only(bottom: 10),
                      child: TextField(
                        controller: _idController,
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
          margin : const EdgeInsets.only(bottom : 60),
          color: const Color(0xfff2f2f2),
          child : BottomAppBar(
            color: const Color(0xfff2f2f2),
            elevation: 0,
            child :ElevatedButton(
              onPressed: () {
                _find_pw();
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
}

void findPWDialog(context){
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
              }, child: const Text("확인",style: TextStyle(fontSize: 16, color: Color(0xff81ae17)),)),
            ],
          ),
        ));
  });
}
