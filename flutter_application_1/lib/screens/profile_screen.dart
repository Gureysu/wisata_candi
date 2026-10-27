import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Wajib diimport untuk berinteraksi dengan Provider
import 'package:flutter_application_1/widget/profile_info_item.dart';

// Import semua provider dan screen yang dibutuhkan untuk sinkronisasi data
import 'package:flutter_application_1/providers/auth_provider.dart';
import 'package:flutter_application_1/providers/favorite_provider.dart';
import 'package:flutter_application_1/providers/theme_provider.dart';
import 'package:flutter_application_1/screens/sign_in_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. Mendengarkan seluruh perubahan data dari masing-masing Provider
    final auth = context.watch<AuthProvider>();
    final favoriteCount = context.watch<FavoriteProvider>().count;
    final themeProvider = context.watch<ThemeProvider>();

    return Scaffold(
      // Properti ini membuat body naik ke atas melewati batas AppBar sehingga visual background ungu menyatu sempurna
      extendBodyBehindAppBar: true,

      // Kustomisasi AppBar agar tombol dan teksnya berwarna putih terang
      appBar: AppBar(
        title: const Text('Profil Pengguna'),
        backgroundColor: Colors.transparent, // Transparan agar warna Container ungu memancar dari belakang
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ), // Membuat tombol panah back menjadi PUTIH
        titleTextStyle: const TextStyle(
          color:
              Colors.white, // Membuat judul menjadi PUTIH agar terlihat jelas
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        actions: [
          IconButton(
            icon: Icon(
              themeProvider.isDark ? Icons.light_mode : Icons.dark_mode,
              color: Colors.white, // Membuat tombol dark mode menjadi PUTIH
            ),
            onPressed: () {
              context.read<ThemeProvider>().toggleTheme();
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          // Latar belakang balok warna ungu di area atas profil
          Container(
            height: 220, // Ketinggian disesuaikan untuk mengakomodasi wilayah AppBar kustom
            width: double.infinity,
            color: Colors.deepPurple,
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                // 2. Membuat widget untuk menampilkan foto profil bulat
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 130, // Jarak disesuaikan ulang agar lingkaran foto pas menggantung di batas ungu
                    ),
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.white, // Border diganti PUTIH agar kontras dengan warna dasar ungu
                              width: 2,
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: const CircleAvatar(
                            radius: 50,
                            backgroundImage: AssetImage(
                              'images/placeholder_image.png',
                            ),
                          ),
                        ),
                        if (auth.isSignedIn)
                          Container(
                            decoration: const BoxDecoration(
                              color: Colors.deepPurple,
                              shape: BoxShape.circle,
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(4.0),
                              child: Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // 3. Menampilkan bagian informasi profil menggunakan data Provider
                // Latihan Mandiri 1: Mengambil nilai username langsung dari AuthProvider
                ProfileInfoItem(
                  icon: Icons.lock,
                  label: 'Pengguna',
                  value: auth.isSignedIn ? auth.username : 'Belum Sign In',
                  iconColor: Colors.amber,
                ),
                const SizedBox(height: 8),
                const Divider(color: Colors.grey, thickness: 0.5),

                ProfileInfoItem(
                  icon: Icons.person,
                  label: 'Nama',
                  value: auth.isSignedIn
                      ? auth.username
                      : '', // Menggunakan username sebagai nama tampilan
                  showEditIcon: auth.isSignedIn,
                  onEditPressed: () => debugPrint('Icon edit ditekan'),
                  iconColor: Colors.blue,
                ),
                const SizedBox(height: 8),
                const Divider(color: Colors.grey, thickness: 0.5),

                // Menampilkan jumlah total favorit candi secara real-time dari FavoriteProvider
                ProfileInfoItem(
                  icon: Icons.favorite,
                  label: 'Favorit',
                  value: favoriteCount > 0 ? '$favoriteCount' : '0',
                  iconColor: Colors.red,
                ),

                // 4. Membuat bagian tombol aksi Sign Out / Sign In dinamis
                const SizedBox(height: 4),
                const Divider(color: Colors.grey, thickness: 0.5),
                const SizedBox(height: 20),

                auth.isSignedIn
                    ? TextButton(
                        onPressed: () {
                          // Latihan Mandiri 2 & 3: Saat Sign Out, hapus semua favorit & ubah status autentikasi
                          context.read<FavoriteProvider>().clearAll();
                          context.read<AuthProvider>().signOut();
                        },
                        child: const Text(
                          'Sign Out',
                          style: TextStyle(color: Colors.red, fontSize: 16),
                        ),
                      )
                    : TextButton(
                        onPressed: () {
                          // Berpindah ke halaman SignInScreen ketika tombol Sign In ditekan
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const SignInScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          'Sign In',
                          style: TextStyle(
                            color: Colors.deepPurple,
                            fontSize: 16,
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
