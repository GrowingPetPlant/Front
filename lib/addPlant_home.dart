import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mypetplant/Log_in.dart';
import 'package:mypetplant/user.dart';
import 'package:mypetplant/user_service.dart';
import 'package:mypetplant/widget.dart';

List<String> dropdownList = ['토마토', '오이','바질', '고추', '상추'];
String? selectedDropdown;

class addPlant_home extends StatefulWidget {

  final String? id;
  final String? password;
  final String? name;
  final String? phoneNumber;

  const addPlant_home({super.key, this.id, this.password, this.name, this.phoneNumber});

  @override
  State<addPlant_home> createState() => AddPlant_home();
}

class AddPlant_home extends State<addPlant_home> {
  final TextEditingController _plantNameController = TextEditingController();

  String validPlantName = "";

  DBService dbService = DBService(); // DBService 인스턴스 생성

  Future<void> _signUp() async {
    //모든 입력값이 유효한지 확인하고 유효하지 않은 경우 회원가입 처리 중지하기
    try {

      bool isRegistered = await dbService.register(SignupRequest(
        id: widget.id!,
        password: widget.password!,
        userName: widget.name!,
        phoneNumber: widget.phoneNumber!,
        plantType: selectedDropdown!,
        userPlantName: _plantNameController.text.trim(),
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

  String _validatePlantNameLogic(String value) {
    if (value == null || value.isEmpty) {
      return '식물이름을 입력해주세요.';
    }
    return "";
  }

  void _validatePlantName(String value) {
    setState(() {
      validPlantName = _validatePlantNameLogic(value);
    });
  }

  @override
  void dispose() {
    // 위젯이 dispose될 때 TextEditingController를 해제합니다.
    _plantNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: const Color(0XFFB9CA62),
        body: Padding(
          padding: EdgeInsets.all(screenHeight * 0.04),
          child: SingleChildScrollView(
              child: Column(
                  children: [
                  plantLogoTitle(text: '식물추가하기', screenHeight: screenHeight),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                titleInputBox(title: '식물 종 선택', screenHeight: screenHeight),
                                warningText(text: "", screenHeight: screenHeight),
                              ],
                            ),
                            dropDownBox(
                              value: selectedDropdown,
                              onChanged: (String? value) {
                                setState(() {
                                  selectedDropdown = value;
                                });
                              },
                            ),
                          ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            titleInputBox(title: '식물이름', screenHeight: screenHeight),
                            warningText(
                              text: validPlantName, screenHeight: screenHeight),
                          ],
                        ),
                        inputBox(
                          hint: '식물 이름을 입력해주세요',
                          controller: _plantNameController,
                          function: _validatePlantName
                        ),
                      ],
                    ),
                ]
              )
          ),
        ),
      bottomNavigationBar: Container(
        color: const Color(0XFFB9CA62),
        margin: const EdgeInsets.only(bottom: 25),
        child: BottomAppBar(
          elevation: 0,
          color: const Color(0XFFB9CA62),
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