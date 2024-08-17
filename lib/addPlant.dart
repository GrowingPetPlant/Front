import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:mypetplant/addPlantInHome.dart';
import 'package:mypetplant/calender.dart';
import 'package:mypetplant/mypage.dart';
import 'package:mypetplant/user.dart';
import 'package:mypetplant/user_service.dart';
import 'package:mypetplant/status.dart';
import 'package:mypetplant/status_service.dart';
import 'package:mypetplant/addPlant.dart';

//백그라운드 -> 포그라운드 : resume
class addPlant extends StatefulWidget {

  const addPlant({super.key});

  @override
  addplant createState() => addplant();
}

class addplant extends State<addPlant> with WidgetsBindingObserver{
  String _backgroundImage = 'assets/images/home-day.png'; //기본 이미지
  Color _appBarColor = Color(0xff63dafe); //기본 appbar 색상
  Timer? _timer;

  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this); // 옵저버 추가
    _updateBackgroundImage(); //앱 시작 시 배경 이미지 업데이트
    _setNextUpdate();
  }

  @override
  void dispose() {
    _timer?.cancel(); //타이머 해제
    WidgetsBinding.instance.removeObserver(this); // 옵저버 제거
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      // 앱이 포그라운드로 돌아왔을 때 실행할 작업
      _updateBackgroundImage(); //배경이미지 업데이트
      _setNextUpdate(); //다음 업데이트 설정
    }
  }

  void _updateBackgroundImage() {
    DateTime now = DateTime.now();
    // DateTime now = DateTime(2024,6,4,10,0,0);
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

  void _moveToAddPlantPage(){
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              addPlantInHome()
    )
    );
  }
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(0),
            child: AppBar(backgroundColor: _appBarColor),
        ),

        body: Stack(children: <Widget>[
          // 배경이미지
          Container(
            decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(_backgroundImage),
              fit: BoxFit.cover))),
          Container(
            margin: EdgeInsets.symmetric(vertical: 50, horizontal: 20),
            decoration: BoxDecoration(
                color: Color(0x35ffffff),
                backgroundBlendMode: BlendMode.srcOver,
                borderRadius: BorderRadius.all(Radius.circular(20))
            ),
          ),
          Padding(
            padding: EdgeInsets.all(screenHeight * 0.04),
            child: Center(
              child: Container(
                child : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '식물추가하기',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF56280F),
                      ),
                  ),
                  IconButton(
                    onPressed: _moveToAddPlantPage,
                    icon : Container(
                      padding: EdgeInsets.all(20),
                      child : Image.asset(
                        'assets/images/plus.png',
                        width: 100,
                        height: 100,
                      ),
                    ),
                  )
                  
                ],
              )
            ),
          ),
      ),
    ]
    )
    );
  }
}
