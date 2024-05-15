
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

