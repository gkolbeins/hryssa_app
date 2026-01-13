import 'package:flutter/material.dart';
import '../models/mare.dart';
import '../widgets/mare_item.dart';
import 'mare_form_screen.dart';
import 'mare_detail_screen.dart';

class MareListScreen extends StatefulWidget {
  const MareListScreen({super.key});

  @override
  State<MareListScreen> createState() => _MareListScreenState();
}

class _MareListScreenState extends State<MareListScreen> {
  final List<Mare> _mares = [
    Mare(
      id: '1',
      name: 'Spóla frá Hraunbæ',
      isNumber: 'IS2008285431',
      location: 'Nykhóll',
    ),
    Mare(
      id: '2',
      name: 'Aþena frá Nykhól',
      isNumber: 'IS2019285633',
      location: 'Eyjarhólar',
      needsVet: true,
      isPregnant: true,
    ),
  ];

  String _searchQuery = '';

  List<Mare> get _filteredMares {
    if (_searchQuery.isEmpty) return _mares;

    return _mares.where((mare) {
      return mare.name
              .toLowerCase()
              .contains(_searchQuery.toLowerCase()) ||
          mare.isNumber
              .toLowerCase()
              .contains(_searchQuery.toLowerCase()) ||
          mare.location
              .toLowerCase()
              .contains(_searchQuery.toLowerCase());
    }).toList();
  }

  void _addNewMare(Mare mare) {
    setState(() {
      _mares.add(mare);
    });
  }

  void _updateMare(Mare updatedMare) {
    setState(() {
      final index = _mares.indexWhere((m) => m.id == updatedMare.id);
      if (index != -1) {
        _mares[index] = updatedMare;
      }
    });
  }

  void _deleteMare(Mare mare) {
    setState(() {
      _mares.removeWhere((m) => m.id == mare.id);
    });
  }

  void _openMareDetail(Mare mare) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => MareDetailScreen(
          mare: mare,
          onUpdate: _updateMare,
          onDelete: _deleteMare,
        ),
      ),
    );
  }

  Future<void> _openNewMareForm() async {
    final newMare = await Navigator.of(context).push<Mare>(
      MaterialPageRoute(
        builder: (ctx) => MareFormScreen(
          onSave: (mare) {
            Navigator.of(ctx).pop(mare);
          },
        ),
      ),
    );

    if (newMare != null) _addNewMare(newMare);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hryssur'),
      ),
      body: Column(
        children: [
          ///leit
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Leita...',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),

          ///listi
          Expanded(
            child: _filteredMares.isEmpty
                ? const Center(
                    child: Text(
                      'Engar niðurstöður',
                      style: TextStyle(color: Colors.black54),
                    ),
                  )
                : ListView.builder(
                    itemCount: _filteredMares.length,
                    itemBuilder: (ctx, i) => MareItem(
                      mare: _filteredMares[i],
                      onTap: _openMareDetail,
                    ),
                  ),
          ),
        ],
      ),

      ///skrá nýja hryssu takki
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _openNewMareForm,
        label: const Text('Skrá nýja hryssu'),
        icon: const Icon(Icons.add),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.centerFloat,
    );
  }
}
