import 'dart:convert';
import 'package:http/http.dart' as http;
import 'status.dart';

//String address = "http://localhost:8080";
String address = "http://10.10.92.96:8080";

class StatusService {
  //온도
  Future<StatusTemp> fetchRecentTemp(int plantNumber) async {
    final response = await http
        .get(Uri.parse('$address/status/temp?plantNumber=$plantNumber'));

    if (response.statusCode == 200) {
      return StatusTemp.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('온도 불러오기 실패했습니다.');
    }
  }

  //비옥도
  Future<StatusMoisture> fetchRecentMoisture(int plantNumber) async {
    final response = await http
        .get(Uri.parse('$address/status/moisture?plantNumber=$plantNumber'));

    if (response.statusCode == 200) {
      return StatusMoisture.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('습도 불러오기 실패했습니다.');
    }
  }

  //대기
  Future<StatusHumi> fetchRecentHumi(int plantNumber) async {
    final response = await http
        .get(Uri.parse('$address/status/humi?plantNumber=$plantNumber'));

    if (response.statusCode == 200) {
      return StatusHumi.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('비옥도 불러오기 실패했습니다');
    }
  }

  // 자란 일수
  Future<StatusDays> fetchGrowingDays(int plantNumber) async {
    final response = await http
        .get(Uri.parse('$address/status/days?plantNumber=$plantNumber'));

    if (response.statusCode == 200) {
      return StatusDays.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('자란 일수 불러오기 실패했습니다');
    }
  }

  //전구버튼 누르면 실행할거
  Future<String> lighting(int plantNumber) async{
    final response = await http.post(Uri.parse('$address/arduino/lighting?plantNumber=$plantNumber'));
    if(response.statusCode == 200) {
      if (jsonDecode(response.body))
        return "ON";
      else
        return "OFF";
    }
    else
      return "!";
  }

  //홈화면 넘어갈 때 실행할거
  Future<String> isLighted(int plantNumber) async{
    final response = await http.get(Uri.parse('$address/status/isLighted?plantNumber=$plantNumber'));
    if(response.statusCode==200) {
      if (jsonDecode(response.body)) {
        return "ON";
      }
      else {
        return "OFF";
      }
    }
    else
      return "!";
  }

  //팬 버튼 누르면 실행할거
  Future<String> fanning(int plantNumber) async{
    final response = await http.post(Uri.parse('$address/arduino/fanning?plantNumber=$plantNumber'));
    if(response.statusCode == 200) {
      if (jsonDecode(response.body))
        return "ON";
      else
        return "OFF";
    }
    else
      return "!";
  }

  //홈화면 넘어갈 때 실행할거
  Future<String> isFanned(int plantNumber) async{
    final response = await http.get(Uri.parse('$address/status/isFanned?plantNumber=$plantNumber'));
    if(response.statusCode==200) {
      if (jsonDecode(response.body)) {
        return "ON";
      }
      else {
        return "OFF";
      }
    }
    else
      return "!";
  }
}
