import 'package:flutter/material.dart';
import 'screens/start_screen.dart';

void main() {
  runApp(const HryssaApp());
}

class HryssaApp extends StatelessWidget {
  const HryssaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hryssa App',
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        useMaterial3: false,

        scaffoldBackgroundColor: const Color(0xFFF9F9FB),

        primaryColor: const Color(0xFF8E8DBE),

        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF8E8DBE),
          surface: const Color(0xFFF9F9FB),
        ),

        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          foregroundColor: Colors.black,
          centerTitle: true,
        ),

        textTheme: const TextTheme(
          titleLarge: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
          bodyMedium: TextStyle(
            fontSize: 14,
          ),
        ),

        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),

        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF8E8DBE),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(vertical: 14),
          ),
        ),

        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xFF8E8DBE),
          foregroundColor: Colors.white,
        ),
      ),

      home: const StartScreen(),
    );
  }
}
