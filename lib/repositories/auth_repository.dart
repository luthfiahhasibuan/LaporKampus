import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/user_model.dart';

//kesalahan autentikasi: pesan ke pengguna
class AuthException implements Exception {
  AuthException(this.message);

  final String message;

  @override
  String toString() => message;
}

class AuthRepository {
  AuthRepository({FirebaseAuth? auth, FirebaseFirestore? firestore})
    : _auth = auth ?? FirebaseAuth.instance,
      _db = firestore ?? FirebaseFirestore.instance;

  final FirebaseAuth _auth;
  final FirebaseFirestore _db;

  static const String _emailDomain = 'laporkampus.app';

  CollectionReference<Map<String, dynamic>> get _users =>
      _db.collection('users');

  String _toEmail(String username) =>
      '${username.trim().toLowerCase()}@$_emailDomain';

  Future<UserModel> signUp({
    required String nim,
    required String name,
    required String username,
    required String password,
  }) async {
    UserCredential credential;
    try {
      credential = await _auth.createUserWithEmailAndPassword(
        email: _toEmail(username),
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw AuthException(_messageFor(e.code));
    }

    final user = UserModel(
      uid: credential.user!.uid,
      nim: nim.trim(),
      name: name.trim(),
      username: username.trim().toLowerCase(),
    );

    try {
      // NIM harus unik: dokumen nims/{nim} dibuat bersamaan dengan profil.
      await _db.runTransaction((tx) async {
        final nimRef = _db.collection('nims').doc(user.nim);
        if ((await tx.get(nimRef)).exists) {
          throw AuthException('NIM sudah terdaftar');
        }
        tx.set(nimRef, {'uid': user.uid});
        tx.set(_users.doc(user.uid), user.toMap());
      });
    } on AuthException {
      await credential.user!.delete(); // jangan tinggalkan akun tanpa profil
      rethrow;
    } on FirebaseException {
      await credential.user!.delete();
      throw AuthException('Gagal menyimpan data akun, coba lagi');
    }
    return user;
  }

  Future<UserModel> signIn({
    required String username,
    required String password,
  }) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: _toEmail(username),
        password: password,
      );
      return await _loadProfile(credential.user!.uid);
    } on FirebaseAuthException catch (e) {
      throw AuthException(_messageFor(e.code));
    }
  }

  Future<UserModel?> restoreSession() async {
    final firebaseUser = _auth.currentUser;
    if (firebaseUser == null) return null;
    try {
      return await _loadProfile(firebaseUser.uid);
    } on AuthException {
      return null;
    }
  }

  Future<void> signOut() => _auth.signOut();

  Future<UserModel> _loadProfile(String uid) async {
    final doc = await _users.doc(uid).get();
    final data = doc.data();
    if (data == null) {
      await _auth.signOut();
      throw AuthException('Data akun tidak ditemukan');
    }
    return UserModel.fromMap(uid, data);
  }

  String _messageFor(String code) => switch (code) {
    'invalid-credential' ||
    'user-not-found' ||
    'wrong-password' => 'Username atau password salah',
    'email-already-in-use' => 'Username sudah dipakai',
    'weak-password' => 'Password terlalu lemah (minimal 6 karakter)',
    'invalid-email' =>
      'Username hanya boleh huruf, angka, titik, dan garis bawah',
    'network-request-failed' => 'Tidak ada koneksi internet',
    'too-many-requests' => 'Terlalu banyak percobaan, coba lagi nanti',
    _ => 'Terjadi kesalahan, coba lagi',
  };
}
