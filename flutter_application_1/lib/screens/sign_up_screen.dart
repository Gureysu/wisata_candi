import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:provider/provider.dart'; // Wajib diimport untuk berinteraksi dengan Provider

// Import AuthProvider untuk mengubah status login pengguna setelah berhasil mendaftar
import 'package:flutter_application_1/providers/auth_provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  // TODO 1: Deklarasikan variabel
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _fullnameController = TextEditingController();

  String _errorText = '';
  // _isSignedUp dinonaktifkan karena alurnya langsung diarahkan masuk menggunakan AuthProvider global
  bool _obscurePassword = true;

  // Fungsi penanganan proses pendaftaran (Sign Up)
  void _handleSignUp() {
    final fullName = _fullnameController.text.trim();
    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();

    // Validasi input sederhana
    if (fullName.isEmpty || username.isEmpty || password.isEmpty) {
      setState(() {
        _errorText = 'Semua kolom formulir harus diisi!';
      });
      return;
    }

    setState(() {
      _errorText = '';
    });

    // Otomatis membuat pengguna langsung masuk (Sign In) menggunakan nama yang didaftarkan
    context.read<AuthProvider>().signIn(username);

    // Kembali ke layar sebelumnya (ProfileScreen) dengan status sudah masuk
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _fullnameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // TODO 2: Pasang AppBar
      appBar: AppBar(title: const Text('Sign Up')),

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
                  // Menampilkan pesan error validasi di atas jika ada
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

                  // TODO 5: TextFormField nama lengkap
                  TextFormField(
                    controller: _fullnameController,
                    decoration: const InputDecoration(
                      labelText: 'Nama Lengkap',
                      border: OutlineInputBorder(),
                    ),
                  ),

                  const SizedBox(height: 20),

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

                  // TODO 7: ElevatedButton Sign Up
                  const SizedBox(height: 20),

                  ElevatedButton(
                    onPressed: _handleSignUp, // Memanggil fungsi pendaftaran saat ditekan
                    child: const Text('Sign Up'),
                  ),

                  // TODO 8: TextButton Menuju Sign In jika sudah punya akun
                  const SizedBox(height: 10),
                  RichText(
                    text: TextSpan(
                      text: 'Sudah punya akun? ',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.deepPurple,
                      ),
                      children: [
                        TextSpan(
                          text: 'Masuk di sini.',
                          style: const TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              // Kembali ke layar sebelumnya (Layar Sign In)
                              Navigator.pop(context);
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
