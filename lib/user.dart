import 'dart:ffi';

class User {
  final String id;
  final String password;

  User({required this.id, required this.password});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'password': password,
    };
  }
}

class findId {
  final String name;
  final String phone_number;

  findId({required this.name, required this.phone_number});

  Map<String, dynamic> toJson() {
    return {
      'userName': name,
      'phoneNumber': phone_number,
    };
  }
}

class findPw {
  final String name;
  final String id;

  findPw({required this.name, required this.id});

  Map<String, dynamic> toJson() {
    return {
      'userName': name,
      'id': id,
    };
  }
}

class SignupRequest {
  final String id;
  final String password;
  final String userName;
  final String phoneNumber;
  final String plantType;
  final String plantName;

  SignupRequest(
      {required this.id,
      required this.password,
      required this.userName,
      required this.phoneNumber,
      required this.plantType,
      required this.plantName});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'password': password,
      'userName': userName,
      'phoneNumber': phoneNumber,
      'plantType': plantType,
      'plantName': plantName,
    };
  }
}
