import 'package:flutter/material.dart';
import 'package:plinco/const/assets.dart';
import 'package:plinco/services/audio_service.dart';
import 'package:plinco/services/images_service.dart';

class AppBackButton extends StatelessWidget {
  AppBackButton({super.key});

  final AudioService audioService = AudioService();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        audioService.playSound('buttons_sound');
        Navigator.pop(context);
      },
      child: Image.file(
        ImagesService().getByFilename(assetsMap['back_btn']!)!,
        fit: BoxFit.fill,
        width: 57,
        height: 61,
      ),
    );
  }
}
