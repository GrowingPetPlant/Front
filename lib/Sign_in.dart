import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:mypetplant/Log_in.dart';
import 'package:mypetplant/user_service.dart';
import 'user.dart';

List<String> dropdownList = ['토마토', '바질', '수박'];
String? selectedDropdown;

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
  final TextEditingController _plantNameController = TextEditingController();
  String validId = "";
  String validPassword = "";
  String validName = "";
  String validPhoneNumber = "";
  String validPlantName = "";

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

  Future<void> _signUp() async {
      //모든 입력값이 유효한지 확인하고 유효하지 않은 경우 회원가입 처리 중지하기
      try {
        // 아이디 중복 여부 확인
        bool idValidity = await checkId(_idController.text.trim());
        print(idValidity);
        if (!idValidity) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('아이디가 이미 존재합니다.'),
              backgroundColor: Colors.red,
            ),
          );
          return; // 아이디가 중복되면 회원가입 진행 중지
        }

        // 아이디가 중복이 아니라면 회원가입 요청 진행
        bool isRegistered = await dbService.register(SignupRequest(
          id: _idController.text.trim(),
          password: _passwordController.text.trim(),
          userName: _userNameController.text.trim(),
          phoneNumber: _phoneNumberController.text.trim(),
          plantType: selectedDropdown!,
          plantName: _plantNameController.text.trim(),
        ));
        if (isRegistered) {
          // 회원가입에 성공하면 로그인 화면으로 이동
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Log_in()), // 로그인 화면으로 이동
          );
          // 회원가입 성공 메시지 표시
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('회원가입에 성공했습니다.'),
              backgroundColor: Colors.green,
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('회원가입에 실패했습니다.'),
              backgroundColor: Colors.red,
            ),
          );
        }
      } catch (e) {
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
    } else
      return "";
  }

  void _validateId(String value){
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
    }else
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
    }else
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
    } else
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
  void dispose() {
    // 위젯이 dispose될 때 TextEditingController를 해제합니다.
    _idController.dispose();
    _passwordController.dispose();
    _userNameController.dispose();
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
                      const Text('회원가입',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF56280F))),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(screenHeight * 0.01),
                          child: const Text(
                            '아이디',
                            style: TextStyle(fontSize: 11),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical : screenHeight * 0.01),
                          child: Text(
                            validId,
                            style: TextStyle(fontSize: 11, color: Colors.red),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: const Color(0xFF81AE17), width: 2),
                      ),
                      padding: const EdgeInsets.only(bottom: 10),
                      child: TextField(
                        controller: _idController,
                        onChanged: _validateId,
                        style: TextStyle(fontSize: 13),
                        decoration: InputDecoration(
                          hintText: '아이디를 입력해주세요',
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
                        border: Border.all(
                            color: const Color(0xFF81AE17), width: 2),
                      ),
                      padding: const EdgeInsets.only(bottom: 10),
                      child: TextField(
                        controller: _passwordController,
                        obscureText: true,
                        onChanged: _validatePassword,
                        style: TextStyle(fontSize: 13),
                        decoration: InputDecoration(
                          hintText: '비밀번호를 입력해주세요',
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
                        border: Border.all(
                            color: const Color(0xFF81AE17), width: 2),
                      ),
                      padding: const EdgeInsets.only(bottom: 10),
                      child: TextField(
                        controller: _userNameController,
                        onChanged: _validateUserName,
                        style: TextStyle(fontSize: 13),
                        decoration: InputDecoration(
                          hintText: '사용자 이름',
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
                        border: Border.all(
                            color: const Color(0xFF81AE17), width: 2),
                      ),
                      padding: const EdgeInsets.only(bottom: 10),
                      child: TextFormField(
                        controller: _phoneNumberController,
                        onChanged: _validatePhoneNumber,
                        style: TextStyle(fontSize: 13),
                        decoration: InputDecoration(
                          hintText: '전화번호를 입력해주세요',
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
                    Padding(
                      padding: EdgeInsets.all(screenHeight * 0.01),
                      child: const Text(
                        '식물 종',
                        style: TextStyle(fontSize: 11),
                      ),
                    ),
                    DropdownButton2<String>(
                      style: const TextStyle(
                          fontSize: 13, color: Color(0xFF515151)),
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
                          selectedDropdown = value;
                        });
                      },
                      buttonStyleData: ButtonStyleData(
                        height: 50,
                        decoration: BoxDecoration(
                          color: const Color(0xfff2f2f2),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: const Color(0xff81ae17), width: 2),
                        ),
                      ),
                      dropdownStyleData: DropdownStyleData(
                        maxHeight: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
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
                        border: Border.all(
                            color: const Color(0xFF81AE17), width: 2),
                      ),
                      padding: const EdgeInsets.only(bottom: 10),
                      child: TextField(
                        controller: _plantNameController,
                        onChanged: _validatePlantName,
                        style: TextStyle(fontSize: 13),
                        decoration: InputDecoration(
                          hintText: '식물 이름을 지어주세요',
                          contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),

      //로그인 버튼
      bottomNavigationBar: Container(
        color: const Color(0xfff2f2f2),
        margin: const EdgeInsets.only(bottom: 60),
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
              '회원가입',
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
