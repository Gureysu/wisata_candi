import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:provider/provider.dart'; // Wajib diimport untuk berinteraksi dengan Provider

// Import AuthProvider untuk menyimpan data login secara global
import 'package:flutter_application_1/providers/auth_provider.dart';
// Wajib diimport agar Navigator bisa mengenali dan membuka halaman SignUpScreen
import 'package:flutter_application_1/screens/sign_up_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  // TODO 1: Deklarasikan variabel
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String _errorText = '';
  // _isSignedIn dinonaktifkan di sini karena statusnya sekarang dikelola global oleh AuthProvider
  bool _obscurePassword = true;

  // Fungsi penanganan proses login berdasarkan materi halaman 24 (diperketat dengan validasi password)
  void _handleSignIn() {
    final name = _usernameController.text.trim();
    final password = _passwordController.text.trim();

    // Perbaikan Validasi Poin 1: Cek nama DAN password sekaligus
    if (name.isEmpty || password.isEmpty) {
      setState(() {
        _errorText = 'Nama pengguna dan kata sandi wajib diisi!';
      });
      return;
    }

    // Mengosongkan pesan error jika inputan valid
    setState(() {
      _errorText = '';
    });

    // 1. Kirim data username ke AuthProvider menggunakan context.read
    context.read<AuthProvider>().signIn(name);

    // 2. Tutup layar login dan kembali ke ProfileScreen otomatis
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // TODO 2: Pasang AppBar
      appBar: AppBar(title: const Text('Sign In')),

      // TODO 3: Pasang body
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              child: Column(
                // TODO 4: Atur alignment
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Menampilkan teks pemberitahuan error visual di layar jika ada kolom kosong
                  if (_errorText.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Text(
                        _errorText,
                        style: const TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                  // TODO 5: TextFormField nama pengguna
                  TextFormField(
                    controller: _usernameController,
                    decoration: const InputDecoration(
                      labelText: 'Nama Pengguna',
                      border: OutlineInputBorder(),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // TODO 6: TextFormField kata sandi
                  TextFormField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      labelText: 'Kata Sandi',
                      // Agar border inputan ikut memerah saat ada error, berikan errorText langsung pada dekorasi
                      errorText: _errorText.isNotEmpty ? '' : null,
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                        onPressed: () {
                          // Contoh penggunaan Ephemeral State bawaan layar (cukup setState)
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                      ),
                    ),
                  ),

                  // TODO 7: ElevatedButton Sign In
                  const SizedBox(height: 20),

                  ElevatedButton(
                    onPressed: _handleSignIn, // Memanggil fungsi login saat tombol ditekan
                    child: const Text('Sign In'),
                  ),

                  // TODO 8: TextButton Sign Up
                  const SizedBox(height: 18),
                  RichText(
                    text: TextSpan(
                      text: 'Belum punya akun? ',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.deepPurple,
                      ),
                      children: [
                        TextSpan(
                          text: 'Daftar di sini.',
                          style: const TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                          // Perbaikan Poin 2: Mengaktifkan fungsi navigasi ketika teks diklik
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const SignUpScreen(),
                                ),
                              );
                            },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
