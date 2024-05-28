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

//비옥도
class StatusMoisture {
  final int moisture;

  StatusMoisture({required this.moisture});

  factory StatusMoisture.fromJson(dynamic json) {
    return StatusMoisture(
      moisture: json as int,
    );
  }
}

//대기
class StatusHumi {
  final int humidity;

  StatusHumi({required this.humidity});

  factory StatusHumi.fromJson(dynamic json) {
    return StatusHumi(
      humidity: json as int,
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
