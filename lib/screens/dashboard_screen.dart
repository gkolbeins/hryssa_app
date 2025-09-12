import 'package:flutter/material.dart';
import '../models/mare.dart';
import '../widgets/mare_item.dart';
import 'mare_form_screen.dart';
import 'mare_detail_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool _showList = true;
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  final List<Mare> _mares = [
    Mare(
      id: '1',
      name: 'Spóla frá Hraunbæ',
      isNumber: 'IS2008285431',
      location: 'Nykhóll',
      owner: 'Anna Jónsdóttir',
      phone: '5551234',
      email: 'anna@example.com',
    ),
    Mare(
      id: '2',
      name: 'Aþena frá Nykhól',
      isNumber: 'IS2019285633',
      location: 'Eyjarhólar',
      needsVet: true,
      owner: 'Guðrún Ósk',
      phone: '5554321',
      email: 'gudrun@example.com',
    ),
  ];

  void _addNewMare(Mare mare) {
    setState(() {
      _mares.add(mare);
      _showList = true;
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

  void _openMareDetail(Mare mare) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => MareDetailScreen(
          mare: mare,
          onUpdate: _updateMare,
          onDelete: _deleteMare,
        ),
      ),
    );
  }

  Widget _buildTopButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: _showList ? Colors.brown : Colors.grey[300],
            foregroundColor: _showList ? Colors.white : Colors.black,
          ),
          onPressed: () => setState(() => _showList = true),
          child: const Text('Skráðar hryssur'),
        ),
        const SizedBox(width: 8),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: !_showList ? Colors.brown : Colors.grey[300],
            foregroundColor: !_showList ? Colors.white : Colors.black,
          ),
          onPressed: () => setState(() => _showList = false),
          child: const Text('Skrá nýja'),
        ),
      ],
    );
  }

  Widget _buildSearchField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          labelText: 'Leita...',
          prefixIcon: const Icon(Icons.search),
          suffixIcon: _searchQuery.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                    setState(() => _searchQuery = '');
                  },
                )
              : null,
          border: const OutlineInputBorder(),
        ),
        onChanged: (value) {
          setState(() {
            _searchQuery = value;
          });
        },
      ),
    );
  }

  Widget _buildMareList() {
    final filtered = _mares.where((mare) {
      final query = _searchQuery.toLowerCase();
      return mare.name.toLowerCase().contains(query) ||
          mare.isNumber.toLowerCase().contains(query) ||
          (mare.extraNumber1?.toLowerCase().contains(query) ?? false) ||
          (mare.extraNumber2?.toLowerCase().contains(query) ?? false) ||
          (mare.microchip?.toLowerCase().contains(query) ?? false) ||
          (mare.owner?.toLowerCase().contains(query) ?? false) ||
          (mare.phone?.toLowerCase().contains(query) ?? false) ||
          (mare.email?.toLowerCase().contains(query) ?? false);
    }).toList();

    if (filtered.isEmpty) {
      return const Expanded(
        child: Center(child: Text('Ekkert fannst')),
      );
    }

    return Expanded(
      child: ListView.builder(
        itemCount: filtered.length,
        itemBuilder: (ctx, i) => MareItem(
          mare: filtered[i],
          onTap: _openMareDetail,
        ),
      ),
    );
  }

  Widget _buildContent() {
    if (_showList) {
      return Column(
        children: [
          _buildSearchField(),
          const SizedBox(height: 12),
          _buildMareList(),
        ],
      );
    } else {
      return Expanded(
        child: MareFormScreen(
          onSave: _addNewMare,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mínar hryssur')),
      body: Column(
        children: [
          const SizedBox(height: 16),
          _buildTopButtons(),
          const SizedBox(height: 16),
          Expanded(child: _buildContent()),
        ],
      ),
    );
  }
}
