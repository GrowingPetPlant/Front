import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mypetplant/token.dart';
import 'status.dart';

//String address = "http://localhost:8080";
//String address = "http://172.30.1.86:8080";
//String address = "http://35.216.120.157:8080";
String address = "http://35.216.16.211:8080";

class StatusService {
  //온도
  Future<StatusTemp> fetchRecentTemp(int plantNumber) async {
    var url = Uri.parse('$address/status/temp?plantNumber=$plantNumber');
    final response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $accessToken',
        'RefreshToken': refreshToken!,
      },
    );
    if (response.statusCode == 200) {
      return StatusTemp.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('온도 불러오기 실패했습니다.');
    }
  }

  //비옥도
  Future<StatusMoisture> fetchRecentMoisture(int plantNumber) async {
    var url = Uri.parse('$address/status/moisture?plantNumber=$plantNumber');
    final response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $accessToken',
        'RefreshToken': refreshToken!,
      },
    );

    if (response.statusCode == 200) {
      return StatusMoisture.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('습도 불러오기 실패했습니다.');
    }
  }

  //대기
  Future<StatusHumi> fetchRecentHumi(int plantNumber) async {
    var url = Uri.parse('$address/status/humi?plantNumber=$plantNumber');
    final response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $accessToken',
        'RefreshToken': refreshToken!,
      },
    );

    if (response.statusCode == 200) {
      return StatusHumi.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('비옥도 불러오기 실패했습니다');
    }
  }

  // 자란 일수
  Future<StatusDays> fetchGrowingDays(int plantNumber) async {
    var url = Uri.parse('$address/status/days?plantNumber=$plantNumber');
    final response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $accessToken',
        'RefreshToken': refreshToken!,
      },
    );
    if (response.statusCode == 200) {
      return StatusDays.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('자란 일수 불러오기 실패했습니다');
    }
  }

  //전구버튼 누르면 실행할거
  Future<String> lighting(int plantNumber) async {
    var url = Uri.parse('$address/arduino/lighting?plantNumber=$plantNumber');
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $accessToken',
        'RefreshToken': refreshToken!,
      },
    );
    if (response.statusCode == 200) {
      if (jsonDecode(response.body))
        return "ON";
      else
        return "OFF";
    } else
      return "!";
  }

  //홈화면 넘어갈 때 실행할거
  Future<String> isLighted(int plantNumber) async {
    var url = Uri.parse('$address/status/isLighted?plantNumber=$plantNumber');
    final response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $accessToken',
        'RefreshToken': refreshToken!,
      },
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      if (jsonDecode(response.body)) {
        return "ON";
      } else {
        return "OFF";
      }
    } else
      return "!";
  }

  //팬 버튼 누르면 실행할거
  Future<String> fanning(int plantNumber) async {
    var url = Uri.parse('$address/arduino/fanning?plantNumber=$plantNumber');
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $accessToken',
        'RefreshToken': refreshToken!,
      },
    );

    if (response.statusCode == 200) {
      if (jsonDecode(response.body))
        return "ON";
      else
        return "OFF";
    } else
      return "!";
  }

  //홈화면 넘어갈 때 실행할거
  Future<String> isFanned(int plantNumber) async {
    var url = Uri.parse('$address/status/isFanned?plantNumber=$plantNumber');
    final response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $accessToken',
        'RefreshToken': refreshToken!,
      },
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      if (jsonDecode(response.body)) {
        return "ON";
      } else {
        return "OFF";
      }
    } else
      return "!";
  }
}
