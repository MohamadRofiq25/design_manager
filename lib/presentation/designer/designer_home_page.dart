import 'package:design_manager/presentation/designer/profile/profile_page_designer.dart';
import 'package:flutter/material.dart';

import 'my_task/my_task_designer.dart';
import 'widgets/bottom_navbar_designer.dart';

class DesignerHomePage extends StatefulWidget {
  const DesignerHomePage({super.key});

  @override
  State<DesignerHomePage> createState() => _DesignerHomePageState();
}

class _DesignerHomePageState extends State<DesignerHomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    MyTaskDesigner(),
    Placeholder(), // Revision (sementara)
    Placeholder(), // Report (sementara)
    ProfilePageDesigner(), // Profile (sementara)
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
      bottomNavigationBar: BottomNavbarDesigner(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
      ),
    );
  }
}
