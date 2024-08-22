import 'package:flutter/material.dart';
import 'package:mypetplant/Home.dart';
import 'package:mypetplant/user.dart';
import 'package:mypetplant/user_service.dart';
import 'package:mypetplant/widget.dart';

String text="";

class Plant_status extends StatefulWidget {
  final String? plantname; // 식물 이름
  final int? plantnumber; // 식물번호
  final int? days; // 재배일
  final String? planttype; //식물종류
  final int? optMoisture;
  final int? highTemp;
  final int? lowTemp;
  const Plant_status({super.key, this.planttype, this.plantname, this.plantnumber, this.days, this.optMoisture, this.lowTemp, this.highTemp});

  @override
  _Plant_statusState createState() => _Plant_statusState();
}

class _Plant_statusState extends State<Plant_status> {
  DBService dbService = DBService(); // DBService 인스턴스 생성
  TextEditingController _plantNameController = TextEditingController();
  String validPlantName = "";

  @override
  void initState() {
    super.initState();
    _plantNameController =
        TextEditingController(text: widget.plantname);
  }

  _deletePlant() async{
    String? deleteplant = await deletePlant(widget.plantnumber!);
    if (deleteplant != null || deleteplant != "") {
      text = "식물 삭제가 완료되었습니다";
    } else {
      text = "식물 삭제 실패";
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
      ),
    );
    List<HomeInfo>? homeInfo = await dbService.home();
    if (homeInfo != null)
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) =>
            Home(homeinfo: homeInfo, userNumber: homeInfo[0].userNumber)),
      );
  }

  _changePlantName() async{
    String? edit = await changePlantName(userPlantName(plantNumber : widget.plantnumber!, plantName: _plantNameController.text));
    if (edit != null || edit != "") {
      text = "식물 이름이 수정되었습니다";
    } else {
      text = "식물 이름 수정 실패";
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
      ),
    );
    List<HomeInfo>? homeInfo = await dbService.home();
    if (homeInfo != null)
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) =>
            Home(homeinfo: homeInfo, userNumber: homeInfo[0].userNumber)),
      );
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
      backgroundColor: const Color(0xffb3c458),
      body: Padding(
        padding: EdgeInsets.all(screenHeight * 0.04),
        child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // 식물 삭제 버튼
                  ElevatedButton(
                    onPressed: () {
                      _deletePlant();
                    },
                    child: Text('식물삭제'),
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
          // 식물이름
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
              child :
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                titleInputBox(title: "식물이름", screenHeight: screenHeight),
                plantInfoEditBox(hint: '식물이름을 입력해주세요', controller: _plantNameController, function: _validatePlantName,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        _changePlantName();
                      },
                      child: Text('이름 수정'),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: const Color(0xffF2F2F2),
                        backgroundColor: const Color.fromARGB(206, 59, 82, 5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        elevation: 0.0,
                        minimumSize: Size(70, 30),
                      ),
                    ),
                  ],
                ),
                titleInputBox(title: "식물종", screenHeight: screenHeight),
                plantInfoBox(text: widget.planttype!),
                titleInputBox(title: "재배일", screenHeight: screenHeight),
                plantInfoBox(text: "D+"+widget.days.toString()),
                titleInputBox(title: "목표환경", screenHeight: screenHeight),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  height: 250,
                  width: 300,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border:
                          Border.all(color: const Color(0xFF81AE17), width: 2),
                      color: Color.fromARGB(146, 255, 255, 255)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children : [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children : [Image.asset('assets/images/humi.png',
                                  height: screenHeight * 0.05),
                              Text('습도'),]),
                            Column(
                              children : [Image.asset('assets/images/temp.png',
                                  height: screenHeight * 0.05),
                              Text('온도'),]),
                            Column(
                              children : [Image.asset('assets/images/soil.png',
                                  height: screenHeight * 0.05),
                              Text('토양습도'),]),
                          ],
                        ),
                        Container(
                             height: 20,
                             width: 20,
                           ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              widget.optMoisture.toString()+'%',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              widget.lowTemp.toString()+'°C-'+widget.highTemp.toString()+'°C',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              widget.optMoisture.toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        )
                      ]
                    )



                    // Column(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     Row(
                    //       mainAxisAlignment: MainAxisAlignment.center,
                    //       children: [
                    //         Column(
                    //           children: [
                    //             Image.asset('assets/images/humi.png',
                    //                 height: screenHeight * 0.05),
                    //             Text('습도'),
                    //           ],
                    //         ),
                    //         Container(width: 50,),
                    //         Text(
                    //           widget.optMoisture.toString()+'%',
                    //           style: TextStyle(
                    //             fontWeight: FontWeight.bold,
                    //             fontSize: 25,
                    //             color: Colors.black,
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //     Container(
                    //       height: 5,
                    //       width: 1,
                    //       color: Color.fromARGB(146, 255, 255, 255),
                    //     ),
                    //     Row(
                    //       mainAxisAlignment: MainAxisAlignment.center,
                    //       children: [
                    //         Column(
                    //           children: [
                    //             Image.asset('assets/images/temp.png',
                    //                 height: screenHeight * 0.05),
                    //             Text('온도'),
                    //           ],
                    //         ),
                    //         Container(width: 50,),
                    //         Text(
                    //           widget.lowTemp.toString()+'°C-'+widget.highTemp.toString()+'°C',
                    //           style: TextStyle(
                    //             fontWeight: FontWeight.bold,
                    //             fontSize: 25,
                    //             color: Colors.black,
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //     Row(
                    //       mainAxisAlignment: MainAxisAlignment.center,
                    //       children: [
                    //         Column(
                    //           children: [
                    //             Image.asset('assets/images/soil.png',
                    //                 height: screenHeight * 0.05),
                    //             Text('토양습도'),
                    //           ],
                    //         ),
                    //         Container(width: 50,),
                    //
                    //         Text(
                    //           widget.optMoisture.toString(),
                    //           style: TextStyle(
                    //             fontWeight: FontWeight.bold,
                    //             fontSize: 25,
                    //             color: Colors.black,
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //     // Row(
                    //     //   mainAxisAlignment: MainAxisAlignment.end,
                    //     //   children: [
                    //     //     IconButton(
                    //     //       onPressed: () {
                    //     //         print('새로고침');
                    //     //       }, //새로고침
                    //     //       icon: Container(
                    //     //         width: 20,
                    //     //         height: 20,
                    //     //         child: Image.asset('assets/images/reload.png',
                    //     //             width: 20, height: 20),
                    //     //       ),
                    //     //     ),
                    //     //   ],
                    //     // )
                    //   ],
                    // ),
                  ),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
