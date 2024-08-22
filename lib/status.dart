class plantInfo {
  final int plantNumber;
  final String plantType;
  final int growthPeriod;
  final int highTemp;
  final int lowTemp;
  final int optMoisture;

  plantInfo({required this.plantNumber, required this.plantType, required this.growthPeriod, required this.highTemp, required this.lowTemp, required this.optMoisture});

  factory plantInfo.fromJson(dynamic json) {
    return plantInfo(
      plantNumber: json['plantNumber'] as int,
      plantType: json['plantType'] as String,
      growthPeriod: json['growthPeriod'] as int,
      highTemp: json['highTemp'] as int,
      lowTemp: json['lowTemp'] as int,
      optMoisture: json['optMoisture'] as int
    );
  }
}

//온도
class StatusTemp {
  final double temperature;

  StatusTemp({required this.temperature});

  factory StatusTemp.fromJson(dynamic json) {
    return StatusTemp(
      temperature: json as double,
    );
  }
}

//비옥도
class StatusMoisture {
  final double moisture;

  StatusMoisture({required this.moisture});

  factory StatusMoisture.fromJson(dynamic json) {
    return StatusMoisture(
      moisture: json as double,
    );
  }
}

//대기
class StatusHumi {
  final double humidity;

  StatusHumi({required this.humidity});

  factory StatusHumi.fromJson(dynamic json) {
    return StatusHumi(
      humidity: json as double,
    );
  }
}

// 자란 일수
class StatusDays {
  final int days;

  StatusDays({required this.days});

  factory StatusDays.fromJson(dynamic json) {
    return StatusDays(
      days: json as int,
    );
  }
}
