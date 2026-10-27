import 'package:flutter/foundation.dart';

class FavoriteProvider extends ChangeNotifier {
  // Set digunakan untuk menampung kumpulan nama candi unik (menolak nama ganda)
  final Set<String> _favorites = {};

  // Getter untuk mengambil jumlah total favorit untuk ditampilkan di ProfileScreen
  int get count => _favorites.length;

  // Fungsi untuk memeriksa apakah candi tertentu sudah difavoritkan atau belum
  bool isFavorite(String name) => _favorites.contains(name);

  // Fungsi untuk menambah atau menghapus status favorit candi
  void toggle(String name) {
    if (_favorites.contains(name)) {
      _favorites.remove(name);
    } else {
      _favorites.add(name);
    }
    // Memberi tahu semua widget pendengar (yang menggunakan .watch) agar build ulang
    notifyListeners();
  }

  // =========================================================================
  // LATIHAN MANDIRI: Menambahkan fungsi untuk menghapus seluruh daftar favorit
  // =========================================================================
  void clearAll() {
    _favorites.clear(); // Mengosongkan data di dalam Set
    notifyListeners(); // Wajib dipanggil agar UI di ProfileScreen ikut ter-refresh menjadi 0
  }
}
