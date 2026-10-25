import 'dart:math' as math;

import 'package:flutter/widgets.dart';

class Responsive {
  Responsive(BuildContext context) : size = MediaQuery.sizeOf(context);

  final Size size;

  double get base => math.min(size.shortestSide, 600);

  double sp(double percent) => base * percent / 100;
  double font(double percent) => base * percent / 100;

  TextStyle ts(TextStyle style) {
    final fontSize = style.fontSize;
    if (fontSize == null) return style;
    return style.copyWith(fontSize: fontSize * math.min(base / 390, 1.3));
  }

  // Jarak
  double get gap => sp(4);
  double get gapS => gap / 2;
  double get pad => sp(5);
  double get bottom => sp(25); // ruang kosong di bawah halaman

  // Bentuk
  double get radius => sp(4);
  double get radiusS => radius / 2;
  double get icon => sp(6);
  double get button => sp(12); // tinggi tombol
  double get stroke => math.max(1.0, sp(0.3));
  double get strokeThick => stroke * 2;

  // Layout
  double get maxWidth => sp(110); // lebar maksimum konten di layar lebar
  int get lines => base >= 500 ? 8 : 6; // baris kolom teks panjang
}

extension ResponsiveContext on BuildContext {
  Responsive get r => Responsive(this);
}
