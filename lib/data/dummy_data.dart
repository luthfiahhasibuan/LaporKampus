import '../models/user_model.dart';

// Database sementara 
final List<UserModel> dummyUsers = [
  UserModel(
    nim: '231401125',
    name: 'Luthfiah Hasibuan',
    username: 'luthfiahhasibuan',
    password: 'luthfi1234',
  ),
];
//kosongkan saat logout
UserModel? currentUser;
