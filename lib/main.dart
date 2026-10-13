import 'package:flutter/material.dart';
import 'package:wisata_candi/Screens/detail_screen.dart';
import 'package:wisata_candi/data-20261013T030814Z-1-001/data/candi_data.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'wisata_candi',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:DetailScreen(candi: candiList[0]),
    );
  }
}
