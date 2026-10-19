import '../models/user_model.dart';

// "Database" sementara (hilang saat aplikasi di-restart)
final List<UserModel> dummyUsers = [
  UserModel(
    nim: '231401125',
    name: 'Luthfiah Hasibuan',
    username: 'luthfiahhasibuan',
    password: 'luthfi1234',
  ),
];
// User yang sedang login. Diisi saat Sign In berhasil, dikosongkan saat logout
UserModel? currentUser;
