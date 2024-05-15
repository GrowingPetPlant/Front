
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

import 'package:mypetplant/Find_id.dart';
import 'package:mypetplant/Find_pw.dart';
import 'package:mypetplant/Sign_in.dart';
import 'package:mypetplant/user.dart';
import 'package:mypetplant/user_service.dart';
import 'package:mypetplant/home.dart';

String text="";

List<String> dropdownList = ['토마토', '바질', '수박'];
String? selectedDropdown;

class My_page extends StatefulWidget {
  const My_page({super.key});

  @override
  State<My_page> createState() => _My_page_view();
}

class _My_page_view extends State<My_page> {


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
                  )),
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
                    child: const TextField(style: TextStyle(fontSize: 13),
                      decoration: InputDecoration(
                          hintText: '',
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
                      '비밀번호',
                      style: TextStyle(fontSize: 11),
                    ),
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
                    child: const TextField(
                      obscureText: true,
                      style: TextStyle(fontSize: 13),
                      decoration: InputDecoration(
                          hintText: '',
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
                      '이름',
                      style: TextStyle(fontSize: 11),
                    ),
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
                    child: const TextField(
                      style: TextStyle(fontSize: 13),
                      decoration: InputDecoration(
                          hintText: '해삐',
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
                      '전화번호',
                      style: TextStyle(fontSize: 11),
                    ),
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
                    child: const TextField(
                      style: TextStyle(fontSize: 13),
                      decoration: InputDecoration(
                          hintText: '12345678',
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
                        selectedDropdown = value;
                      });
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
                  Padding(
                    padding: EdgeInsets.all(screenHeight * 0.01),
                    child: const Text(
                      '식물이름',
                      style: TextStyle(fontSize: 11),
                    ),
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
                    child: const TextField(
                      style: TextStyle(fontSize: 13),
                      decoration: InputDecoration(
                          hintText: '바질이',
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
                  onPressed: () {}, // 수정하기
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(const Color(0x8081AE17)), // 로그인 버튼의 색상
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0), // 버튼 테두리의 둥글기 정도 설정
                      ),
                    ),
                    fixedSize: MaterialStateProperty.all<Size>(const Size.fromHeight(60)), // 높이 설정
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
                    onPressed: () {},
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
                    onPressed: () {},
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
