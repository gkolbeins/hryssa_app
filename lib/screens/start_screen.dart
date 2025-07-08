import 'package:flutter/material.dart';
import 'dashboard_screen.dart'; // þetta er næsti skjár sem við förum í eftir "login"

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  void _fakeLogin(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (ctx) => const DashboardScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Hryssan mín',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown,
                  ),
                ),
                const SizedBox(height: 40),
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Netfang',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Lykilorð',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () => _fakeLogin(context),
                  child: const Text('Innskrá (mock)'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
