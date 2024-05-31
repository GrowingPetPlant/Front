import 'dart:convert';
import 'package:http/http.dart' as http;

//String address = "http://localhost:8080";
String address = "http://172.30.1.82:8080";

class drawingGraph {
  //온도
  Future<GraphInfo> fetchGraphInfo(DateTime selectedDay) async {
    String iso8601String_selectedDay = selectedDay.toIso8601String().substring(0,10);
    final response = await http
        .get(Uri.parse('$address/graph/display?date=$iso8601String_selectedDay'));

    if (response.statusCode == 200) {
      if(response.body!=Null) //그래프정보불러오기 성공해서 DB에 값 있는 경우(오늘날짜 전 날짜는 없으면 모든 값 0으로 DB생성해서 return)
        return GraphInfo.fromJson(jsonDecode(response.body));
      else //그래프정보불러오기 성공했는데 DB에 값 없는 경우(오늘날짜 이후 날짜들은 null반환해서 DB생성 안하고 그래프 0으로 띄우기)
        return GraphInfo(humiDawn: 0, humiDay: 0, humiMorning: 0, humiNight: 0, moistureDawn: 0, moistureDay: 0, moistureMorning: 0, moistureNight: 0, tempDawn: 0, tempDay: 0, tempMorning: 0, tempNight: 0);
    } else { //그래프정보불러오기 실패
      throw Exception('그래프 정보 불러오기에 실패했습니다.');
    }
  }
}

class GraphInfo {
  final double tempDawn;
  final double tempMorning;
  final double tempDay;
  final double tempNight;
  final double moistureDawn;
  final double moistureMorning;
  final double moistureDay;
  final double moistureNight;
  final double humiDawn;
  final double humiMorning;
  final double humiDay;
  final double humiNight;

  GraphInfo({required this.humiDawn, required this.humiDay, required this.humiMorning,required this.humiNight, required this.moistureDawn,required this.moistureDay, required this.moistureMorning,required this.moistureNight, required this.tempDawn,required this.tempDay, required this.tempMorning,required this.tempNight});

  factory GraphInfo.fromJson(dynamic json) {
    return GraphInfo(
      tempDawn: json['tempDawn'] as double,
      tempDay: json['tempDay'] as double,
      tempMorning: json['tempMorning'] as double,
      tempNight: json['tempNight'] as double,
      moistureDawn: json['moistureDawn'] as double,
      moistureDay: json['moistureDay'] as double,
      moistureMorning: json['moistureMorning'] as double,
      moistureNight: json['moistureNight'] as double,
      humiDawn: json['humiDawn'] as double,
      humiDay: json['humiDay'] as double,
      humiMorning: json['humiMorning'] as double,
      humiNight: json['humiNight'] as double
    );
  }
}