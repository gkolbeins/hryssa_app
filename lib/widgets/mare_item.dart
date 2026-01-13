import 'package:flutter/material.dart';
import '../models/mare.dart';

class MareItem extends StatelessWidget {
  final Mare mare;
  final Function(Mare) onTap;

  const MareItem({
    super.key,
    required this.mare,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final subtitle = mare.otherInfo1 != null && mare.otherInfo1!.isNotEmpty
        ? '${mare.location ?? ''} – ${mare.otherInfo1}'
        : (mare.location ?? '');

    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () => onTap(mare),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
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
        child: Row(
          children: [
            ///texti
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    mare.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (subtitle.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ],
              ),
            ),

            ///status tákn
            Row(
              children: [
                if (mare.pregnancyConfirmed)
                  const Icon(
                    Icons.check_circle,
                    color: Color(0xFF2E7D32),
                    size: 20,
                  ),
                if (mare.needsVet) ...[
                  const SizedBox(width: 8),
                  Container(
                    width: 10,
                    height: 10,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
