import 'package:http/http.dart' as http;
import 'dart:convert';
import 'user.dart';
String address="http://172.20.10.11:8080";
class DBService {
  //
  Future<String?> login(User user) async {
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
        return response.body;
      } else {
        // 로그인 실패 처리
        return null;
      }
    } catch (e) {
      // 네트워크 요청 중 에러 발생 처리
      print(e);
      return null;
    }
  }

  //아이디 찾기
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

  //비밀번호 찾기
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

  Future<String?> mypage(UserInfo_plant userInfo_plant) async {
    var url = Uri.parse(address + '/user/mypage');
    try {
      var response = await http.patch(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: utf8.encode(jsonEncode(userInfo_plant.toJson())),
      );
      if (response.statusCode == 200) {
        // 마이페이지 수정 성공 처리
        return response.body; //마이페이지가 수정됐습니다
      } else {
        // 마이페이지 수정 실패 처리
        return null;
      }
    } catch (e) {
      // 네트워크 요청 중 에러 발생 처리
      print(e);
      return null;
    }
  }

  Future<String?> logout() async {
    var url = Uri.parse(address + '/user/logout');
    try {
      var response = await http.get(url);
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

  Future<String?> deleteUser(String id) async {
    var url = Uri.parse(address + '/user/delete/'+id);
    try {
      var response = await http.delete(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
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
    var url = Uri.parse(address+'/user/signup'); // 회원가입 API URL
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
    var url = Uri.parse(address+'/user/idCheck?id=$id');
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

Future<UserInfo?> findUser(ID id) async {
  var url = Uri.parse(address + '/user/findUser' + '?id=' + id.id!);
  try {
    var response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      // 마이페이지 수정 성공 처리
      var userData = json.decode(response.body);
      var userInfo = UserInfo.fromJson(userData);
      return userInfo;
    } else {
      // 마이페이지 수정 실패 처리
      return null;
    }
  } catch (e) {
    // 네트워크 요청 중 에러 발생 처리
    print(e);
    return null;
  }
}

Future<UserInfo_plant?> findUserPlant(UserInfo user) async {
  var url = Uri.parse(address + '/userplant/findUserPlant' + '?userNumber=' +
      user.userNumber.toString());
  try {
    var response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      // 마이페이지 수정 성공 처리
      var userPlantData = json.decode(utf8.decode(response.bodyBytes));
      var userPlantInfo = UserPlant.fromJson(userPlantData);
      UserInfo_plant userinfo_plant = UserInfo_plant(
          userNumber: user.userNumber,
          id: user.id,
          password: user.password,
          userName: user.userName,
          phoneNumber: user.phoneNumber,
          plantType: userPlantInfo.plantType,
          plantName: userPlantInfo.plantName);
      return userinfo_plant;
    } else {
      // 마이페이지 수정 실패 처리
      return null;
    }
  } catch (e) {
    // 네트워크 요청 중 에러 발생 처리
    print(e);
    return null;
  }
}

