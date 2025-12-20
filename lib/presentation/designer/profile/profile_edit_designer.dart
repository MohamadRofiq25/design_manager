import 'package:flutter/material.dart';
import 'profile_controller_designer.dart';

class ProfileEditDesigner extends StatelessWidget {
  final ProfileControllerDesigner controller;

  const ProfileEditDesigner({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final user = controller.userData.value;

    return Column(
      key: const ValueKey('editView'),
      children: [
        const SizedBox(height: 20),
        const Text(
          'Edit Profil',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        TextFormField(
          controller: controller.nameController,
          decoration: const InputDecoration(
            labelText: 'Nama Lengkap',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.person),
          ),
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: controller.emailController,
          decoration: const InputDecoration(
            labelText: 'Email',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.email),
          ),
        ),
        const SizedBox(height: 16),
        TextFormField(
          enabled: false,
          initialValue: user['role'],
          decoration: const InputDecoration(
            labelText: 'Role (tidak dapat diubah)',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.badge),
          ),
        ),
        const SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: () => controller.saveProfile(),
              icon: const Icon(Icons.save),
              label: const Text("Simpan"),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF45D1A6),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(width: 16),
            OutlinedButton.icon(
              onPressed: () {
                controller.toggleEditMode();
              },
              icon: const Icon(Icons.cancel, color: Colors.red),
              label: const Text("Batal", style: TextStyle(color: Colors.red)),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.red),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
