import 'dart:io';
import 'package:flutter/material.dart';
import '../models/mare.dart';
import 'mare_form_screen.dart';

class MareDetailScreen extends StatefulWidget {
  final Mare mare;
  final Function(Mare) onUpdate;
  final Function(Mare) onDelete;

  const MareDetailScreen({
    super.key,
    required this.mare,
    required this.onUpdate,
    required this.onDelete,
  });

  @override
  State<MareDetailScreen> createState() => _MareDetailScreenState();
}

class _MareDetailScreenState extends State<MareDetailScreen> {
  late bool _isPregnant;
  late bool _needsVet;
  DateTime? _confirmedPregnancyDate;

  @override
  void initState() {
    super.initState();
    _isPregnant = widget.mare.isPregnant;
    _needsVet = widget.mare.needsVet;
    _confirmedPregnancyDate = widget.mare.confirmedPregnancyDate;
  }

  void _togglePregnant(bool value) {
    setState(() {
      _isPregnant = value;
      if (value && _confirmedPregnancyDate == null) {
        _confirmedPregnancyDate = DateTime.now();
      }
      if (!value) {
        _confirmedPregnancyDate = null;
      }
    });
  }

  void _toggleNeedsVet(bool value) {
    setState(() {
      _needsVet = value;
    });
  }

  void _goBackWithUpdateIfNeeded() {
    final updated = widget.mare.copyWith(
      isPregnant: _isPregnant,
      needsVet: _needsVet,
      confirmedPregnancyDate: _confirmedPregnancyDate,
    );

    if (updated != widget.mare) {
      widget.onUpdate(updated);
    }

    Navigator.of(context).pop();
  }

  void _confirmDelete() {
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
              widget.onDelete(widget.mare);
              Navigator.of(ctx).pop();
              Navigator.of(context).pop();
            },
            child: const Text('Eyða', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _openEditMare() async {
    final updated = await Navigator.of(context).push<Mare>(
      MaterialPageRoute(
        builder: (newCtx) => MareFormScreen(
          existingMare: widget.mare,
          onSave: (updatedMare) {
            Navigator.of(newCtx).pop(updatedMare);
          },
        ),
      ),
    );

    if (updated != null) {
      widget.onUpdate(updated);
    }
  }

  @override
  Widget build(BuildContext context) {
    final mare = widget.mare;

    return Scaffold(
      appBar: AppBar(title: const Text('Upplýsingar um hryssu')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // === Nafn og helstu upplýsingar ===
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  mare.name,
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 6),
                Text(mare.isNumber, style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 6),
                if (mare.microchip != null)
                  Text('Örmerki: ${mare.microchip!}'),
                if (mare.owner != null)
                  Text('Eigandi: ${mare.owner!}'),
                if (mare.phone != null)
                  Text('Sími: ${mare.phone!}'),
                if (mare.email != null)
                  Text('Netfang: ${mare.email!}'),
                if (mare.location.isNotEmpty)
                  Text('Staðsetning: ${mare.location}'),
                if (mare.extraNumber1 != null)
                  Text('Annað nr. 1: ${mare.extraNumber1}'),
                if (mare.extraNumber2 != null)
                  Text('Annað nr. 2: ${mare.extraNumber2}'),
              ],
            ),

            const SizedBox(height: 20),

            // === Mynd af hryssu ===
            if (mare.imagePath != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.file(
                    File(mare.imagePath!),
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

            // === Fyl og dýralæknisstatus ===
            SwitchListTile(
              title: const Text('Staðfest fyl'),
              value: _isPregnant,
              activeColor: Colors.green,
              onChanged: _togglePregnant,
            ),
            if (_isPregnant && _confirmedPregnancyDate != null)
              Padding(
                padding: const EdgeInsets.only(left: 16, bottom: 12),
                child: Row(
                  children: [
                    const Icon(Icons.calendar_today, size: 18),
                    const SizedBox(width: 8),
                    Text(
                      'Staðfest: ${_confirmedPregnancyDate!.day}.${_confirmedPregnancyDate!.month}.${_confirmedPregnancyDate!.year}',
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
            SwitchListTile(
              title: const Text('Þarf dýralækni'),
              value: _needsVet,
              activeColor: Colors.red,
              onChanged: _toggleNeedsVet,
            ),

            const SizedBox(height: 12),

            // === Athugasemdir ===
            if (mare.comments != null && mare.comments!.isNotEmpty)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.only(top: 8),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey[100],
                ),
                child: Text(
                  mare.comments!,
                  style: const TextStyle(fontSize: 15, fontStyle: FontStyle.italic),
                ),
              ),

            const Spacer(),

            // === Hnappar ===
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
                  onPressed: _openEditMare,
                  icon: const Icon(Icons.edit),
                  label: const Text('Breyta'),
                ),
                ElevatedButton.icon(
                  onPressed: _goBackWithUpdateIfNeeded,
                  icon: const Icon(Icons.arrow_back),
                  label: const Text('Til baka'),
                ),
                ElevatedButton.icon(
                  onPressed: _confirmDelete,
                  icon: const Icon(Icons.delete),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                  label: const Text('Eyða'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
