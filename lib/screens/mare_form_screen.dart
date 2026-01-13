import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../models/mare.dart';
import '../widgets/mare_image.dart';

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
  final _otherInfo1Controller = TextEditingController();
  final _otherInfo2Controller = TextEditingController();
  final _chipIdController = TextEditingController();
  final _ownerNameController = TextEditingController();
  final _ownerPhoneController = TextEditingController();
  final _ownerEmailController = TextEditingController();
  final _notesController = TextEditingController();

  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    final mare = widget.existingMare;
    if (mare != null) {
      _nameController.text = mare.name;
      _isNumberController.text = mare.isNumber ?? '';
      _locationController.text = mare.location ?? '';
      _otherInfo1Controller.text = mare.otherInfo1 ?? '';
      _otherInfo2Controller.text = mare.otherInfo2 ?? '';
      _chipIdController.text = mare.chipId ?? '';
      _ownerNameController.text = mare.ownerName ?? '';
      _ownerPhoneController.text = mare.ownerPhone ?? '';
      _ownerEmailController.text = mare.ownerEmail ?? '';
      _notesController.text = mare.notes ?? '';
      if (mare.imagePath != null) {
        _selectedImage = File(mare.imagePath!);
      }
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

    final isEditing = widget.existingMare != null;

    final mare = Mare(
      id: widget.existingMare?.id ?? DateTime.now().toIso8601String(),
      ownerId: widget.existingMare?.ownerId ?? 'TEMP_OWNER_ID',
      createdAt: widget.existingMare?.createdAt ?? DateTime.now(),

      name: _nameController.text,
      isNumber: _isNumberController.text.isNotEmpty
          ? _isNumberController.text
          : null,
      chipId: _chipIdController.text.isNotEmpty
          ? _chipIdController.text
          : null,

      currentPaddockId: widget.existingMare?.currentPaddockId,
      currentStallionId: widget.existingMare?.currentStallionId,

      needsVet: widget.existingMare?.needsVet ?? false,
      pregnancyConfirmed:
          widget.existingMare?.pregnancyConfirmed ?? false,
      pregnancyConfirmedAt:
          widget.existingMare?.pregnancyConfirmedAt,

      arrivalDate: widget.existingMare?.arrivalDate,

      ownerName: _ownerNameController.text.isNotEmpty
          ? _ownerNameController.text
          : null,
      ownerPhone: _ownerPhoneController.text.isNotEmpty
          ? _ownerPhoneController.text
          : null,
      ownerEmail: _ownerEmailController.text.isNotEmpty
          ? _ownerEmailController.text
          : null,

      notes:
          _notesController.text.isNotEmpty ? _notesController.text : null,
      otherInfo1: _otherInfo1Controller.text.isNotEmpty
          ? _otherInfo1Controller.text
          : null,
      otherInfo2: _otherInfo2Controller.text.isNotEmpty
          ? _otherInfo2Controller.text
          : null,

      location: _locationController.text.isNotEmpty
          ? _locationController.text
          : null,

      imagePath: _selectedImage?.path,
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
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _card(Column(
                children: [
                  GestureDetector(
                    onTap: _pickImage,
                    child: MareImage(imagePath: _selectedImage?.path),
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

              _card(Column(
                children: [
                  TextFormField(
                    controller: _isNumberController,
                    decoration: const InputDecoration(labelText: 'IS-númer'),
                  ),
                  TextFormField(
                    controller: _locationController,
                    decoration: const InputDecoration(labelText: 'Staðsetning'),
                  ),
                  TextFormField(
                    controller: _chipIdController,
                    decoration: const InputDecoration(labelText: 'Örmerki'),
                  ),
                  TextFormField(
                    controller: _otherInfo1Controller,
                    decoration:
                        const InputDecoration(labelText: 'Annað nr. 1'),
                  ),
                  TextFormField(
                    controller: _otherInfo2Controller,
                    decoration:
                        const InputDecoration(labelText: 'Annað nr. 2'),
                  ),
                ],
              )),

              _card(Column(
                children: [
                  TextFormField(
                    controller: _ownerNameController,
                    decoration: const InputDecoration(labelText: 'Eigandi'),
                  ),
                  TextFormField(
                    controller: _ownerPhoneController,
                    decoration: const InputDecoration(labelText: 'Sími'),
                  ),
                  TextFormField(
                    controller: _ownerEmailController,
                    decoration: const InputDecoration(labelText: 'Netfang'),
                  ),
                  TextFormField(
                    controller: _notesController,
                    decoration:
                        const InputDecoration(labelText: 'Athugasemdir'),
                    maxLines: 3,
                  ),
                ],
              )),

              const SizedBox(height: 12),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submit,
                  child: const Text('Vista'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
