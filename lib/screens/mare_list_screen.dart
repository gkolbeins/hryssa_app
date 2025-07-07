import 'package:flutter/material.dart';
import '../models/mare.dart';
import '../widgets/mare_item.dart';
import 'mare_form_screen.dart';

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
  ),
];


  void _addNewMare(Mare mare) {
    setState(() {
      _mares.add(mare);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hryssur'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              final newMare = await Navigator.of(context).pushNamed(MareFormScreen.routeName) as Mare?;
              if (newMare != null) _addNewMare(newMare);
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _mares.length,
        itemBuilder: (ctx, i) => MareItem(mare: _mares[i]),
      ),
    );
  }
}