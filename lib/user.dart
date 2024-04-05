
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
