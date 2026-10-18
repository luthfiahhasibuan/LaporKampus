class Validators {
  static const int nimMin = 8;
  static const int nimMax = 12;

  static String? nim(String? value) {
    if (value == null || value.trim().isEmpty) return 'NIM tidak boleh kosong';
    final v = value.trim();
    if (!RegExp(r'^[0-9]+$').hasMatch(v)) return 'NIM hanya boleh berisi angka';
    if (v.length < nimMin) return 'NIM minimal $nimMin digit';
    if (v.length > nimMax) return 'NIM maksimal $nimMax digit';
    return null;
  }

  static String? name(String? value) {
    if (value == null || value.trim().isEmpty) return 'Nama tidak boleh kosong';
    if (value.trim().length < 3) return 'Nama minimal 3 karakter';
    return null;
  }

  static String? username(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Username tidak boleh kosong';
    }
    final v = value.trim();
    if (v.length < 4) return 'Username minimal 4 karakter';
    if (v.length > 20) return 'Username maksimal 20 karakter';
    if (v.contains(' ')) return 'Username tidak boleh mengandung spasi';
    if (!RegExp(r'^[A-Za-z0-9_]+$').hasMatch(v)) {
      return 'Username hanya boleh huruf, angka, dan underscore (_)';
    }
    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) return 'Password tidak boleh kosong';
    if (value.length < 8) return 'Password minimal 8 karakter';
    if (!RegExp(r'[A-Za-z]').hasMatch(value) ||
        !RegExp(r'[0-9]').hasMatch(value)) {
      return 'Password harus mengandung huruf dan angka';
    }
    return null;
  }

  static String? confirmPassword(String? value, String original) {
    if (value == null || value.isEmpty) {
      return 'Konfirmasi password tidak boleh kosong';
    }
    if (value != original) return 'Konfirmasi password tidak cocok';
    return null;
  }
}
