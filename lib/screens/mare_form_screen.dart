import 'package:flutter/material.dart';
import '../models/mare.dart';

class MareFormScreen extends StatefulWidget {
  static const routeName = '/add-mare';

  const MareFormScreen({super.key});

  @override
  State<MareFormScreen> createState() => _MareFormScreenState();
}

class _MareFormScreenState extends State<MareFormScreen> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _isNumber = '';
  String _location = '';
  bool _needsVet = false;

  void _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final newMare = Mare(
        id: DateTime.now().toString(),
        name: _name,
        isNumber: _isNumber,
        location: _location,
        needsVet: _needsVet,
      );

      Navigator.of(context).pop(newMare);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Skrá nýja hryssu')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Nafn'),
                onSaved: (value) => _name = value ?? '',
                validator: (value) =>
                    value == null || value.isEmpty ? 'Settu inn nafn' : null,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'IS-númer'),
                keyboardType: TextInputType.text,
                onSaved: (value) => _isNumber = value ?? '',
                validator: (value) {
                  if (value == null || value.length != 13 || !value.startsWith('IS')) {
                    return 'IS-númer þarf að vera 13 stafir og byrja á IS';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Staðsetning'),
                onSaved: (value) => _location = value ?? '',
              ),
              SwitchListTile(
                title: const Text('Þarfnast dýralæknis'),
                value: _needsVet,
                onChanged: (val) => setState(() => _needsVet = val),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submit,
                child: const Text('Vista'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
