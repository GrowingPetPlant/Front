import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Home',
        home: Scaffold(
            appBar: PreferredSize(
              child: AppBar(backgroundColor: const Color(0xff63dafe)),
              preferredSize: Size.fromHeight(0),
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
                        alignment: Alignment(0, 0.4),
                        child: Container(
                            padding: EdgeInsets.all(13),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.white, width: 5),
                                borderRadius: BorderRadius.all(Radius.circular(15)),
                                color: Colors.black45),
                            child: Text(
                              '토마토',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                                color: Colors.white,
                              ),
                            )
                        ),
                      )
                  ),


                  // 상태바
                  Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [

                          // 온도
                          Container(
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
                                      padding: EdgeInsets.all(3),
                                      child: Align(
                                          child: Text(
                                            '20°C',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                            ),
                                            textAlign: TextAlign.left,
                                          )
                                      )
                                  ),
                                ],
                              )
                          ),

                          // 습도
                          Container(
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
                                      padding: EdgeInsets.all(3),
                                      child: Align(
                                          child: Text(
                                            '30%',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                            ),
                                            textAlign: TextAlign.left,
                                          )
                                      )
                                  ),
                                ],
                              )
                          ),

                          // 비옥도
                          Container(
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
                                      padding: EdgeInsets.all(3),
                                      child: Align(
                                          child: Text(
                                            '50%',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                            ),
                                            textAlign: TextAlign.left,
                                          )
                                      )
                                  ),
                                ],
                              )
                          ),

                          // D-day
                          Container(
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
                                      padding: EdgeInsets.all(3),
                                      child: Align(
                                          child: Text(
                                            '30%',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                            ),
                                            textAlign: TextAlign.left,
                                          )
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
                      alignment: Alignment(0, 0.9),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [

                          // 급수
                          Container(
                            width: 85,
                            height: 85,
                            decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                                image: DecorationImage(
                                    image: AssetImage('assets/images/water.png'),
                                    fit: BoxFit.cover
                                )
                            ),
                          ),

                          // 조명
                          Container(
                            width: 85,
                            height: 85,
                            decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                                image: DecorationImage(
                                    image: AssetImage('assets/images/lamp.png'),
                                    fit: BoxFit.cover
                                )
                            ),
                          ),

                          // 환풍
                          Container(
                            width: 85,
                            height: 85,
                            decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                                image: DecorationImage(
                                    image: AssetImage('assets/images/fan.png'),
                                    fit: BoxFit.cover
                                )
                            ),
                          ),

                          // 팁 확인
                          Container(
                            width: 85,
                            height: 85,
                            decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                                image: DecorationImage(
                                    image: AssetImage('assets/images/info.png'),
                                    fit: BoxFit.cover
                                )
                            ),
                          )

                        ],
                      )
                  )
                ]
            )
        )
    );
  }
}