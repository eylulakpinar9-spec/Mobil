import 'package:flutter/material.dart';

class BadgeWidget extends StatelessWidget {
  final String text;

  const BadgeWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    Color badgeColor;
    IconData? iconData;

    final lowerText = text.toLowerCase();
    if (lowerText == 'ücretsiz') {
      badgeColor = const Color(0xFF00C853); // Vibrant green
      iconData = Icons.card_giftcard;
    } else if (lowerText == 'acil') {
      badgeColor = const Color(0xFFD50000); // Strong red
      iconData = Icons.local_fire_department;
    } else if (lowerText == 'indirim') {
      badgeColor = const Color(0xFFFF6D00); // Vibrant orange
      iconData = Icons.local_offer;
    } else {
      badgeColor = Colors.blueGrey;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: badgeColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (iconData != null) ...[
            Icon(iconData, color: Colors.white, size: 14),
            const SizedBox(width: 4),
          ],
          Text(
            text.toUpperCase(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.w900,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}
