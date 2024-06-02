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
      morning: count[0],
      lunch: count[1],
      dinner: count[2],
      night: count[3],
    );
    myBarData.initializeBarData();

    List max_rangeY = count;
    List min_rangeY = count;

    double _maxY = 250;

    double _minY = 10;

    return BarChart(BarChartData(
      maxY: _maxY,
      minY: _minY,
      gridData: FlGridData(show: false),
      borderData: FlBorderData(show: true),
      titlesData: FlTitlesData(
          show: true,
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          leftTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: true, interval: 10)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                  showTitles: true, getTitlesWidget: getBottomTitles))),
      barGroups: myBarData.barData
          .map((data) => BarChartGroupData(x: data.x, barRods: [
        BarChartRodData(
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
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = Text("MORNING");
        break;
      case 1:
        text = Text("LUNCH");
        break;
      case 2:
        text = Text("DINNER");
        break;
      case 3:
        text = Text("NIGHT");
        break;
      default:
        text = Text(" ");
        break;
    }
    return SideTitleWidget(axisSide: meta.axisSide, child: text);
  }
}