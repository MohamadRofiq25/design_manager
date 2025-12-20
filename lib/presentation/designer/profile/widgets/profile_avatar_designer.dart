import 'package:flutter/material.dart';

class ProfileAvatarDesigner extends StatelessWidget {
  final String name;
  final String? photoUrl;

  const ProfileAvatarDesigner({super.key, required this.name, this.photoUrl});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 60,
      backgroundColor: const Color(0xFFB2F4C3),
      backgroundImage: photoUrl != null ? NetworkImage(photoUrl!) : null,
      child: photoUrl == null
          ? Text(
              name[0],
              style: const TextStyle(
                fontSize: 40,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            )
          : null,
    );
  }
}
