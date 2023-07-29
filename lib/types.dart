//make a user schema

class User {
  final int id;
  final String firstName;
  final String lastName;
  // final String password;
  final String username;
  // final Role role;
  final String role;

  User(this.id, this.firstName, this.lastName, this.username, this.role);

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      json['id'] as int,
      json['firstName'] as String,
      json['lastName'] as String,
      json['username'] as String,
      (json['role'] as String).toUpperCase(), // Convert string to Role enum
    );
  }

  // User(this.id, this.name, this.surname, this.password, this.username,
  //     this.role);
}

enum Role { admin, manager, technician, asset, ghost }
