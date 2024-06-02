import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/rendering.dart';

class IndividualBar {
  final int x;
  final double y;

  IndividualBar({
    required this.x,
    required this.y,
  });
}

class BarData {
  final double morning;
  final double lunch;
  final double dinner;
  final double night;

  BarData({
    required this.morning,
    required this.lunch,
    required this.dinner,
    required this.night,
  });

  List<IndividualBar> barData = [];
  void initializeBarData() {
    barData = [
      IndividualBar(x: 0, y: morning),
      IndividualBar(x: 1, y: lunch),
      IndividualBar(x: 2, y: dinner),
      IndividualBar(x: 3, y: night),
    ];
  }
}

class MyBarGraph extends StatelessWidget {
  final List count;
  const MyBarGraph({super.key, required this.count});

  @override
  Widget build(BuildContext context) {
    BarData myBarData = BarData(
      //각 x좌표에 데이터 할당
      morning: count[0],
      lunch: count[1],
      dinner: count[2],
      night: count[3],
    );
    myBarData.initializeBarData();

    List max_rangeY = count;
    List min_rangeY = count;

    double _maxY = 35; //y축 최대값 지정

    double _minY = 10; // y축 최소값 지정

    return BarChart(BarChartData(
      maxY: _maxY,
      minY: _minY,
      gridData: FlGridData(show: false),
      borderData: FlBorderData(show: true),
      titlesData: FlTitlesData(
          show: true,
          topTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
              drawBehindEverything: true),
          leftTitles: AxisTitles(
              //좌측 y축 레이블
              sideTitles: SideTitles(
                  showTitles: true, getTitlesWidget: leftTitleWidgets)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
              //하단 x축 레이블
              sideTitles: SideTitles(
                  showTitles: true, getTitlesWidget: getBottomTitles))),
      backgroundColor: Color.fromRGBO(237, 246, 184, 1), // 그래프 배경 색
      barGroups: myBarData.barData
          .map((data) => BarChartGroupData(x: data.x, barRods: [
                BarChartRodData(
                  //차트 바 스타일
                  toY: data.y,
                  color: const Color(0xFF81AE17),
                  width: 25,
                  borderRadius: BorderRadius.circular(4),
                ),
              ]))
          .toList(),
    ));
  }

  Widget getBottomTitles(double value, TitleMeta meta) {
    // 하단 x축 레이블 설정
    String text;
    switch (value.toInt()) {
      case 0:
        text = "MORNING";
        break;
      case 1:
        text = "LUNCH";
        break;
      case 2:
        text = "DINNER";
        break;
      case 3:
        text = "NIGHT";
        break;
      default:
        text = " ";
        break;
    }

    const style = TextStyle(fontSize: 12, fontWeight: FontWeight.bold);

    return SideTitleWidget(
        axisSide: meta.axisSide,
        child: Text(
          text,
          style: style,
        ));
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    //좌측 y축 레이블 설정
    const style = TextStyle(fontSize: 8);
    int _value = value.ceil();
    String text = _value.toString();
    text = text;

    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 2, 6, 2),
      child: Container(
        child: Text(text, style: style, textAlign: TextAlign.center),
      ),
    );
  }
}
