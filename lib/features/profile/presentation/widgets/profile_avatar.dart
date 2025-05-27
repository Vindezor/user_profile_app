// core/presentation/widgets/profile_avatar.dart

import 'dart:io';

import 'package:flutter/material.dart';

class ProfileAvatar extends StatelessWidget {
  final String imageUrl;
  final String? localPath;
  final double radius;

  const ProfileAvatar({
    super.key,
    required this.imageUrl,
    this.localPath,
    this.radius = 100,
  });

  @override
  Widget build(BuildContext context) {
    final imageProvider = localPath != null
        ? FileImage(File(localPath!))
        : (imageUrl.isNotEmpty ? NetworkImage(imageUrl) : null) as ImageProvider?;

    return CircleAvatar(
      radius: radius,
      backgroundImage: imageProvider,
      child: (localPath == null && imageUrl.isEmpty)
          ? const Icon(Icons.person, size: 100)
          : null,
    );
  }
}
