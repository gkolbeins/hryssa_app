import 'package:flutter/material.dart';
import 'screens/start_screen.dart';
import 'screens/mare_detail_screen.dart';

void main() {
  runApp(const HryssaApp());
}

class HryssaApp extends StatelessWidget {
  const HryssaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hryssa App',
      theme: ThemeData(
        primarySwatch: Colors.brown,
        useMaterial3: true,
      ),
      home: const StartScreen(),
    );
  }
}
