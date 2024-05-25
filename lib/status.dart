//온도
class StatusTemp {
  final int temperature;

  StatusTemp({required this.temperature});

  factory StatusTemp.fromJson(dynamic json) {
    return StatusTemp(
      temperature: json as int,
    );
  }
}

//습도
class StatusMoisture {
  final int moisture;

  StatusMoisture({required this.moisture});

  factory StatusMoisture.fromJson(dynamic json) {
    return StatusMoisture(
      moisture: json as int,
    );
  }
}

//비옥도
class StatusHumi {
  final int humidity;

  StatusHumi({required this.humidity});

  factory StatusHumi.fromJson(dynamic json) {
    return StatusHumi(
      humidity: json as int,
    );
  }
}
