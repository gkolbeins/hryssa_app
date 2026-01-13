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
      _confirmedPregnancyDate =
          value ? (_confirmedPregnancyDate ?? DateTime.now()) : null;
    });
  }

  void _toggleNeedsVet(bool value) {
    setState(() => _needsVet = value);
  }

  void _goBackWithUpdateIfNeeded() {
    final updated = widget.mare.copyWith(
      isPregnant: _isPregnant,
      needsVet: _needsVet,
      confirmedPregnancyDate: _confirmedPregnancyDate,
    );

    if (updated != widget.mare) widget.onUpdate(updated);
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
        builder: (ctx) => MareFormScreen(
          existingMare: widget.mare,
          onSave: (mare) => Navigator.of(ctx).pop(mare),
        ),
      ),
    );

    if (updated != null) widget.onUpdate(updated);
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(label, style: const TextStyle(color: Colors.black54)),
          ),
          Expanded(
            flex: 5,
            child: Text(value),
          ),
        ],
      ),
    );
  }

  Widget _card(Widget child) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(20, 0, 0, 0),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final mare = widget.mare;

    return Scaffold(
      appBar: AppBar(title: const Text('Hryssa frá bæ')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ///nafn
            Text(
              mare.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),

            ///mynd
            if (mare.imagePath != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.file(
                  File(mare.imagePath!),
                  height: 160,
                  fit: BoxFit.cover,
                ),
              ),

            ///uppl um eiganda
            _card(Column(
              children: [
                _infoRow('IS-númer', mare.isNumber),
                _infoRow('Staðsetning', mare.location),
                if (mare.owner != null) _infoRow('Eigandi', mare.owner!),
                if (mare.phone != null) _infoRow('Sími', mare.phone!),
                if (mare.email != null) _infoRow('Netfang', mare.email!),
              ],
            )),

            ///staða
            _card(Column(
              children: [
                SwitchListTile(
                  title: const Text('Staðfest fyl'),
                  value: _isPregnant,
                  activeThumbColor: Colors.green,
                  onChanged: _togglePregnant,
                ),
                if (_isPregnant && _confirmedPregnancyDate != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      'Staðfest ${_confirmedPregnancyDate!.day}.'
                      '${_confirmedPregnancyDate!.month}.'
                      '${_confirmedPregnancyDate!.year}',
                      style: const TextStyle(fontSize: 13),
                    ),
                  ),
                SwitchListTile(
                  title: const Text('Þarf dýralækni'),
                  value: _needsVet,
                  activeThumbColor: Colors.red,
                  onChanged: _toggleNeedsVet,
                ),
              ],
            )),

            ///athugasemdir
            if (mare.comments != null && mare.comments!.isNotEmpty)
              _card(Text(
                mare.comments!,
                style: const TextStyle(fontStyle: FontStyle.italic),
              )),

            const SizedBox(height: 24),

            ///takkar
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _openEditMare,
                    child: const Text('Breyta'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton(
                    onPressed: _goBackWithUpdateIfNeeded,
                    child: const Text('Til baka'),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            TextButton.icon(
              onPressed: _confirmDelete,
              icon: const Icon(Icons.delete, color: Colors.red),
              label: const Text('Eyða hryssu',
                  style: TextStyle(color: Colors.red)),
            ),
          ],
        ),
      ),
    );
  }
}
