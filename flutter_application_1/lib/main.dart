import 'package:flutter/material.dart';
// import 'package:flutter_application_1/data/candi_data.dart';
// import 'package:flutter_application_1/screens/detail_screen.dart';
import 'package:flutter_application_1/screens/profile_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wisata Candi',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: DetailScreen(candi: candiList[2]),
      home: ProfileScreen( ),
    );
  }
}
