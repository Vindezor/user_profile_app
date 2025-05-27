// lib/widgets/editable_avatar.dart

import 'dart:io';
import 'package:flutter/material.dart';

class EditableAvatar extends StatelessWidget {
  final String? imageUrl;
  final String? localPath;
  final File? newImageFile;
  final VoidCallback onEdit;

  const EditableAvatar({
    super.key,
    this.imageUrl,
    this.localPath,
    this.newImageFile,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    ImageProvider? imageProvider;

    if (newImageFile != null) {
      imageProvider = FileImage(newImageFile!);
    } else if (localPath != null) {
      imageProvider = FileImage(File(localPath!));
    } else if (imageUrl != null && imageUrl!.isNotEmpty) {
      imageProvider = NetworkImage(imageUrl!);
    }

    return Stack(
      children: [
        CircleAvatar(
          radius: 80,
          backgroundImage: imageProvider,
          child: imageProvider == null ? const Icon(Icons.person, size: 80) : null,
        ),
        Positioned(
          bottom: 0,
          right: 15,
          child: GestureDetector(
            onTap: onEdit,
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.edit,
                color: Theme.of(context).colorScheme.onPrimary,
                size: 18,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
