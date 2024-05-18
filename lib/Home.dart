import 'dart:ffi';
import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mypetplant/calender.dart';
import 'package:mypetplant/mypage.dart';
import 'package:mypetplant/user.dart';
import 'package:mypetplant/user_service.dart';


class Home extends StatefulWidget {
  final String? id;

  const Home({super.key, this.id});

  @override
  home createState() => home();
}

class home extends State<Home>{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Home',
        home: Scaffold(
            appBar: PreferredSize(
              preferredSize: const ui.Size.fromHeight(0),
              child: AppBar(backgroundColor: const Color(0xff63dafe)),
            ),
            body: Stack(
                children: <Widget>[

                  // 배경이미지
                  Container(
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/home-day.png'),
                              fit: BoxFit.cover)),

                      // 닉네임
                      child: Align(
                        alignment: const Alignment(0, 0.4),
                        child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.white, width: 5),
                                borderRadius: const BorderRadius.all(Radius.circular(15)),
                                color: Colors.black45),
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => calender(id: '${widget.id}',)),
                                );
                              },
                              child : Text(
                                '토마토',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25,
                                  color: Colors.white,
                                ),
                              ),
                            )
                        ),
                      )
                  ),


                  // 상태바
                  Container(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [

                          // 온도
                          SizedBox(
                              width: 250,
                              height: 50,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container( // 온도이미지
                                    width: 50,
                                    height: 50,
                                    decoration: const BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage('assets/images/temp.png'),
                                            fit: BoxFit.cover
                                        )
                                    ),
                                  ),
                                  Container(
                                      padding: const EdgeInsets.all(3),
                                      child: Align(
                                        child: Stack(
                                          children: [
                                            // 흰색 테두리 효과를 위한 텍스트
                                            Text(
                                              '20°C',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                                foreground: Paint()
                                                  ..style = PaintingStyle.stroke
                                                  ..strokeWidth = 3
                                                  ..color = Colors.white, // 흰색 텍스트 스트로크
                                                shadows: const [
                                                  Shadow(
                                                    blurRadius: 2,
                                                    color: Colors.white, // 흰색 테두리
                                                  ),
                                                ],
                                              ),
                                              textAlign: TextAlign.left,
                                            ),
                                            // 원래의 검정색 텍스트
                                            const Text(
                                              '20°C',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                                color: Colors.black, // 검정색 텍스트
                                              ),
                                              textAlign: TextAlign.left,
                                            ),
                                          ],
                                      ),
                                    ),
                                  ),
                                ],
                              )
                          ),

                          // 습도
                          SizedBox(
                              width: 250,
                              height: 50,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 50,
                                    height: 50,
                                    decoration: const BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage('assets/images/humi.png'),
                                            fit: BoxFit.cover
                                        )
                                    ),
                                  ),
                                  Container(
                                      padding: const EdgeInsets.all(3),
                                      child: Align(child: Stack(
                                        children: [
                                          // 흰색 테두리 효과를 위한 텍스트
                                          Text(
                                            '30%',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                              foreground: Paint()
                                                ..style = PaintingStyle.stroke
                                                ..strokeWidth = 3
                                                ..color = Colors.white, // 흰색 텍스트 스트로크
                                              shadows: const [
                                                Shadow(
                                                  blurRadius: 2,
                                                  color: Colors.white, // 흰색 테두리
                                                ),
                                              ],
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                          // 원래의 검정색 텍스트
                                          const Text(
                                            '30%',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                              color: Colors.black, // 검정색 텍스트
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                        ],
                                      ),
                                      )
                                  ),
                                ],
                              )
                          ),

                          // 비옥도
                          SizedBox(
                              width: 250,
                              height: 50,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 50,
                                    height: 50,
                                    decoration: const BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage('assets/images/soil.png'),
                                            fit: BoxFit.cover
                                        )
                                    ),
                                  ),
                                  Container(
                                      padding: const EdgeInsets.all(3),
                                      child: Align(child: Stack(
                                        children: [
                                          // 흰색 테두리 효과를 위한 텍스트
                                          Text(
                                            '50%',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                              foreground: Paint()
                                                ..style = PaintingStyle.stroke
                                                ..strokeWidth = 3
                                                ..color = Colors.white, // 흰색 텍스트 스트로크
                                              shadows: const [
                                                Shadow(
                                                  blurRadius: 2,
                                                  color: Colors.white, // 흰색 테두리
                                                ),
                                              ],
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                          // 원래의 검정색 텍스트
                                          const Text(
                                            '50%',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                              color: Colors.black, // 검정색 텍스트
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                        ],
                                      ),
                                      )
                                  ),
                                ],
                              )
                          ),

                          // D-day
                          SizedBox(
                              width: 250,
                              height: 50,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 50,
                                    height: 50,
                                    decoration: const BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage('assets/images/d-day.png'),
                                            fit: BoxFit.cover
                                        )
                                    ),
                                  ),
                                  Container(
                                      padding: const EdgeInsets.all(3),
                                      child: Align(child: Stack(
                                        children: [
                                          // 흰색 테두리 효과를 위한 텍스트
                                          Text(
                                            '30%',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                              foreground: Paint()
                                                ..style = PaintingStyle.stroke
                                                ..strokeWidth = 3
                                                ..color = Colors.white, // 흰색 텍스트 스트로크
                                              shadows: const [
                                                Shadow(
                                                  blurRadius: 2,
                                                  color: Colors.white, // 흰색 테두리
                                                ),
                                              ],
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                          // 원래의 검정색 텍스트
                                          const Text(
                                            '30%',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                              color: Colors.black, // 검정색 텍스트
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                        ],
                                      ),
                                      )
                                  ),
                                ],
                              )
                          ),

                        ],
                      )
                  ),

                  // 제어 dock
                  Container(
                      alignment: const Alignment(0, 0.9),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [

                          // 급수
                          IconButton(
                            onPressed : (){},
                            icon : Container(
                              width: 80,
                              height: 80,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.asset(
                                  'assets/images/water.png',
                                  width: 55,
                                  height: 55,
                                ),
                              ),
                            ),
                          ),



                          // 조명
                          IconButton(
                            onPressed : (){},
                            icon : Container(
                              width: 80,
                              height: 80,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.asset(
                                  'assets/images/lamp.png',
                                  width: 55,
                                  height: 55,
                                ),
                              ),
                            ),
                          ),

                          // 환풍
                          IconButton(
                            onPressed : (){},
                            icon : Container(
                              width: 80,
                              height: 80,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.asset(
                                  'assets/images/fan.png',
                                  width: 55,
                                  height: 55,
                                ),
                              ),
                            ),
                          ),

                          // 팁 확인
                          IconButton(
                            onPressed: () async {
                              ID id;
                              if(widget.id!=null)
                                id = ID(id: widget.id);
                              else
                                id = ID(id : "");
                              UserInfo? userInfo = await findUser(id);
                              if (userInfo!=null){
                                UserInfo_plant? userInfo_plant = await findUserPlant(userInfo);
                                if(userInfo_plant!=null) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            My_page(userInfo_plant: userInfo_plant)),
                                  );
                                }
                              }
                            },
                            icon : Container(
                              width: 80,
                              height: 80,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.asset(
                                  'assets/images/info.png',
                                  width: 55,
                                  height: 55,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                  )
                ]
            )
        )
    );
  }
}
