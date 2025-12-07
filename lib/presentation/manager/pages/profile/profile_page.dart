import 'package:flutter/material.dart';
import 'profile_controller.dart';
import 'profile_view.dart';
import 'profile_edit_view.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late ProfileController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ProfileController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: const Color(0xFF45D1A6),
      ),
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: _controller.isEditing
                  ? ProfileEditView(controller: _controller)
                  : ProfileView(controller: _controller),
            ),
          );
        },
      ),

    );
  }
}
