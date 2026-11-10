import 'dart:convert';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/report_data.dart';
import '../models/user_model.dart';

class ReportException implements Exception {
  ReportException(this.message);

  final String message;

  @override
  String toString() => message;
} //jika pesan salah

class ReportRepository {
  ReportRepository({FirebaseFirestore? firestore})
    : _db = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _db;
  final Map<String, Uint8List> _imageCache = {};

  CollectionReference<Map<String, dynamic>> get _reports =>
      _db.collection('reports');
  CollectionReference<Map<String, dynamic>> get _images =>
      _db.collection('reportImages');

  //admin melihat semuanya, mahasiswa hanya melihat laporan miliknya
  Stream<List<ReportData>> watchReports(UserModel user) {
    final Query<Map<String, dynamic>> query = user.isAdmin
        ? _reports
        : _reports.where('reporter.uid', isEqualTo: user.uid);

    return query.snapshots().map(
      (snapshot) =>
          snapshot.docs.map(_fromDoc).toList()
            ..sort((a, b) => b.createdAt.compareTo(a.createdAt)),
    );
  }

  //menyinpan laporan dan fotonya (jika ada)
  Future<void> addReport(ReportData report, {Uint8List? imageBytes}) {
    return _guard(() async {
      final ref = _reports.doc();
      final batch = _db.batch();
      batch.set(ref, _toMap(report, hasImage: imageBytes != null));
      if (imageBytes != null) {
        batch.set(_images.doc(ref.id), {
          'data': base64Encode(imageBytes),
          'ownerUid': report.reporter.uid,
        });
      }
      await batch.commit();
    });
  }

  Future<void> updateStatus(String id, String status) {
    return _guard(
      () => _reports.doc(id).update({
        'status': status,
        if (status == ReportStatus.sent) ...{
          'response': FieldValue.delete(),
          'respondedAt': FieldValue.delete(),
        },
      }),
    );
  }

  //menyimpan tanggapan admin
  Future<void> respond(String id, String response) {
    return _guard(
      () => _reports.doc(id).update({
        'status': ReportStatus.responded,
        'response': response.trim(),
        'respondedAt': Timestamp.now(),
      }),
    );
  }

  //foto laporan
  Future<Uint8List?> fetchImage(String reportId) async {
    final cached = _imageCache[reportId];
    if (cached != null) return cached;

    final doc = await _images.doc(reportId).get();
    final encoded = doc.data()?['data'] as String?;
    if (encoded == null) return null;
    return _imageCache[reportId] = base64Decode(encoded);
  }

  Map<String, dynamic> _toMap(ReportData report, {required bool hasImage}) => {
    'faculty': report.faculty,
    'title': report.title,
    'category': report.category,
    'description': report.description,
    'hasImage': hasImage,
    'status': report.status,
    'createdAt': Timestamp.fromDate(report.createdAt),
    'reporter': {'uid': report.reporter.uid, ...report.reporter.toMap()},
  };

  ReportData _fromDoc(QueryDocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data();
    final reporter = data['reporter'] as Map<String, dynamic>;

    return ReportData(
      id: doc.id,
      faculty: data['faculty'] as String? ?? '',
      title: data['title'] as String? ?? '',
      category: data['category'] as String? ?? '',
      description: data['description'] as String? ?? '',
      reporter: UserModel.fromMap(reporter['uid'] as String, reporter),
      hasImage: data['hasImage'] as bool? ?? false,
      status: data['status'] as String? ?? ReportStatus.sent,
      response: data['response'] as String?,
      respondedAt: (data['respondedAt'] as Timestamp?)?.toDate(),
      createdAt: (data['createdAt'] as Timestamp?)?.toDate(),
    );
  }

  Future<T> _guard<T>(Future<T> Function() action) async {
    try {
      return await action();
    } on FirebaseException catch (e) {
      throw ReportException(_messageFor(e.code));
    }
  }

  String _messageFor(String code) => switch (code) {
    'permission-denied' => 'Kamu tidak punya izin untuk tindakan ini',
    'unavailable' => 'Tidak ada koneksi internet',
    _ => 'Terjadi kesalahan, coba lagi',
  };
}
