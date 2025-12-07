import 'package:flutter/material.dart';

class BottomNavbarDesigner extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavbarDesigner({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: currentIndex,
      selectedItemColor: const Color(0xFF45D1A6),
      unselectedItemColor: Colors.grey,
      onTap: onTap,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.list_alt),
          label: 'My Task',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.rate_review),
          label: 'Revision',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bar_chart),
          label: 'Reports',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    );
  }
}
