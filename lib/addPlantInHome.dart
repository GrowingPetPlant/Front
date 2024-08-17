import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mypetplant/Log_in.dart';
import 'package:mypetplant/user.dart';
import 'package:mypetplant/user_service.dart';
import 'package:mypetplant/widget.dart';

List<String> dropdownList = ['토마토', '바질', '수박'];
String? selectedDropdown;

class addPlantInHome extends StatefulWidget {


  const addPlantInHome({super.key});

  @override
  State<addPlantInHome> createState() => AddPlantInHome();
}

class AddPlantInHome extends State<addPlantInHome> {
  final TextEditingController _plantNameController = TextEditingController();

  String validPlantName = "";

  DBService dbService = DBService(); // DBService 인스턴스 생성

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
  void _addPlant() async{
    bool? addPlant = await dbService.addPlant(
        AddPlant(
          plantType: selectedDropdown!,
          userPlantName: _plantNameController.text.trim()
        )
    );
    if(!addPlant!)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('중복된 식물 이름입니다.'),
          backgroundColor: Colors.red,
        ),
      );
    else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('식물 정보가 추가되었습니다.'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color(0XFFB9CA62),
      body: Padding(
          padding: EdgeInsets.all(screenHeight * 0.04),
          child: SingleChildScrollView(
              child:Column(
                  children: [
                    plantLogoTitle(text: '식물추가하기',screenHeight: screenHeight),
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
            onPressed: _addPlant, // 식물추가하기
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
              '식물추가하기',
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