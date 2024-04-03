import 'package:flutter/material.dart';

List<String> dropdownList = ['토마토', '바질', '수박'];
String? selectedDropdown;

class Sign_in extends StatefulWidget {
  const Sign_in({super.key});

  @override
  State<Sign_in> createState() => Sign_in_view();
}

class Sign_in_view extends State<Sign_in> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        //resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Center(
            child: Text("MyPlant"),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Column(
                children: [
                  Column(children: [
                    Image.asset(
                      //로고
                      'assets/images/logo.png',
                      width: 71,
                      height: 73,
                    ),
                    const Padding(
                      //타이틀
                      padding: EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: 59,
                        height: 19,
                        child: Text('회원가입'),
                      ),
                    ),
                  ]),
                  SizedBox(
                    // 아이디
                    width: 331,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            '아이디',
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                        Container(
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: const Color(0xFF81AE17), width: 2),
                          ),
                          child: const TextField(
                            style: TextStyle(fontSize: 10),
                            decoration: InputDecoration(
                                hintText: '아이디를 입력해주세요',
                                contentPadding:
                                EdgeInsets.fromLTRB(10, 0, 0, 10),
                                border: InputBorder.none),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    // 비밀번호
                    width: 331,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            '비밀번호',
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                        Container(
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: const Color(0xFF81AE17), width: 2),
                          ),
                          child: const TextField(
                            style: TextStyle(fontSize: 10),
                            decoration: InputDecoration(
                                hintText: '비밀번호를 설정하세요',
                                contentPadding:
                                EdgeInsets.fromLTRB(10, 0, 0, 10),
                                border: InputBorder.none),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    // 이름
                    width: 331,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            '이름',
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                        Container(
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: const Color(0xFF81AE17), width: 2),
                          ),
                          child: const TextField(
                            style: TextStyle(fontSize: 10),
                            decoration: InputDecoration(
                                hintText: '사용자 이름',
                                contentPadding:
                                EdgeInsets.fromLTRB(10, 0, 0, 10),
                                border: InputBorder.none),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    // 전화번호
                    width: 331,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            '전화번호',
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                        Container(
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: const Color(0xFF81AE17), width: 2),
                          ),
                          child: const TextField(
                            style: TextStyle(fontSize: 10),
                            decoration: InputDecoration(
                                hintText: '전화번호를 입력해주세요',
                                contentPadding:
                                EdgeInsets.fromLTRB(10, 0, 0, 10),
                                border: InputBorder.none),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    // 식물 종
                    width: 331,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            '식물 종',
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: const Color(0xFF81AE17), width: 2),
                          ),
                          child: SizedBox(
                            width: 331,
                            height: 40,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DropdownButton(
                                style: const TextStyle(fontSize: 10),
                                hint: const Text(
                                  '식물 종 선택',
                                  style: TextStyle(fontSize: 10),
                                ),
                                isExpanded: true,
                                underline: Container(),
                                value: selectedDropdown,
                                items: dropdownList.map((String item) {
                                  return DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(item),
                                  );
                                }).toList(),
                                onChanged: (dynamic value) {
                                  setState(() {
                                    selectedDropdown = value;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    // 식물이름
                    width: 331,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            '식물이름',
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                        Container(
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: const Color(0xFF81AE17), width: 2),
                          ),
                          child: const TextField(
                            style: TextStyle(fontSize: 10),
                            decoration: InputDecoration(
                                hintText: '식물이름을 지어주세요',
                                contentPadding:
                                EdgeInsets.fromLTRB(10, 0, 0, 10),
                                border: InputBorder.none),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    // 회원가입 버튼
                    padding: const EdgeInsets.all(10.0),
                    child: SizedBox(
                      width: 331,
                      height: 40,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              backgroundColor: const Color(0xFF81AE17)),
                          onPressed: () {},
                          child: const Text(
                            '회원가입',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          )),
                    ),
                  ),
                  /*const Text('비밀번호'),
                  const Text('이름'),
                  const Text('전화번호'),
                  const Text('식물 종'),
                  const Text('식물 이름'),*/
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
