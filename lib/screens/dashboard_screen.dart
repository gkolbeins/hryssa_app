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

  Widget _buildContent() {
    if (_showList) {
      return Expanded(
        child: ListView.builder(
          itemCount: _mares.length,
          itemBuilder: (ctx, i) => MareItem(
            mare: _mares[i],
            onTap: _openMareDetail,
          ),
        ),
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
          _buildContent(),
        ],
      ),
    );
  }
}
