import 'package:flutter/material.dart';
import '../core/app_images.dart';
import 'mare_list_screen.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  void _mockLogin(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const MareListScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ///logo
                Image.asset(
                  AppImages.dummyMare,
                  height: 120,
                  fit: BoxFit.contain,
                ),

                const SizedBox(height: 24),

                ///titill
                const Text(
                  'Hryssa App',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 48),

                ///email
                const TextField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'Netfang',
                  ),
                ),

                const SizedBox(height: 16),

                ///lykilorð
                const TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Lykilorð',
                  ),
                ),

                const SizedBox(height: 32),

                ///innskrá
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => _mockLogin(context),
                    child: const Text('Innskrá'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
