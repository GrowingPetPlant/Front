import 'package:http/http.dart' as http;
import 'dart:convert';
import 'user.dart';


String address = "http://172.30.1.81:8080";
// String address = "http://localhost:8080";

class DBService {
  //
  Future<int?> login(User user) async {
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
        try {
          int userId = int.parse(response.body);
          return userId;
        } catch (e) {
          print('응답 내용을 int로 변환하는 중 오류 발생: $e');
          return null;
        }
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
    var url = Uri.parse(address + '/user/delete/' + id);
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
    var url = Uri.parse(address + '/user/signup'); // 회원가입 API URL
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
    var url = Uri.parse(address + '/user/idCheck?id=$id');
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

  Future<bool> checkNameAvailability(String name) async {
    var url = Uri.parse(address + '/user/nameCheck?name=$name');
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

  Future<String?> putwater(PostWateringReq postWateringReq) async {
    var url = Uri.parse(address + '/arduino/putwater');
    try {
      var response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(postWateringReq.toJson()),
      );
      return response.body;
    } catch (e) {
      // 네트워크 요청 중 에러 발생 처리 null 반환
      print(e);
      return null;
    }
  }
}

Future<String?> watering(PostWateringReq postWateringReq) async {
  var url = Uri.parse(address + '/arduino/watering');
  try {
    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(postWateringReq.toJson()),
    );
    return response.body;
  } catch (e) {
    // 네트워크 요청 중 에러 발생 처리 null 반환
    print(e);
    return null;
  }
}

Future<UserInfo?> findUser(UserNumber userNumber) async {
  var url = Uri.parse(address +
      '/user/findUser' +
      '?userNumber=' +
      userNumber.userNumber!.toString());
  try {
    var response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      // 마이페이지 수정 성공 처리
      var userData = json.decode(utf8.decode(response.bodyBytes));
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

Future<UserPlant?> findUserPlant(UserNumber userNumber) async {
  var url = Uri.parse(address +
      '/userplant/findUserPlant' +
      '?userNumber=' +
      userNumber.userNumber!.toString());
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
      var userPlant = UserPlant.fromJson(userPlantData);
      UserPlant userplant = UserPlant(
          plantNumber: userPlant.plantNumber,
          plantType: userPlant.plantType,
          plantName: userPlant.plantName);
      return userplant;
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

Future<List<DateTime>?> fetchWarteringDates(int plantNumber) async {
  var url = Uri.parse(
      address + '/status/wateringdate?plantNumber=' + plantNumber.toString());
  try {
    var response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      List<DateTime> fetchedDates =
          data.map((date) => DateTime.parse(date)).toList();

      return fetchedDates;
    } else {
      throw Exception('Failed to load watering dates');
    }
  } catch (e) {
    // 네트워크 에러
    print(e);
  }
}
