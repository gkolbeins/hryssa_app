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
      subtitle: Text(
        mare.extraNumber1 != null && mare.extraNumber1!.isNotEmpty
          ? '${mare.location} – ${mare.extraNumber1}'
          : mare.location,
      ),

      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (mare.isPregnant)
            const Icon(
              Icons.check,
                color: Color.fromARGB(255, 10, 95, 13),
                size: 18,
            ),

          const SizedBox(width: 8),
          if (mare.needsVet)
            Container(
              width: 12,
              height: 12,
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
            ),
        ],
      ),
      onTap: () => onTap(mare),
    );
  }
}
