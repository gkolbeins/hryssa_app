import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../models/mare.dart';

class MareFormScreen extends StatefulWidget {
  final Function(Mare) onSave;
  final Mare? existingMare;

  const MareFormScreen({
    super.key,
    required this.onSave,
    this.existingMare,
  });

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
  final _ownerController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _commentsController = TextEditingController();

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
      _ownerController.text = mare.owner ?? '';
      _phoneController.text = mare.phone ?? '';
      _emailController.text = mare.email ?? '';
      _commentsController.text = mare.comments ?? '';
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
      owner: _ownerController.text.isNotEmpty ? _ownerController.text : null,
      phone: _phoneController.text.isNotEmpty ? _phoneController.text : null,
      email: _emailController.text.isNotEmpty ? _emailController.text : null,
      comments: _commentsController.text.isNotEmpty ? _commentsController.text : null,
      confirmedPregnancyDate: widget.existingMare?.confirmedPregnancyDate,
    );

    widget.onSave(newMare);
    Navigator.of(context).pop(); // Fer aftur á listann
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.existingMare != null ? 'Breyta hryssu' : 'Skrá nýja hryssu'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(),
          tooltip: 'Hætta við',
        ),
      ),
      body: SingleChildScrollView(
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
              TextFormField(
                controller: _ownerController,
                decoration: const InputDecoration(labelText: 'Eigandi'),
              ),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(labelText: 'Símanúmer'),
                keyboardType: TextInputType.phone,
              ),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Netfang'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) return null;
                  final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                  return emailRegex.hasMatch(value) ? null : 'Netfang ekki gilt';
                },
              ),
              TextFormField(
                controller: _commentsController,
                decoration: const InputDecoration(labelText: 'Athugasemdir'),
                maxLines: 3,
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

              const SizedBox(height: 24),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton.icon(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close),
                    label: const Text('Hætta við'),
                  ),
                  ElevatedButton.icon(
                    onPressed: _submit,
                    icon: const Icon(Icons.save),
                    label: const Text('Vista hryssu'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
