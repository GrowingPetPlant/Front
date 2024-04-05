import 'package:http/http.dart' as http;
import 'dart:convert';
import 'user.dart';

class DBService {
  //
  Future<bool> login(User user) async {
    var url = Uri.parse('http://localhost:8080/user/login');
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
}
