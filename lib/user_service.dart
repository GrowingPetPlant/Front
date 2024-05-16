import 'package:http/http.dart' as http;
import 'dart:convert';
import 'user.dart';

String address = "http://10.50.102.110:8080";

class DBService {
  //로그인
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

  //아이디 찾기
  Future<String?> find_Id(findId find_id) async {
    var url = Uri.parse('http://localhost:8080/user/findId');
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

  //비밀번호 찾기
  Future<String?> find_pw(findPw find_pw) async {
    var url = Uri.parse('http://localhost:8080/user/findPwd');
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

  //회원가입
  Future<bool> register(SignupRequest signupRequest) async {
    var url = Uri.parse('http://localhost:8080/user/signup'); // 회원가입 API URL
    try {
      var response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(signupRequest.toJson()),
      );

      //회원가입 응답 코드 확인
      print('회원가입 응답 코드: ${response.statusCode}');

      if (response.statusCode == 200) {
        // 회원가입 성공 처리
        print('회원가입 성공: ${response.body}');
        return true;
      } else {
        // 회원가입 실패 처리
        print('회원가입 실패: ${response.body}');
        return false;
      }
    } catch (e) {
      // 네트워크 요청 중 에러
      print('회원가입 중 오류: $e');
      return false;
    }
  }

  // 아이디 중복 검사
  Future<bool> checkIdAvailability(String id) async {
    var url = Uri.parse('http://localhost:8080/user/idCheck?id=$id');
    try {
      var response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        //body: jsonEncode({'id': id}), //아이디 정보를 함께 전송
      );
      if (response.statusCode == 200) {
        // 사용 가능 아이디
        print('사용 가능한 아이디: ${response.body}');
        return true;
      } else {
        //사용 불가 아이디
        print('사용 불가능한 아이디: ${response.body}');
        return false;
      }
    } catch (e) {
      // 네트워크 에러
      print(e);
      return false;
    }
  }
}
