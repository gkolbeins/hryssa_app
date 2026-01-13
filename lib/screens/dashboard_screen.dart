import 'package:flutter/material.dart';

/// ARCHIVED SCREEN
/// ------------------------------------------------------------
/// This screen was part of an early dashboard-based design.
/// It is NOT used in the current app flow.
///
/// Current flow:
/// StartScreen → MareListScreen → MareDetailScreen → MareFormScreen
///
/// The file is kept only for reference.
/// ------------------------------------------------------------

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard (ekki í notkun)'),
      ),
      body: const Center(
        child: Text(
          'Þessi skjár er hluti af eldri hönnun\n'
          'og er ekki í notkun lengur.',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
