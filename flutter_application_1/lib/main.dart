import 'package:flutter/material.dart';
// import 'package:flutter_application_1/data/candi_data.dart';
// import 'package:flutter_application_1/screens/detail_screen.dart';
// import 'package:flutter_application_1/screens/profile_screen.dart';
// import 'package:flutter_application_1/screens/sign_in_screen.dart';
import 'package:flutter_application_1/screens/sign_up_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wisata Candi',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(color: Colors.deepPurple),
          titleTextStyle: TextStyle(
            color: Colors.deepPurple,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ).copyWith(primary: Colors.deepPurple, surface: Colors.deepPurple[50]),
        useMaterial3: true,
      ),
      // home: DetailScreen(candi: candiList[2]),
      home: const SignUpScreen(),
    );
  }
}
