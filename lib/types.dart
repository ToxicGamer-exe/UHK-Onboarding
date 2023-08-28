//make a user schema

import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int? id;
  final String firstName;
  final String lastName;
  final String username;
  String? password;
  final Role role;

  List<Object?> get props => [id, firstName, lastName, username, password];

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
      'role': role.name.toLowerCase(),
    };

    if(password != null) {
      json['password'] = password;
    }

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
    if (firstName == null || firstName.trim().isEmpty) {
      return 'Username is required';
    }
    return null;
  }

  static String? validateLastName(String? lastName) {
    if (lastName == null || lastName.trim().isEmpty) {
      return 'Username is required';
    }
    return null;
  }

  static String? validateUsername(String? username) {
    if (username == null || username.trim().isEmpty) {
      return 'Username is required';
    }
    return null;
  }

  static String? validatePassword(String? password) {
    if (password == null || password.trim().isEmpty) {
      return 'Password is required';
    }
    return null;
  }
}

enum Role { admin, manager, technician, asset, ghost }
