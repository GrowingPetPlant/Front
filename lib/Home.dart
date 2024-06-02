import 'dart:convert';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mypetplant/calender.dart';
import 'package:mypetplant/mypage.dart';
import 'package:mypetplant/user.dart';
import 'package:mypetplant/user_service.dart';

import 'package:mypetplant/status.dart';
import 'package:mypetplant/status_service.dart';

String? ifWatered;
String water = "";
String _light = "";
String _fan = "";

//백그라운드 -> 포그라운드 : resume
class Home extends StatefulWidget {
  final int? userNumber;
  final String? plantName;

  const Home({super.key, this.userNumber, this.plantName});

  @override
  home createState() => home();
}

class home extends State<Home> with WidgetsBindingObserver {
  String _backgroundImage = 'assets/images/home-day.png'; //기본 이미지
  Color _appBarColor = Color(0xff63dafe); //기본 appbar 색상
  Timer? _timer;
  DBService dbService = DBService(); // DBService 인스턴스 생성

  int? _temperature; //온도 저장할 변수
  int? _moisture; //습도 저장할 변수
  int? _humidity; //비옥도 저장할 변수
  int? _days; //자란 일수 저장할 변수

  List<DateTime>? wateringDates = [];

  StatusService statusService = StatusService();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this); // 옵저버 추가
    _updateBackgroundImage(); //앱 시작 시 배경 이미지 업데이트
    _setNextUpdate();
    _fetchTemperature(); //온도 데이터 가져오기
    _fetchMoisture(); //습도 데이터 가져오기
    _fetchHumi(); //비옥도 데이터 가져오기
    _fetchGrowingDays(); //자란 일수 데이터 가져오기
    _fetchLighting();
    _fetchFanning();
  }

  @override
  void dispose() {
    _timer?.cancel(); //타이머 해제
    WidgetsBinding.instance.removeObserver(this); // 옵저버 제거
    super.dispose();
  }

  // 앱 생명 주기 상태 변화 감지
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      // 앱이 포그라운드로 돌아왔을 때 실행할 작업
      _updateBackgroundImage(); //배경이미지 업데이트
      _setNextUpdate(); //다음 업데이트 설정
      _fetchTemperature(); //온도 데이터 가져오기
      _fetchMoisture(); //습도 데이터 가져오기
      _fetchHumi(); //비옥도 데이터 가져오기
      _fetchGrowingDays(); //자란 일수 데이터 가져오기
    }
  }

  void _updateBackgroundImage() {
    DateTime now = DateTime.now();
    // final now = DateTime(2024, 5, 20, 19);    //test용
    final isNight = now.hour >= 19 || now.hour < 6;
    final newBackgroundImage =
        isNight ? 'assets/images/home-night.png' : 'assets/images/home-day.png';
    final newAppBarColor = isNight ? Color(0xEA0F0488) : Color(0xff63dafe);

    setState(() {
      _backgroundImage = newBackgroundImage;
      _appBarColor = newAppBarColor;
    });
  }

  void _setNextUpdate() {
    DateTime now = DateTime.now();
    DateTime nextUpdate;

    if (now.hour >= 19) {
      nextUpdate = DateTime(now.year, now.month, now.day)
          .add(Duration(days: 1, hours: 6 - now.hour));
    } else if (now.hour < 6) {
      nextUpdate = DateTime(now.year, now.month, now.day, 6);
    } else {
      nextUpdate = DateTime(now.year, now.month, now.day, 19);
    }

    final duration = nextUpdate.difference(now);
    _timer = Timer(duration, () {
      _updateBackgroundImage();
      _setNextUpdate();
    });
  }

  void _putWater() async {
    UserPlant? userPlant =
        await findUserPlant(UserNumber(userNumber: widget.userNumber));
    List<DateTime>? wateringDate =
        await fetchWarteringDates(userPlant!.plantNumber);
    DateTime today =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    String iso8601String_today = today.toIso8601String();
    if (!wateringDate!.isEmpty) {
      ifWatered = await dbService.putwater(PostWateringReq(
          plantNumber: userPlant!.plantNumber,
          wateringDate: iso8601String_today));
    } else {
      ifWatered = "물을 주시겠습니까?";
    }
    waterDialog(
        context,
        PostWateringReq(
            plantNumber: userPlant!.plantNumber,
            wateringDate: iso8601String_today));
  }

  //온도
  void _fetchTemperature() async {
    if (widget.userNumber != null) {
      UserNumber userNumber = UserNumber(userNumber: widget.userNumber);
      UserPlant? userPlant = await findUserPlant(userNumber);

      if (userPlant != null) {
        StatusTemp status =
            await statusService.fetchRecentTemp(userPlant.plantNumber);
        setState(() {
          _temperature = status.temperature;
        });
      }
    }
  }

  //비옥도
  void _fetchMoisture() async {
    if (widget.userNumber != null) {
      UserNumber userNumber = UserNumber(userNumber: widget.userNumber);
      UserPlant? userPlant = await findUserPlant(userNumber);

      if (userPlant != null) {
        StatusMoisture status =
            await statusService.fetchRecentMoisture(userPlant.plantNumber);
        setState(() {
          _moisture = status.moisture;
        });
      }
    }
  }

  //대기 습도
  void _fetchHumi() async {
    if (widget.userNumber != null) {
      UserNumber userNumber = UserNumber(userNumber: widget.userNumber);
      UserPlant? userPlant = await findUserPlant(userNumber);

      if (userPlant != null) {
        StatusHumi status =
            await statusService.fetchRecentHumi(userPlant.plantNumber);
        setState(() {
          _humidity = status.humidity;
        });
      }
    }
  }

  // 자란 일수
  void _fetchGrowingDays() async {
    if (widget.userNumber != null) {
      UserNumber userNumber = UserNumber(userNumber: widget.userNumber);
      UserPlant? userPlant = await findUserPlant(userNumber);

      if (userPlant != null) {
        StatusDays status =
            await statusService.fetchGrowingDays(userPlant.plantNumber);
        setState(() {
          _days = status.days;
        });
      }
    }
  }

  void _fetchLighting() async {
    if (widget.userNumber != null) {
      UserNumber userNumber = UserNumber(userNumber: widget.userNumber);
      UserPlant? userPlant = await findUserPlant(userNumber);

      if (userPlant != null) {
        String light = await statusService.isLighted(userPlant.plantNumber);
        setState(() {
          _light = light;
        });
      }
    }
  }

  void _fetchFanning() async {
    if (widget.userNumber != null) {
      UserNumber userNumber = UserNumber(userNumber: widget.userNumber);
      UserPlant? userPlant = await findUserPlant(userNumber);

      if (userPlant != null) {
        String fan = await statusService.isFanned(userPlant.plantNumber);
        setState(() {
          _fan = fan;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Home',
        home: Scaffold(
            appBar: PreferredSize(
              preferredSize: const ui.Size.fromHeight(0),
              child: AppBar(backgroundColor: _appBarColor),
            ),
            body: Stack(children: <Widget>[
              // 배경이미지
              Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(_backgroundImage),
                          fit: BoxFit.cover)),

                  // 닉네임
                  child: Align(
                    alignment: const Alignment(0, 0.4),
                    child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 5),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15)),
                            color: Colors.black45),
                        child: TextButton(
                          onPressed: () async {
                            UserNumber userNumber;
                            if (widget.userNumber != null)
                              userNumber =
                                  UserNumber(userNumber: widget.userNumber);
                            else
                              userNumber = UserNumber(userNumber: null);
                            UserPlant? userplant =
                                await findUserPlant(userNumber);
                            wateringDates = await fetchWarteringDates(
                                userplant!.plantNumber);

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => calender(
                                        wateredDate: wateringDates,
                                      )),
                            );
                          },
                          child: Text(
                            widget.plantName!,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                              color: Colors.white,
                            ),
                          ),
                        )),
                  )),

              // 상태바
              Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      // 온도
                      SizedBox(
                          width: 280,
                          height: 50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                // 온도이미지
                                width: 50,
                                height: 50,
                                decoration: const BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/temp.png'),
                                        fit: BoxFit.cover)),
                              ),
                              Container(
                                padding: const EdgeInsets.all(3),
                                child: Align(
                                  child: Stack(
                                    children: [
                                      // 흰색 테두리 효과를 위한 텍스트
                                      Text(
                                        _temperature != null
                                            ? '$_temperature°C'
                                            : 'Loading...',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          foreground: Paint()
                                            ..style = PaintingStyle.stroke
                                            ..strokeWidth = 3
                                            ..color =
                                                Colors.white, // 흰색 텍스트 스트로크
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
                                      Text(
                                        _temperature != null
                                            ? '$_temperature°C'
                                            : 'Loading...',
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
                              IconButton(
                                onPressed: () {
                                  _fetchMoisture();
                                  _fetchHumi();
                                  _fetchMoisture();
                                  _fetchTemperature();
                                }, //새로고침
                                icon: Container(
                                  width: 20,
                                  height: 20,
                                  child: Image.asset('assets/images/reload.png',
                                      width: 20, height: 20),
                                ),
                              ),
                            ],
                          )),

                      // 대기 습도
                      SizedBox(
                          width: 280,
                          height: 50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                decoration: const BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/humi.png'),
                                        fit: BoxFit.cover)),
                              ),
                              Container(
                                  padding: const EdgeInsets.all(3),
                                  child: Align(
                                    child: Stack(
                                      children: [
                                        // 흰색 테두리 효과를 위한 텍스트
                                        Text(
                                          _humidity != null
                                              ? '$_humidity%'
                                              : 'Loading...',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            foreground: Paint()
                                              ..style = PaintingStyle.stroke
                                              ..strokeWidth = 3
                                              ..color =
                                                  Colors.white, // 흰색 텍스트 스트로크
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
                                        Text(
                                          _humidity != null
                                              ? '$_humidity%'
                                              : 'Loading...',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color: Colors.black, // 검정색 텍스트
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                      ],
                                    ),
                                  )),
                            ],
                          )),

                      // 토양 습도
                      SizedBox(
                          width: 280,
                          height: 50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                decoration: const BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/soil.png'),
                                        fit: BoxFit.cover)),
                              ),
                              Container(
                                  padding: const EdgeInsets.all(3),
                                  child: Align(
                                    child: Stack(
                                      children: [
                                        // 흰색 테두리 효과를 위한 텍스트
                                        Text(
                                          _moisture != null
                                              ? '$_moisture%'
                                              : 'Loading...',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            foreground: Paint()
                                              ..style = PaintingStyle.stroke
                                              ..strokeWidth = 3
                                              ..color =
                                                  Colors.white, // 흰색 텍스트 스트로크
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
                                        Text(
                                          _moisture != null
                                              ? '$_moisture%'
                                              : 'Loading...',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color: Colors.black, // 검정색 텍스트
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                      ],
                                    ),
                                  )),
                            ],
                          )),

                      // D-day (자란 기간)
                      SizedBox(
                          width: 280,
                          height: 50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                decoration: const BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/date.png'),
                                        fit: BoxFit.cover)),
                              ),
                              Container(
                                  padding: const EdgeInsets.all(3),
                                  child: Align(
                                    child: Stack(
                                      children: [
                                        // 흰색 테두리 효과를 위한 텍스트
                                        Text(
                                          _days != null
                                              ? 'D+$_days'
                                              : 'Loading...',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            foreground: Paint()
                                              ..style = PaintingStyle.stroke
                                              ..strokeWidth = 3
                                              ..color =
                                                  Colors.white, // 흰색 텍스트 스트로크
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
                                        Text(
                                          _days != null
                                              ? 'D+$_days'
                                              : 'Loading...',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color: Colors.black, // 검정색 텍스트
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                      ],
                                    ),
                                  )),
                            ],
                          )),
                    ],
                  )),

              // 제어 dock
              Container(
                  margin: EdgeInsets.all(10),
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          // 급수 text
                          Container(
                              width: 80,
                              height: 20,
                              child: Align(
                                child: Stack(
                                  children: [
                                    // 흰색 테두리 효과를 위한 텍스트
                                    Text(
                                      "OFF",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
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
                                      textAlign: TextAlign.center,
                                    ),
                                    // 원래의 검정색 텍스트
                                    Text(
                                      "OFF",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: Colors.black, // 검정색 텍스트
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              )),

                          Container(
                              // 조명 text
                              width: 80,
                              height: 20,
                              child: Align(
                                child: Stack(
                                  children: [
                                    // 흰색 테두리 효과를 위한 텍스트
                                    Text(
                                      _light,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
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
                                      textAlign: TextAlign.center,
                                    ),
                                    // 원래의 검정색 텍스트
                                    Text(
                                      _light,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: Colors.black, // 검정색 텍스트
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              )),

                          Container(
                              // 환풍 text
                              width: 80,
                              height: 20,
                              child: Align(
                                child: Stack(
                                  children: [
                                    // 흰색 테두리 효과를 위한 텍스트
                                    Text(
                                      _fan,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
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
                                      textAlign: TextAlign.center,
                                    ),
                                    // 원래의 검정색 텍스트
                                    Text(
                                      _fan,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: Colors.black, // 검정색 텍스트
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              )),

                          Container(
                            // 마이페이지 text
                            width: 80,
                            height: 20,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          // 급수
                          IconButton(
                            onPressed: () {
                              _putWater();
                            }, // 물주기
                            icon: Container(
                              width: 80,
                              height: 80,
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
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
                            onPressed: () async {
                              UserPlant? userplant = await findUserPlant(
                                  UserNumber(userNumber: widget!.userNumber));
                              String light = await statusService
                                  .lighting(userplant!.plantNumber);
                              setState(() {
                                _light = light;
                              });
                            },
                            icon: Container(
                              width: 80,
                              height: 80,
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
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
                            onPressed: () async {
                              UserPlant? userplant = await findUserPlant(
                                  UserNumber(userNumber: widget!.userNumber));
                              String fan = await statusService
                                  .fanning(userplant!.plantNumber);
                              setState(() {
                                _fan = fan;
                              });
                            },
                            icon: Container(
                              width: 80,
                              height: 80,
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
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

                          // 마이페이지
                          IconButton(
                            onPressed: () async {
                              UserNumber userNumber;
                              if (widget.userNumber != null)
                                userNumber =
                                    UserNumber(userNumber: widget.userNumber);
                              else
                                userNumber = UserNumber(userNumber: null);
                              UserInfo? userInfo = await findUser(userNumber);
                              UserPlant? userplant =
                                  await findUserPlant(userNumber);
                              if (userplant != null && userInfo != null) {
                                UserInfo_plant userinfo = UserInfo_plant(
                                    userNumber: widget.userNumber!,
                                    id: userInfo.id,
                                    password: userInfo.password,
                                    userName: userInfo.userName,
                                    phoneNumber: userInfo.phoneNumber,
                                    plantType: userplant.plantType,
                                    plantName: userplant.plantName);
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          My_page(userInfo_plant: userinfo)),
                                );
                              }
                            },
                            icon: Container(
                              width: 80,
                              height: 80,
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.asset(
                                  'assets/images/mypage.png',
                                  width: 55,
                                  height: 55,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ))
            ])));
  }
}

void waterDialog(context, PostWateringReq postWateringReq) {
  showDialog(
      context: context,
      builder: (context) {
        return Dialog(
            child: Container(
          padding: const EdgeInsets.fromLTRB(30, 30, 30, 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                ifWatered!,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Color(0xff515151)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: () async {
                        String? waterResult = await watering(postWateringReq);
                        print(waterResult);
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        "확인",
                        style:
                            TextStyle(fontSize: 16, color: Color(0xff81ae17)),
                      )),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        "취소",
                        style:
                            TextStyle(fontSize: 16, color: Color(0xff81ae17)),
                      )),
                ],
              )
            ],
          ),
        ));
      });
}
