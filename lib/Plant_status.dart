import 'package:flutter/material.dart';
import 'package:mypetplant/user_service.dart';
import 'package:mypetplant/widget.dart';

class Plant_status extends StatefulWidget {
  const Plant_status({super.key});

  @override
  _Plant_statusState createState() => _Plant_statusState();
}

class _Plant_statusState extends State<Plant_status> {
  final String plantname = '토메이토'; // 식물 이름
  final String plantnumber = '바질'; // 식물 종
  final String days = 'D+30'; // 재배일
  final String humi = '50%';
  final String temp = '28°C';
  final String soil = '60%';

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color(0xffb3c458),
      body: Padding(
        padding: EdgeInsets.all(screenHeight * 0.04),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // 식물 삭제 버튼
              ElevatedButton(
                onPressed: () {
                  print('버튼 눌림');
                },
                child: Text('식물 삭제'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: const Color(0xffF2F2F2),
                  backgroundColor: const Color.fromARGB(206, 59, 82, 5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 0.0,
                ),
              ),
            ],
          ),
          // 상단 아이콘
          Image.asset('assets/images/plantLogo.png',
              height: screenHeight * 0.1),
          Container(
            height: 20,
            width: 1,
            color: const Color(0xffb3c458),
          ),
          // 식물이름
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              titleInputBox(title: "식물이름", screenHeight: screenHeight),
              plantInfoBox(text: plantname),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      print('버튼 눌림');
                    },
                    child: Text('이름 수정'),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: const Color(0xffF2F2F2),
                      backgroundColor: const Color.fromARGB(206, 59, 82, 5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      elevation: 0.0,
                      minimumSize: Size(70, 20),
                    ),
                  ),
                ],
              ),
            ],
          ),
          // 식물종
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              titleInputBox(title: "식물종", screenHeight: screenHeight),
              plantInfoBox(text: plantnumber)
            ],
          ),
          Container(
            height: 20,
            width: 1,
            color: const Color(0xffb3c458),
          ),
          //재배일
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              titleInputBox(title: "재배일", screenHeight: screenHeight),
              plantInfoBox(text: days)
            ],
          ),
          Container(
            height: 20,
            width: 1,
            color: const Color(0xffb3c458),
          ),
          // 화단 상태
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              titleInputBox(title: '화단 상태', screenHeight: screenHeight),
              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                height: 250,
                width: 1000,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border:
                        Border.all(color: const Color(0xFF81AE17), width: 2),
                    color: Color.fromARGB(146, 255, 255, 255)),
                child: Center(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Image.asset('assets/images/humi.png',
                                  height: screenHeight * 0.05),
                              Text('습도'),
                            ],
                          ),
                          Text(
                            humi,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: 5,
                        width: 1,
                        color: Color.fromARGB(146, 255, 255, 255),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Image.asset('assets/images/temp.png',
                                  height: screenHeight * 0.05),
                              Text('온도'),
                            ],
                          ),
                          Text(
                            temp,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Image.asset('assets/images/soil.png',
                                  height: screenHeight * 0.05),
                              Text('토양습도'),
                            ],
                          ),
                          Text(
                            soil,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed: () {
                              print('새로고침');
                            }, //새로고침
                            icon: Container(
                              width: 20,
                              height: 20,
                              child: Image.asset('assets/images/reload.png',
                                  width: 20, height: 20),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
