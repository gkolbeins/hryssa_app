import 'package:flutter/material.dart';
import '../models/mare.dart';
import '../screens/mare_detail_screen.dart';

class MareItem extends StatelessWidget {
  final Mare mare;

  const MareItem({super.key, required this.mare});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(mare.name),
      subtitle: Text('${mare.isNumber} – ${mare.location}'),
      trailing: mare.needsVet ? const Icon(Icons.warning, color: Colors.red) : null,
      onTap: () {
        Navigator.of(context).pushNamed(MareDetailScreen.routeName);
      },
    );
  }
}