//make a user schema

class User {
  final int? id;
  final String firstName;
  final String lastName;
  final String username;
  final String? password;
  final Role role;

  User(
      {this.id,
      required this.firstName,
      required this.lastName,
      required this.username,
      this.password,
      this.role = Role.ghost});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      username: json['username'] as String,
      password: json['password'],
      role: Role.values.firstWhere((element) =>
          element.name.toLowerCase() == json['role'].toString().toLowerCase()),
    );
  }

  Map<String, dynamic> toJson({bool includeId = false}) {
    Map<String, dynamic> json = {
      'firstName': firstName,
      'lastName': lastName,
      'username': username,
      'password': password,
      'role': role.name.toLowerCase(),
    };

    if(includeId) {
      json['id'] = id;
    }

    return json;
  }

  static bool isValid(Map<String, dynamic> json) {
    return json.containsKey('firstname') &&
        json.containsKey('lastname') &&
        json.containsKey('username') &&
        json.containsKey('role');
  }

  static String? validateFirstName(String? firstName) {
    if (firstName == null || firstName.isEmpty) {
      return 'Username is required';
    }
    return null;
  }

  static String? validateLastName(String? lastName) {
    if (lastName == null || lastName.isEmpty) {
      return 'Username is required';
    }
    return null;
  }

  static String? validateUsername(String? username) {
    if (username == null || username.isEmpty) {
      return 'Username is required';
    }
    return null;
  }

  static String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return 'Password is required';
    }
    return null;
  }
}

enum Role { admin, manager, technician, asset, ghost }
