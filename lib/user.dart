
class ID {
  final String? id;

  ID({required this.id});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
    };
  }
}

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

class UserInfo {
  final int userNumber;
  final String id;
  final String password;
  final String userName;
  final String phoneNumber;

  UserInfo({required this.userNumber, required this.id, required this.password, required this.userName, required this.phoneNumber});

  factory UserInfo.fromJson(Map<String, dynamic> json){
    return UserInfo(
      userNumber: json['userNumber'] as int,
      id : json['id'] as String,
      password: json['password'] as String,
      userName: json['userName'] as String,
      phoneNumber: json['phoneNumber'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userNumber' : userNumber,
      'id': id,
      'password': password,
      'userName': userName,
      'phoneNumber': phoneNumber,
    };
  }
}

class UserPlant{
  final String plantType;
  final String plantName;

  UserPlant({required this.plantName, required this.plantType});

  factory UserPlant.fromJson(Map<String,dynamic> json){
    return UserPlant(
        plantName: json['plantName'] as String,
        plantType: json['plantType'] as String
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'plantType' : plantType,
      'plantName' : plantName
    };
  }
}

class UserInfo_plant {
  final int userNumber;
  final String id;
  final String password;
  final String userName;
  final String phoneNumber;
  final String plantType;
  final String plantName;

  UserInfo_plant({required this.userNumber, required this.id, required this.password, required this.userName, required this.phoneNumber, required this.plantType, required this.plantName});

  Map<String, dynamic> toJson() {
    return {
      'userNumber' : userNumber,
      'id': id,
      'password': password,
      'userName': userName,
      'phoneNumber': phoneNumber,
      'plantType': plantType,
      'plantName': plantName,
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