import 'package:http/http.dart' as http;
import 'package:mypetplant/addPlant.dart';
import 'dart:convert';
import 'user.dart';
import 'token.dart';

String address = "http://35.216.16.211:8080";
//String address = "http://172.30.1.33.8080";
//String address = "http://localhost:8080";
//String address = "http://35.216.120.157:8080";

class DBService {
  //
  Future<void> login(User user) async {
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
        print(response.body);
        // 로그인 성공 처리
        try {
          Map<String, dynamic> responseBody = jsonDecode(response.body);
          if (responseBody.isNotEmpty) {
            accessToken = responseBody['token']['accessToken'];
            refreshToken = responseBody['token']['refreshToken'];
          } else {
            accessToken = null;
            refreshToken = null;
          }
        }
        catch (e) {
          print('응답 내용을 JSON으로 변환하는 중 오류 발생: $e');
          accessToken = null;
          refreshToken = null;
        }
      } else {
        accessToken = null;
        refreshToken = null;
      }
    } catch (e) {
      // 네트워크 요청 중 에러 발생 처리
      print(e);
      accessToken = null;
      refreshToken = null;
    }
  }

  Future<List<HomeInfo>?> home() async {
    var url = Uri.parse(address + '/user/home');
    try {
      print(refreshToken);
      print(accessToken);
      var response = await http.get(
          url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $accessToken',
            'RefreshToken': refreshToken!,
          },);
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(utf8.decode(response.bodyBytes));
        print(data);
        List<HomeInfo> home = [];
        for(var item in data){
          HomeInfo homeInfo = HomeInfo.fromJson(item);
          home.add(homeInfo);
        }
        return home;


      } else {
        // 요청이 실패하면 ""을 반환합니다.
        return null;
      }
    } catch (e) {
      // 네트워크 요청 중 에러 발생 처리 null 반환
      print(e);
      return null;
    }
  }

  Future<bool?> addPlant(AddPlant addPlant) async {
    var url = Uri.parse(address + '/userplant/add');
    try {
      var response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $accessToken',
          'RefreshToken': refreshToken!,
        },
        body: jsonEncode(addPlant.toJson()),
      );
      if (response.statusCode == 200) {
        return true;
      }
      else{
        return false;
      }
    }
    catch (e) {
      // 네트워크 요청 중 에러 발생 처리 null 반환
      print(e);
      return false;
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
      print(response.statusCode);
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
    var url = Uri.parse(address + '/user/sign-up'); // 회원가입 API URL
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
     var url = Uri.parse(address + '/user/id-check?id=$id');
     try {
       var response = await http.get(
         url,
         headers: <String, String>{
           'Content-Type': 'application/json; charset=UTF-8',
         },
       );
       print('Response status: ${response.statusCode}');
       print('Response body: ${response.body}');
       if (response.statusCode == 200) {
         return true;
       } else {
         return false;
       }
     } catch (e) {
       // 네트워크 에러
       print(e);
       return false;
     }
   }

   Future<bool> checkNameAvailability(String name) async {
     var url = Uri.parse(address + '/user/name-check?name=$name');
     try {
       var response = await http.get(
         url,
         headers: <String, String>{
           'Content-Type': 'application/json; charset=UTF-8',
         },
       );
       print('Response status: ${response.statusCode}');
       print('Response body: ${response.body}');
       if (response.statusCode == 200) {
         // 사용 가능 닉네임
         return true;
       } else {
         //사용 불가 닉네임
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
          data.where((date)=>date!=null).map((date) => DateTime.parse(date)).toList();

      return fetchedDates;
    } else {
      throw Exception('Failed to load watering dates');
    }
  } catch (e) {
    // 네트워크 에러
    print(e);
  }
}
