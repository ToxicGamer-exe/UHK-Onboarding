//make a user schema

class User {
  final int id;
  final String firstName;
  final String lastName;
  final String username;
  // final String password;
  final Role role;

  User(this.id, this.firstName, this.lastName, this.username, this.role);

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      json['id'] as int,
      json['firstName'] as String,
      json['lastName'] as String,
      json['username'] as String,
      // json['password'] ?? '',
      Role.values.firstWhere((element) => element.name.toLowerCase() == json['role'].toString().toLowerCase()),
    );
  }

  static bool isValid(Map<String, dynamic> json) {
    return json.containsKey('firstname') &&
        json.containsKey('lastname') &&
        json.containsKey('username') &&
        json.containsKey('role');
  }
}

enum Role { admin, manager, technician, asset, ghost }
