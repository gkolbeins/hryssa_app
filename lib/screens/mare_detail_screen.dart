import 'package:flutter/material.dart';

class MareDetailScreen extends StatelessWidget {
  static const routeName = '/mare-detail';

  const MareDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Upplýsingar')),
      body: const Center(child: Text('Hér kemur pörun og vikuleg skoðun.')),
    );
  }
}