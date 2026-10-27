import 'package:flutter/foundation.dart';

class ThemeProvider extends ChangeNotifier {
  // Status default tema: false berarti Light Mode, true berarti Dark Mode
  bool _isDark = false;

  // Getter untuk membaca status tema saat ini di main.dart dan profile_screen.dart
  bool get isDark => _isDark;

  // Fungsi aksi untuk membalikkan nilai tema (Dark <-> Light)
  void toggleTheme() {
    _isDark = !_isDark;

    // Wajib panggil notifyListeners agar seluruh aplikasi langsung berubah warna secara real-time
    notifyListeners();
  }
}
