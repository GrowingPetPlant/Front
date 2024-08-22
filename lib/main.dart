import 'package:flutter/material.dart';
import 'package:mypetplant/Home.dart';
import 'package:mypetplant/Plant_status.dart';
import 'package:mypetplant/Sign_in.dart';
import 'package:mypetplant/calender.dart';
import './Log_in.dart';
import 'package:mypetplant/mypage.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  await initializeDateFormatting();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'MyPetPlant',
      home: Log_in(),
    );
  }
}
