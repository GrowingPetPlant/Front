import 'package:http/http.dart' as http;
import 'dart:convert';
import 'user.dart';
String address="http://172.30.1.75:8080";
class DBService {
  //
  Future<bool> login(User user) async {
    var url = Uri.parse(address + '/user/login');
    try {
      var response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(user.toJson()),
      );
      if (response.statusCode == 200) {
        // 로그인 성공 처리
        return true;
      } else {
        // 로그인 실패 처리
        return false;
      }
    } catch (e) {
      // 네트워크 요청 중 에러 발생 처리
      print(e);
      return false;
    }
  }

  Future<String?> find_Id(findId find_id) async {
    var url = Uri.parse(address + '/user/findId');
    try {
      var response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(find_id.toJson()),
      );
      if (response.statusCode == 200) {
        return response.body;
      } else {
        // 요청이 실패하면 ""을 반환합니다.
        return "";
      }
    } catch (e) {
      // 네트워크 요청 중 에러 발생 처리 null 반환
      print(e);
      return null;
    }
  }

  Future<String?> find_pw(findPw find_pw) async {
    var url = Uri.parse(address + '/user/findPwd');
    try {
      var response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(find_pw.toJson()),
      );
      if (response.statusCode == 200) {
        return response.body;
      } else {
        // 요청이 실패하면 ""을 반환합니다.
        return "";
      }
    } catch (e) {
      // 네트워크 요청 중 에러 발생 처리 null 반환
      print(e);
      return null;
    }
  }
}


