import 'package:flutter/material.dart';
import 'package:plinco/const/assets.dart';
import 'package:plinco/services/images_service.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Image.file(
      ImagesService().getByFilename(assetsMap['logo']!)!,
      fit: BoxFit.cover,
      width: screenWidth * 0.8,
    );
  }
}
