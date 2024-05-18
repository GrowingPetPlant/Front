import 'package:http/http.dart' as http;
import 'dart:convert';
import 'user.dart';
String address="http://172.30.1.78:8080";
class DBService {
  //
  Future<String?> login(User user) async {
    var url = Uri.parse(address + '/user/login'); //localhost:8080/user/login
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