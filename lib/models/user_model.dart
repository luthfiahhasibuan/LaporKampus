enum UserRole { student, admin }

class UserModel {
  final String nim;
  final String name;
  final String username;
  final String password;
  final UserRole role;

  UserModel({
    required this.nim,
    required this.name,
    required this.username,
    required this.password,
    this.role = UserRole.student,
  });

  bool get isAdmin => role == UserRole.admin;

  /// Label nomor identitas: admin tidak punya NIM.
  String get idLabel => isAdmin ? 'ID Admin' : 'NIM';
}
