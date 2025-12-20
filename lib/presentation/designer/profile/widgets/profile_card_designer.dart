import 'package:flutter/material.dart';

class ProfileCardDesigner extends StatelessWidget {
  final Map<String, dynamic> userData;

  const ProfileCardDesigner({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.email, color: Color(0xFF45D1A6)),
            title: const Text('Email'),
            subtitle: Text(userData['email']),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.badge, color: Color(0xFF45D1A6)),
            title: const Text('Role'),
            subtitle: Text(userData['role']),
          ),
        ],
      ),
    );
  }
}
