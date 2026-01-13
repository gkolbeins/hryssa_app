import 'dart:io';
import 'package:flutter/material.dart';
import '../core/app_images.dart';

class MareImage extends StatelessWidget {
  final String? imagePath;
  final double height;
  final BorderRadius borderRadius;

  const MareImage({
    super.key,
    this.imagePath,
    this.height = 160,
    this.borderRadius = const BorderRadius.all(Radius.circular(12)),
  });

  @override
  Widget build(BuildContext context) {
    final ImageProvider imageProvider =
        imagePath != null && File(imagePath!).existsSync()
            ? FileImage(File(imagePath!))
            : const AssetImage(AppImages.dummyMare);

    return ClipRRect(
      borderRadius: borderRadius,
      child: Image(
        image: imageProvider,
        height: height,
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }
}
