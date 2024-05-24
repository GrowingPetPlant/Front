
import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:mypetplant/Home.dart';
import 'package:mypetplant/Log_in.dart';
import 'package:mypetplant/user.dart';
import 'package:mypetplant/user_service.dart';

String text="";

List<String> dropdownList = ['토마토', '바질', '수박'];
String? selectedDropdown;

class My_page extends StatefulWidget {
  final UserInfo_plant? userInfo_plant;
  const My_page({super.key, this.userInfo_plant});

  @override
  State<My_page> createState() => _My_page_view();
}

class _My_page_view extends State<My_page> {

  late TextEditingController _idController;
  late TextEditingController _passwordController;
  late TextEditingController _nameController;
  late TextEditingController _phoneNumberController;
  late TextEditingController _plantNameController;
  String plantType="";
  String validPassword = "";
  String validName = "";
  String validPhoneNumber = "";
  String validPlantName = "";

  DBService dbService = DBService(); // DBService 인스턴스 생성

  void _logout() async{
    String? logout = await dbService.logout();
    if(logout!=null){
      text="로그아웃 되었습니다";
    }
    else{
      text="로그아웃 실패";
    }
    ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(text),),);
  }

  void _deleteUser(String id) async{
    String? deleteUser = await dbService.deleteUser(id);
    if(deleteUser!=null){
      text="사용자 탈퇴가 완료되었습니다";
    }
    else{
      text="사용자 탈퇴 실패";
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(text),),);
  }

  void _mypage() async {
    int userNumber = widget.userInfo_plant!.userNumber;
    String id = widget.userInfo_plant!.id;
    String password = _passwordController.text;
    String name = _nameController.text;
    String phoneNumber = _phoneNumberController.text;
    String plantName = _plantNameController.text;

    // 모두 입력했는지 확인
    if (id.isEmpty || password.isEmpty || name.isEmpty || phoneNumber.isEmpty || plantName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('수정할 내용을 입력하세요')),
      );
      return;
    }

    // 로그인 시도
    String? editResult = await dbService.mypage(UserInfo_plant(userNumber : userNumber, id: id, password: password, userName: name, phoneNumber: phoneNumber, plantName: plantName, plantType: plantType));

    if (editResult != null) {
      // 마이페이지 수정 성공 시 Home 화면으로 이동
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Home(userNumber: userNumber, plantName: plantName,)),
      );
    } else {
      // 로그인 실패 시 사용자에게 알림
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('마이페이지 수정 실패')),
      );
    }
  }

  String _validatePasswordLogic(String value){
    if (value == null || value.isEmpty) {
      return '비밀번호를 입력해주세요.';
    }else if(value.length < 8 || value.length >16){
      return "비밀번호를 8~16자리로 입력해주세요";
    } else if (!RegExp(
        r'^(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&#])[A-Za-z\d@$!%*?&#]*$').hasMatch(value)){
      return '비밀번호는 소문자, 숫자, 특수문자를 모두 포함해야합니다';
    } else
      return "";
  }

  void _validatePassword(String value){
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

  void _validateUserName(String value){
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

  void _validatePhoneNumber(String value){
    setState(() {
      validPhoneNumber = _validatePhoneNumberLogic(value);
    });
  }

  String _validatePlantNameLogic(String value) {
    if (value == null || value.isEmpty) {
      return '식물이름을 입력해주세요.';
    }
    return "";
  }

  void _validatePlantName(String value){
    setState(() {
      validPlantName = _validatePlantNameLogic(value);
    });
  }

  @override
  void initState(){
    super.initState();
    _idController = TextEditingController(text:widget.userInfo_plant!.id);
    _passwordController = TextEditingController(text:widget.userInfo_plant!.password);
    _nameController = TextEditingController(text:widget.userInfo_plant!.userName);
    _phoneNumberController = TextEditingController(text:widget.userInfo_plant!.phoneNumber);
    _plantNameController = TextEditingController(text : widget.userInfo_plant!.plantName);
    selectedDropdown = widget.userInfo_plant!.plantType;
    plantType = widget.userInfo_plant!.plantType;
  }

  @override
  void dispose() {
    // 위젯이 dispose될 때 TextEditingController를 해제합니다.
    _idController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _phoneNumberController.dispose();
    _plantNameController.dispose();
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
            child: Column(children: [
              SizedBox(
                  height: screenHeight * 0.15,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Image.asset(
                        'assets/images/logo.png',
                        height: screenHeight * 0.1,
                      ),
                      const Text('회원정보 수정',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF56280F))),
                    ],
                  )
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
                      border:
                      Border.all(color: const Color(0xFF81AE17), width: 2),
                    ),
                    padding: const EdgeInsets.only(bottom: 10),
                    child: TextField(
                      controller: _idController,
                      enabled: false,
                      style: TextStyle(fontSize: 13),
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(screenHeight * 0.01),
                        child: const Text(
                          '비밀번호',
                          style: TextStyle(fontSize: 11),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical : screenHeight * 0.01),
                        child: Text(
                          validPassword,
                          style: TextStyle(fontSize: 11, color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border:
                      Border.all(color: const Color(0xFF81AE17), width: 2),
                    ),
                    padding: const EdgeInsets.only(bottom: 10),
                    child: TextField(
                      controller: _passwordController,
                      obscureText: true,
                      onChanged: _validatePassword,
                      style: TextStyle(fontSize: 13),
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(screenHeight * 0.01),
                        child: const Text(
                          '이름',
                          style: TextStyle(fontSize: 11),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical : screenHeight * 0.01),
                        child: Text(
                          validName,
                          style: TextStyle(fontSize: 11, color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border:
                      Border.all(color: const Color(0xFF81AE17), width: 2),
                    ),
                    padding: const EdgeInsets.only(bottom: 10),
                    child: TextField(
                      controller: _nameController,
                      onChanged: _validateUserName,
                      style: TextStyle(fontSize: 13),
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(screenHeight * 0.01),
                        child: const Text(
                          '전화번호',
                          style: TextStyle(fontSize: 11),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical : screenHeight * 0.01),
                        child: Text(
                          validPhoneNumber,
                          style: TextStyle(fontSize: 11, color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border:
                      Border.all(color: const Color(0xFF81AE17), width: 2),
                    ),
                    padding: const EdgeInsets.only(bottom: 10),
                    child: TextField(
                      controller: _phoneNumberController,
                      onChanged: _validatePhoneNumber,
                      style: TextStyle(fontSize: 13),
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          border: InputBorder.none),
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
                      '식물 종',
                      style: TextStyle(fontSize: 11),
                    ),
                  ),
                  DropdownButton2<String>(
                    style:
                    const TextStyle(fontSize: 13, color: Color(0xFF515151)),
                    hint: const Text('식물 종 선택'),
                    isExpanded: true,
                    underline: Container(),
                    value: selectedDropdown,
                    items: dropdownList.map((String item) {
                      return DropdownMenuItem<String>(
                        value: item,
                        child: Text(item),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        selectedDropdown = value as String;
                      });
                      plantType = value! ;
                    },
                    buttonStyleData: ButtonStyleData(
                      height: 50,
                      decoration: BoxDecoration(
                          color: const Color(0xfff2f2f2),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: const Color(0xff81ae17), width: 2)),
                    ),
                    dropdownStyleData: DropdownStyleData(
                        maxHeight: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        )),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(screenHeight * 0.01),
                        child: const Text(
                          '식물이름',
                          style: TextStyle(fontSize: 11),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical : screenHeight * 0.01),
                        child: Text(
                          validPlantName,
                          style: TextStyle(fontSize: 11, color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border:
                      Border.all(color: const Color(0xFF81AE17), width: 2),
                    ),
                    padding: const EdgeInsets.only(bottom: 10),
                    child: TextField(
                      controller: _plantNameController,
                      onChanged: _validatePlantName,
                      style: TextStyle(fontSize: 13),
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          border: InputBorder.none),
                    ),
                  ),
                ],
              ),
            ]),
          ),
        ),
      ),
        bottomNavigationBar: Container(
            color: const Color(0xfff2f2f2),
            padding: EdgeInsets.only(bottom : screenHeight * 0.02,left : screenHeight * 0.02, right : screenHeight * 0.02),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              BottomAppBar(
                elevation: 0,
                color: const Color(0xFFF2F2F2),
                child : ElevatedButton(
                  onPressed: () {
                    _mypage();
                  }, // 수정하기
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(const Color(0x8081AE17)), // 로그인 버튼의 색상
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0), // 버튼 테두리의 둥글기 정도 설정
                      ),
                    ),
                    fixedSize: MaterialStateProperty.all<ui.Size>(const ui.Size.fromHeight(60)), // 높이 설정
                  ),
                  child: const Text(
                    '수정하기',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFFF2F2F2)), // 로그인 버튼의 텍스트 색상
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
                      style: TextStyle(fontSize: 14, color: Color(0xFF515151)),
                    ),
                  ),
                  Container(
                    height: 20,
                    width: 1,
                    color: const Color(0xffc0c0c0),
                  ),
                  TextButton(
                    onPressed: () {
                      _deleteUser(widget.userInfo_plant!.id);
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Log_in()));
                    },
                    child: const Text(
                      '탈퇴하기',
                      style: TextStyle(fontSize: 14, color: Color(0xFF515151)
                      ),
                    ),
                  ),
                ],
              )
            ]
          ),
        )
    );
  }
}
