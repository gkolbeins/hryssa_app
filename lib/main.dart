import 'package:flutter/material.dart';
import 'screens/mare_list_screen.dart';
import 'screens/mare_form_screen.dart';
import 'screens/mare_detail_screen.dart';
import 'models/mare.dart';

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
      home: const MareListScreen(),
      routes: {
        MareFormScreen.routeName: (ctx) => const MareFormScreen(),
        MareDetailScreen.routeName: (ctx) => const MareDetailScreen(),
      },
    );
  }
}