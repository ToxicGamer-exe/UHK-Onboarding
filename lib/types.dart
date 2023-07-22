//make a user schema

class User {
  final int id;
  final String name;
  final String surname;
  final String password;
  final String username;
  final Role role;
}

enum Role { admin, manager, technician, asset, ghost }