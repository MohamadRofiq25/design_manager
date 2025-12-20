import 'package:flutter/material.dart';
import 'profile_controller_designer.dart';
import 'widgets/profile_avatar_designer.dart';
import 'widgets/profile_card_designer.dart';
import 'widgets/profile_action_buttons_designer.dart';

class ProfileViewDesigner extends StatelessWidget {
  final ProfileControllerDesigner controller;

  const ProfileViewDesigner({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final user = controller.userData.value;

    return Column(
      key: const ValueKey('profileView'),
      children: [
        const SizedBox(height: 20),
        ProfileAvatarDesigner(name: user['name'], photoUrl: user['photoUrl']),
        const SizedBox(height: 20),
        Text(
          user['name'],
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),
        Text(
          user['role'],
          style: const TextStyle(fontSize: 16, color: Colors.grey),
        ),
        const SizedBox(height: 30),
        ProfileCardDesigner(userData: user),
        const SizedBox(height: 30),
        ProfileActionButtonsDesigner(
          onEdit: controller.toggleEditMode,
          onLogout: () => controller.logout(context),
        ),
      ],
    );
  }
}
