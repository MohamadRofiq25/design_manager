import 'package:flutter/material.dart';

class SocialIcon extends StatelessWidget {
  final IconData icon;
  final Color color;

  const SocialIcon({
    super.key,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        shape: BoxShape.circle,
      ),
      padding: const EdgeInsets.all(12),
      child: Icon(icon, color: color, size: 28),
    );
  }
}
