
class UserNumber {
  final int? userNumber;

  UserNumber({required this.userNumber});

  Map<String, dynamic> toJson() {
    return {
      'userNumber': userNumber,
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
  final bool? auto;

  UserInfo({required this.userNumber, required this.id, required this.password, required this.userName, required this.phoneNumber, required this.auto});

  factory UserInfo.fromJson(Map<String, dynamic> json){
    return UserInfo(
      userNumber: json['userNumber'] as int,
      id : json['id'] as String,
      password: json['password'] as String,
      userName: json['userName'] as String,
      phoneNumber: json['phoneNumber'] as String,
      auto: json['auto'] as bool?
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userNumber' : userNumber,
      'id': id,
      'password': password,
      'userName': userName,
      'phoneNumber': phoneNumber,
      'auto' : auto
    };
  }
}

class UserPlant{
  final int plantNumber;
  final String plantType;
  final String plantName;

  UserPlant({required this.plantNumber, required this.plantName, required this.plantType});

  factory UserPlant.fromJson(Map<String,dynamic> json){
    return UserPlant(
        plantNumber: json['plantNumber'] as int,
        plantName: json['plantName'] as String,
        plantType: json['plantType'] as String
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'plantNumber' : plantNumber,
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
  final String userPlantName;

  SignupRequest(
      {required this.id,
        required this.password,
        required this.userName,
        required this.phoneNumber,
        required this.plantType,
        required this.userPlantName});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'password': password,
      'userName': userName,
      'phoneNumber': phoneNumber,
      'plantType': plantType,
      'userPlantName': userPlantName,
    };
  }
}

class AddPlant {
  final String plantType;
  final String userPlantName;

  AddPlant(
      {required this.plantType, required this.userPlantName});

  Map<String, dynamic> toJson() {
    return {
      'plantType': plantType,
      'userPlantName': userPlantName,
    };
  }
}

class PostWateringReq{
  final int userPlantNumber;
  final String wateringDate;

  PostWateringReq({
   required this.userPlantNumber,
   required this.wateringDate
  });

  Map<String, dynamic> toJson(){
    return{
      'userPlantNumber' : userPlantNumber,
      'wateringDate' : wateringDate
    };
  }
}

class HomeInfo {
  final int userNumber;
  final int userPlantNumber;
  final String userPlantName;
  final String userPlantType;
  final double moisture;
  final double humidity;
  final double temperature;

  HomeInfo({required this.userNumber, required this.userPlantNumber, required this.userPlantName, required this.userPlantType, required this.moisture, required this.humidity, required this.temperature});

  Map<String, dynamic> toJson() {
    return {
      'userNumber' : userNumber,
      'userPlantNumber': userPlantNumber,
      'userPlantName': userPlantName,
      'userPlantType' : userPlantType,
      'moisture': moisture,
      'humidity': humidity,
      'temperature': temperature,
    };
  }

  factory HomeInfo.fromJson(Map<String, dynamic> json){
    return HomeInfo(
      userNumber: json['userNumber'] as int,
      userPlantNumber : json['userPlantNumber'] as int,
      userPlantName: json['userPlantName'] as String,
      userPlantType: json['userPlantType'] as String,
      moisture: json['moisture'] as double,
      humidity: json['humidity'] as double,
      temperature: json['temperature'] as double,
    );
  }
}