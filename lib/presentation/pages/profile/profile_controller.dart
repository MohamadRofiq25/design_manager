import 'package:flutter/material.dart';

class ProfileController {
  bool isEditing = false;

  final userData = ValueNotifier<Map<String, dynamic>>({
    "name": "Mohamad Rofiq",
    "email": "rofiq@taskmanager.com",
    "role": "Manager",
    "photoUrl": null,
  });

  final nameController = TextEditingController();
  final emailController = TextEditingController();

  ProfileController() {
    nameController.text = userData.value['name'];
    emailController.text = userData.value['email'];
  }

  void toggleEditMode() {
    isEditing = !isEditing;
  }

  void saveProfile(BuildContext context) {
    userData.value = {
      ...userData.value,
      'name': nameController.text,
      'email': emailController.text,
    };
    isEditing = false;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Profil berhasil diperbarui!'),
        backgroundColor: Color(0xFF45D1A6),
      ),
    );
  }

  void logout(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Konfirmasi Logout'),
        content: const Text('Apakah Anda yakin ingin keluar dari aplikasi?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, '/login');
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }

  void dispose() {
    nameController.dispose();
    emailController.dispose();
    userData.dispose();
  }
}
