import 'package:design_manager/presentation/manager/pages/profile/profile_page.dart';
import 'package:design_manager/presentation/manager/pages/reports/reports_page.dart';
import 'package:design_manager/presentation/manager/pages/review_task/review_task_page.dart';
import 'package:flutter/material.dart';

import 'package:design_manager/presentation/manager/pages/tasklist/tasklist_page.dart';
import 'package:design_manager/presentation/manager/widgets/bottom_navbar.dart';

class ManagerHomePage extends StatefulWidget {
  const ManagerHomePage({super.key});

  @override
  State<ManagerHomePage> createState() => _DesignerHomePageState();
}

class _DesignerHomePageState extends State<ManagerHomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    TasklistPage(),
    ReviewTaskPage(),
    ReportsPage(), 
    ProfilePage(), 
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
      ),
    );
  }
}
