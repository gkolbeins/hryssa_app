import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../models/mare.dart';

class MareFormScreen extends StatefulWidget {
  final Function(Mare) onSave;
  final Mare? existingMare;

  const MareFormScreen({super.key, required this.onSave, this.existingMare});

  @override
  State<MareFormScreen> createState() => _MareFormScreenState();
}

class _MareFormScreenState extends State<MareFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _isNumberController = TextEditingController();
  final _locationController = TextEditingController();
  final _extraNumber1Controller = TextEditingController();
  final _extraNumber2Controller = TextEditingController();
  final _microchipController = TextEditingController();
  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    final mare = widget.existingMare;
    if (mare != null) {
      _nameController.text = mare.name;
      _isNumberController.text = mare.isNumber;
      _locationController.text = mare.location;
      _extraNumber1Controller.text = mare.extraNumber1 ?? '';
      _extraNumber2Controller.text = mare.extraNumber2 ?? '';
      _microchipController.text = mare.microchip ?? '';
      if (mare.imagePath != null) _selectedImage = File(mare.imagePath!);
    }
  }

  void _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    final newMare = Mare(
      id: widget.existingMare?.id ?? DateTime.now().toString(),
      name: _nameController.text,
      isNumber: _isNumberController.text,
      location: _locationController.text,
      extraNumber1: _extraNumber1Controller.text.isNotEmpty ? _extraNumber1Controller.text : null,
      extraNumber2: _extraNumber2Controller.text.isNotEmpty ? _extraNumber2Controller.text : null,
      microchip: _microchipController.text.isNotEmpty ? _microchipController.text : null,
      imagePath: _selectedImage?.path,
      isPregnant: widget.existingMare?.isPregnant ?? false,
      needsVet: widget.existingMare?.needsVet ?? false,
    );

    widget.onSave(newMare);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      // 🔧 Þetta tryggir að allt fái material context (t.d. text fields)
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nafn'),
                validator: (value) => value!.isEmpty ? 'Vinsamlegast sláðu inn nafn' : null,
              ),
              TextFormField(
                controller: _isNumberController,
                decoration: const InputDecoration(labelText: 'IS-númer'),
                validator: (value) => value!.isEmpty ? 'Vinsamlegast sláðu inn IS-númer' : null,
              ),
              TextFormField(
                controller: _locationController,
                decoration: const InputDecoration(labelText: 'Staðsetning'),
              ),
              TextFormField(
                controller: _extraNumber1Controller,
                decoration: const InputDecoration(labelText: 'Annað nr. 1'),
                maxLength: 8,
              ),
              TextFormField(
                controller: _extraNumber2Controller,
                decoration: const InputDecoration(labelText: 'Annað nr. 2'),
                maxLength: 8,
              ),
              TextFormField(
                controller: _microchipController,
                decoration: const InputDecoration(labelText: 'Örmerki'),
                keyboardType: TextInputType.number,
                maxLength: 15,
              ),
              const SizedBox(height: 12),
              Image(
                image: _selectedImage != null
                    ? FileImage(_selectedImage!)
                    : const AssetImage('assets/images/dummy_mare.png') as ImageProvider,
                height: 150,
              ),
              ElevatedButton.icon(
                onPressed: _pickImage,
                icon: const Icon(Icons.image),
                label: const Text('Velja mynd'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submit,
                child: const Text('Vista hryssu'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
