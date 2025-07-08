import 'package:flutter/material.dart';
import '../models/mare.dart';

class MareItem extends StatelessWidget {
  final Mare mare;
  final Function(Mare) onTap;

  const MareItem({super.key, required this.mare, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(mare.name),
      subtitle: Text('${mare.isNumber} – ${mare.location}'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (mare.isPregnant)
            const Text('✔', style: TextStyle(color: Colors.green, fontSize: 16)),
          const SizedBox(width: 8),
          if (mare.needsVet)
            const Text('⚕', style: TextStyle(color: Colors.pink, fontSize: 16)),
        ],
      ),
      onTap: () => onTap(mare),
    );
  }
}
