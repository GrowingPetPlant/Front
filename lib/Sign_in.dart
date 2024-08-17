import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:mypetplant/Log_in.dart';
import 'package:mypetplant/addPlant_home.dart';
import 'package:mypetplant/user_service.dart';
import 'package:mypetplant/widget.dart';
import 'user.dart';

class Sign_in extends StatefulWidget {
  const Sign_in({super.key});

  @override
  State<Sign_in> createState() => Sign_in_view();
}

class Sign_in_view extends State<Sign_in> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  String validId = "";
  String validPassword = "";
  String validName = "";
  String validPhoneNumber = "";

  DBService dbService = DBService(); // DBService 인스턴스 생성

   Future<bool> checkId(String id) async {
     try {
       var idValidity = await dbService.checkIdAvailability(id);
       return idValidity;
     } catch (e) {
       print(e);
       return true; // 네트워크 오류 등으로 인해 확인할 수 없는 경우는 중복으로 간주하지 않음
     }
   }

   Future<bool> checkName(String name) async {
     try {
       var nameValidity = await dbService.checkNameAvailability(name);
       return nameValidity;
     } catch (e) {
       print(e);
       return true; // 네트워크 오류 등으로 인해 확인할 수 없는 경우는 중복으로 간주하지 않음
     }
   }

  Future<void> _signUp() async {
    //모든 입력값이 유효한지 확인하고 유효하지 않은 경우 회원가입 처리 중지하기
    if(_idController.text=="" || _passwordController.text=="" || _userNameController.text=="" || _phoneNumberController.text=="")
      return;
    try {
      // 아이디 중복 여부 확인
      bool idValidity = await checkId(_idController.text.trim());
      bool nameValidity = await checkName(_userNameController.text.trim());
      if (!idValidity) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('아이디가 이미 존재합니다.'),
            backgroundColor: Colors.red,
          ),
        );
        return; // 아이디가 중복되면 회원가입 진행 중지
      }
      if (!nameValidity) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('사용자 닉네임이 이미 존재합니다.'),
            backgroundColor: Colors.red,
          ),
        );
        return; // 아이디가 중복되면 회원가입 진행 중지
      }
      // 아이디가 중복이 아니라면 회원가입 요청 진행
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>
            addPlant_home(
              id: _idController.text.trim(),
              password: _passwordController.text.trim(),
              phoneNumber: _phoneNumberController.text.trim(),
              name: _userNameController.text.trim(),
            )), // 식물추가 화면으로 이동
      );
    }
    catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('error'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  String _validateIdLogic(String value) {
    if (value == null || value.isEmpty) {
      return '아이디를 입력해주세요.';
    } else if (value.length < 3 || value.length > 10) {
      return '아이디를 3~10자리로 입력해주세요.';
    } else if (!RegExp(r'^(?=.*[a-z])[a-zA-Z0-9]*$').hasMatch(value)) {
      return '아이디는 영문자와 숫자로 입력해주세요.';
    } else {
      return "";
    }
  }

  void _validateId(String value) {
    setState(() {
      validId = _validateIdLogic(value);
    });
  }

  String _validatePasswordLogic(String value) {
    if (value == null || value.isEmpty) {
      return '비밀번호를 입력해주세요.';
    } else if (value.length < 8 || value.length > 16) {
      return '비밀번호를 8~16자리로 입력해주세요.';
    } else if (!RegExp(
            r'^(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&#])[A-Za-z\d@$!%*?&#]*$')
        .hasMatch(value)) {
      return '비밀번호는 소문자, 숫자, 특수문자를 모두 포함해야 합니다.';
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
      return '닉네임을 입력해주세요.';
    } else
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
    } else
      return "";
  }

  void _validatePhoneNumber(String value) {
    setState(() {
      validPhoneNumber = _validatePhoneNumberLogic(value);
    });
  }

  @override
  void dispose() {
    // 위젯이 dispose될 때 TextEditingController를 해제합니다.
    _idController.dispose();
    _passwordController.dispose();
    _userNameController.dispose();
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
          child: Column(
            children: [
              logoTitle(text: '회원가입', screenHeight: screenHeight),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      titleInputBox(title: '아이디', screenHeight: screenHeight),
                      warningText(text: validId, screenHeight: screenHeight)
                    ],
                  ),
                  inputBox(hint: '아이디를 입력해주세요', controller: _idController, function: _validateId,)
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
                  inputBox(hint: '비밀번호를 입력해주세요', controller: _passwordController, function: _validatePassword,)
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
                  inputBox(hint: '닉네임을 입력해주세요', controller: _userNameController, function: _validateUserName,)
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
                  inputBox(hint: '전화번호를 입력해주세요', controller: _phoneNumberController, function: _validatePhoneNumberLogic,)
                ],
              ),
            ],
          ),
        ),
      ),

      //로그인 버튼
      bottomNavigationBar: Container(
        color: const Color(0xfff2f2f2),
        margin: const EdgeInsets.only(bottom: 25),
        child: BottomAppBar(
          elevation: 0,
          color: const Color(0xFFF2F2F2),
          child: ElevatedButton(
            onPressed: _signUp, // 회원가입하기
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                  const Color(0x8081AE17)), // 로그인 버튼의 색상
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
              '다음',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Color(0xFFF2F2F2),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
