import 'package:flutter/material.dart';
import './Log_in.dart';
import './Find_id.dart';
import './Find_pw.dart';
import './Sign_in.dart';
import './Home.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyPetPlant',
      home: Home(),
    );
  }
}