import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hryssa_app/widgets/mare_image.dart';
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
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() => _selectedImage = File(picked.path));
    }
  }

  Widget _card(Widget child) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
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

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    final mare = Mare(
      id: widget.existingMare?.id ?? DateTime.now().toString(),
      name: _nameController.text,
      isNumber: _isNumberController.text,
      location: _locationController.text,
      extraNumber1:
          _extraNumber1Controller.text.isNotEmpty ? _extraNumber1Controller.text : null,
      extraNumber2:
          _extraNumber2Controller.text.isNotEmpty ? _extraNumber2Controller.text : null,
      microchip:
          _microchipController.text.isNotEmpty ? _microchipController.text : null,
      imagePath: _selectedImage?.path,
      isPregnant: widget.existingMare?.isPregnant ?? false,
      needsVet: widget.existingMare?.needsVet ?? false,
      owner: _ownerController.text.isNotEmpty ? _ownerController.text : null,
      phone: _phoneController.text.isNotEmpty ? _phoneController.text : null,
      email: _emailController.text.isNotEmpty ? _emailController.text : null,
      comments: _commentsController.text.isNotEmpty ? _commentsController.text : null,
      confirmedPregnancyDate: widget.existingMare?.confirmedPregnancyDate,
    );

    widget.onSave(mare);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.existingMare != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Breyta hryssu' : 'Skrá nýja hryssu'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              ///mynd og nafn
              _card(Column(
                children: [
                  GestureDetector(
                    onTap: _pickImage,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: _selectedImage != null
                          ? MareImage(imagePath: _selectedImage?.path)
                          : MareImage(imagePath: _selectedImage?.path),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(labelText: 'Nafn'),
                    validator: (v) =>
                        v == null || v.isEmpty ? 'Vinsamlegast sláðu inn nafn' : null,
                  ),
                ],
              )),

              ///grunnuppl
              _card(Column(
                children: [
                  TextFormField(
                    controller: _isNumberController,
                    decoration: const InputDecoration(labelText: 'IS-númer'),
                    validator: (v) =>
                        v == null || v.isEmpty ? 'Vinsamlegast sláðu inn IS-númer' : null,
                  ),
                  TextFormField(
                    controller: _locationController,
                    decoration: const InputDecoration(labelText: 'Staðsetning'),
                  ),
                  TextFormField(
                    controller: _microchipController,
                    decoration: const InputDecoration(labelText: 'Örmerki'),
                    keyboardType: TextInputType.number,
                  ),
                  TextFormField(
                    controller: _extraNumber1Controller,
                    decoration: const InputDecoration(labelText: 'Annað nr. 1'),
                  ),
                  TextFormField(
                    controller: _extraNumber2Controller,
                    decoration: const InputDecoration(labelText: 'Annað nr. 2'),
                  ),
                ],
              )),

              ///eigandi og uppl
              _card(Column(
                children: [
                  TextFormField(
                    controller: _ownerController,
                    decoration: const InputDecoration(labelText: 'Eigandi'),
                  ),
                  TextFormField(
                    controller: _phoneController,
                    decoration: const InputDecoration(labelText: 'Sími'),
                    keyboardType: TextInputType.phone,
                  ),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(labelText: 'Netfang'),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  TextFormField(
                    controller: _commentsController,
                    decoration: const InputDecoration(labelText: 'Athugasemdir'),
                    maxLines: 3,
                  ),
                ],
              )),

              const SizedBox(height: 8),

              ///takkar
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Hætta við'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _submit,
                      child: const Text('Vista'),
                    ),
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
