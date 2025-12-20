import 'package:flutter/material.dart';
import 'profile_controller_designer.dart';
import 'profile_view_designer.dart';
import 'profile_edit_designer.dart';

class ProfilePageDesigner extends StatefulWidget {
  const ProfilePageDesigner({super.key});

  @override
  State<ProfilePageDesigner> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePageDesigner> {
  late ProfileControllerDesigner _controller;

  @override
  void initState() {
    super.initState();
    _controller = ProfileControllerDesigner();
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
                  ? ProfileEditDesigner(controller: _controller)
                  : ProfileViewDesigner(controller: _controller),
            ),
          );
        },
      ),

    );
  }
}
