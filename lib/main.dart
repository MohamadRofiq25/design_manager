import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:design_manager/presentation/manager/pages/tasklist/tasklist_controller.dart';
import 'package:design_manager/presentation/manager/pages/review_task/review_task_controller.dart';
import 'package:design_manager/presentation/manager/pages/reports/reports_controller.dart';
import 'package:design_manager/presentation/manager/pages/profile/profile_controller.dart';

import 'package:design_manager/presentation/manager/pages/tasklist/tasklist_page.dart';
import 'package:design_manager/presentation/manager/pages/review_task/review_task_page.dart';
import 'package:design_manager/presentation/manager/pages/reports/reports_page.dart';
import 'package:design_manager/presentation/manager/pages/profile/profile_page.dart';
import 'package:design_manager/presentation/manager/widgets/bottom_navbar.dart';
import 'package:design_manager/presentation/manager/pages/create_task/create_task_form.dart';


void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TasklistController()),
        Provider(create: (_) => ReviewTaskController()),
        Provider(create: (_) => ReportsController()),
        Provider(create: (_) => ProfileController()),
      ],

      child: const DesignManagerApp(),
    ),
  );
}

class DesignManagerApp extends StatelessWidget {
  const DesignManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Design Manager',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF45D1A6),
      ),
      home: const HomePage(),
      routes: {
        '/task_form': (_) => const CreateTaskForm(),
      },
      // Jika perlu rute tambahan, bisa ditambahkan di sini
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
