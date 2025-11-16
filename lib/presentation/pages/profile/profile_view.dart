import 'package:flutter/material.dart';
import 'profile_controller.dart';
import 'widgets/profile_avatar.dart';
import 'widgets/profile_card.dart';
import 'widgets/profile_action_buttons.dart';

class ProfileView extends StatelessWidget {
  final ProfileController controller;

  const ProfileView({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final user = controller.userData.value;

    return Column(
      key: const ValueKey('profileView'),
      children: [
        const SizedBox(height: 20),
        ProfileAvatar(name: user['name'], photoUrl: user['photoUrl']),
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
        ProfileCard(userData: user),
        const SizedBox(height: 30),
        ProfileActionButtons(
          onEdit: () {
            controller.toggleEditMode();
            (context as Element).markNeedsBuild();
          },
          onLogout: () => controller.logout(context),
        ),
      ],
    );
  }
}
