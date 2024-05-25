import 'dart:convert';
import 'package:http/http.dart' as http;
import 'status.dart';

String address = "http://localhost:8080";

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

  //습도
  Future<StatusMoisture> fetchRecentMoisture(int plantNumber) async {
    final response = await http
        .get(Uri.parse('$address/status/moisture?plantNumber=$plantNumber'));

    if (response.statusCode == 200) {
      return StatusMoisture.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('습도 불러오기 실패했습니다.');
    }
  }

  //비옥도
  Future<StatusHumi> fetchRecentHumi(int plantNumber) async {
    final response = await http
        .get(Uri.parse('$address/status/humi?plantNumber=$plantNumber'));

    if (response.statusCode == 200) {
      return StatusHumi.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('비옥도 불러오기 실패했습니다');
    }
  }
}
