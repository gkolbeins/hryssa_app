import 'package:flutter/material.dart';
import '../models/mare.dart';
import '../widgets/mare_image.dart';
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
  late bool _pregnancyConfirmed;
  late bool _needsVet;
  DateTime? _pregnancyConfirmedAt;

  @override
  void initState() {
    super.initState();
    _pregnancyConfirmed = widget.mare.pregnancyConfirmed;
    _needsVet = widget.mare.needsVet;
    _pregnancyConfirmedAt = widget.mare.pregnancyConfirmedAt;
  }

  void _togglePregnancy(bool value) {
    setState(() {
      _pregnancyConfirmed = value;
      _pregnancyConfirmedAt =
          value ? (_pregnancyConfirmedAt ?? DateTime.now()) : null;
    });
  }

  void _toggleNeedsVet(bool value) {
    setState(() => _needsVet = value);
  }

  void _goBackWithUpdateIfNeeded() {
    final updated = widget.mare.copyWith(
      pregnancyConfirmed: _pregnancyConfirmed,
      pregnancyConfirmedAt: _pregnancyConfirmedAt,
      needsVet: _needsVet,
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
      appBar: AppBar(title: const Text('Upplýsingar um hryssu')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              mare.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),

            MareImage(imagePath: mare.imagePath),

            _card(Column(
              children: [
                if (mare.isNumber != null)
                  _infoRow('IS-númer', mare.isNumber!),
                if (mare.location != null)
                  _infoRow('Staðsetning', mare.location!),
                if (mare.ownerName != null)
                  _infoRow('Eigandi', mare.ownerName!),
                if (mare.ownerPhone != null)
                  _infoRow('Sími', mare.ownerPhone!),
                if (mare.ownerEmail != null)
                  _infoRow('Netfang', mare.ownerEmail!),
              ],
            )),

            _card(Column(
              children: [
                SwitchListTile(
                  title: const Text('Staðfest fyl'),
                  value: _pregnancyConfirmed,
                  activeThumbColor: Colors.green,
                  onChanged: _togglePregnancy,
                ),
                if (_pregnancyConfirmed && _pregnancyConfirmedAt != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      'Staðfest '
                      '${_pregnancyConfirmedAt!.day}.'
                      '${_pregnancyConfirmedAt!.month}.'
                      '${_pregnancyConfirmedAt!.year}',
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

            if (mare.notes != null && mare.notes!.isNotEmpty)
              _card(Text(
                mare.notes!,
                style: const TextStyle(fontStyle: FontStyle.italic),
              )),

            const SizedBox(height: 24),

            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _openEditMare,
                    child: const Text('Breyta'),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            TextButton.icon(
              onPressed: _confirmDelete,
              icon: const Icon(Icons.delete, color: Colors.red),
              label: const Text(
                'Eyða hryssu',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
