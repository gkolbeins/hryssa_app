import 'dart:io';
import 'package:flutter/material.dart';
import '../models/mare.dart';
import 'mare_form_screen.dart';

class MareDetailScreen extends StatelessWidget {
  static const routeName = '/mare-detail';

  final Mare mare;
  final Function(Mare) onUpdate;
  final Function(Mare) onDelete;

  const MareDetailScreen({
    super.key,
    required this.mare,
    required this.onUpdate,
    required this.onDelete,
  });

  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Eyða hryssu'),
        content: const Text('Ertu viss um að þú viljir eyða þessari hryssu?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Hætta við'),
          ),
          TextButton(
            onPressed: () {
              onDelete(mare);
              Navigator.of(ctx).pop(); // loka glugga
              Navigator.of(context).pop(); // fara til baka
            },
            child: const Text('Eyða', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Upplýsingar')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(mare.name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('IS-númer: ${mare.isNumber}'),
            Text('Staðsetning: ${mare.location}'),
            if (mare.extraNumber1 != null) Text('Annað nr. 1: ${mare.extraNumber1}'),
            if (mare.extraNumber2 != null) Text('Annað nr. 2: ${mare.extraNumber2}'),
            if (mare.microchip != null) Text('Örmerki: ${mare.microchip}'),
            const SizedBox(height: 8),
            if (mare.isPregnant) const Text('✔ Fylfull', style: TextStyle(color: Colors.green)),
            if (mare.needsVet) const Text('⚠ Þarf dýralækni', style: TextStyle(color: Colors.pink)),

            const SizedBox(height: 12),
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image(
                  image: mare.imagePath != null
                      ? FileImage(File(mare.imagePath!))
                      : const AssetImage('assets/images/dummy_mare.png') as ImageProvider,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const Spacer(),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () async {
                    final updated = await Navigator.of(context).push<Mare>(
                      MaterialPageRoute(
                        builder: (newContext) => MareFormScreen(
                          existingMare: mare,
                          onSave: (newMare) {
                            Navigator.of(newContext).pop(newMare); // ✅ rétt context
                          },
                        ),
                      ),
                    );
                    if (updated != null) {
                      onUpdate(updated);
                    }
                  },
                  icon: const Icon(Icons.edit),
                  label: const Text('Breyta'),
                ),
                ElevatedButton.icon(
                  onPressed: () => _confirmDelete(context),
                  icon: const Icon(Icons.delete),
                  label: const Text('Eyða'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
