import 'package:flutter/material.dart';

class ProfileController extends ChangeNotifier {
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
    notifyListeners();
  }

  void saveProfile() {
    userData.value = {
      ...userData.value,
      'name': nameController.text,
      'email': emailController.text,
    };
    isEditing = false;
    notifyListeners();
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

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    userData.dispose();
    super.dispose();
  }
}
