import '../models/user_model.dart';

// "Database" sementara (hilang saat aplikasi di-restart)
final List<UserModel> dummyUsers = [
  UserModel(username: 'luthfiahhasibuan', password: 'luthfi1234'),
  UserModel(
    nim: '87654321',
    name: 'Budi Santoso',
    username: 'luthfiahhasibuan',
    password: 'luthfi1234',
  ),
];
// User yang sedang login. Diisi saat Sign In berhasil, dikosongkan saat logout
UserModel? currentUser;
