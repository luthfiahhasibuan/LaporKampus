enum UserRole { student, admin }

class UserModel {
  final String uid;
  final String nim;
  final String name;
  final String username;
  final UserRole role;

  UserModel({
    required this.uid,
    required this.nim,
    required this.name,
    required this.username,
    this.role = UserRole.student,
  });

  bool get isAdmin => role == UserRole.admin;

  /// Label nomor identitas: admin tidak punya NIM.
  String get idLabel => isAdmin ? 'ID Admin' : 'NIM';

  factory UserModel.fromMap(String uid, Map<String, dynamic> map) {
    return UserModel(
      uid: uid,
      nim: map['nim'] as String? ?? '',
      name: map['name'] as String? ?? '',
      username: map['username'] as String? ?? '',
      role: map['role'] == 'admin' ? UserRole.admin : UserRole.student,
    );
  }

  Map<String, dynamic> toMap() => {
    'nim': nim,
    'name': name,
    'username': username,
    'role': role.name, // 'student' atau 'admin', cocok dengan Rules
  };
}
