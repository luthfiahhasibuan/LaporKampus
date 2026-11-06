//import '../models/report_data.dart';
import '../models/user_model.dart';

// Database sementara
final List<UserModel> dummyUsers = [
  UserModel(
    nim: '231401125',
    name: 'Luthfiah Hasibuan',
    username: 'luthfiahhasibuan',
    password: 'luthfi1234',
  ),

  UserModel(
    nim: 'ADM001',
    name: 'Admin Kampus',
    username: 'admin',
    password: 'admin1234',
    role: UserRole.admin,
  ),
];

UserModel? currentUser;
