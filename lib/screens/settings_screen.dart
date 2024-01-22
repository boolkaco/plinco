import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:plinco/const/assets.dart';
import 'package:plinco/services/audio_service.dart';
import 'package:plinco/services/images_service.dart';
import 'package:plinco/utils/layout_wrapper.dart';
import 'package:plinco/widgets/back_button.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final AudioService _audioService = AudioService();
  bool isMainSound = true;
  bool isButtonSound = true;

  @override
  Widget build(BuildContext context) {
    return BackgroundWrapper(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            const SizedBox(
              height: 114,
            ),
            Image.file(
              ImagesService().getByFilename(assetsMap['logo']!)!,
              fit: BoxFit.cover,
            ),
            Stack(
              children: [
                Image.file(
                  ImagesService()
                      .getByFilename(assetsMap['settings_decoration']!)!,
                  fit: BoxFit.fill,
                  height: 300,
                ),
                Positioned.fill(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isMainSound = !isMainSound;
                              });
                              // if (isMainSound) {
                              //   _audioService.loopSound('background_sound');
                              // } else {
                              //   _audioService.stopBackgroundMusic();
                              // }
                            },
                            child: Image.file(
                              ImagesService().getByFilename(isMainSound
                                  ? assetsMap['checkbox_active']!
                                  : assetsMap['checkbox_disable']!)!,
                              fit: BoxFit.fill,
                              width: 57,
                              height: 61,
                            ),
                          ),
                          const SizedBox(
                            width: 21,
                          ),
                          SizedBox(
                            width: 80,
                            child: Text(
                              'main_sound'.tr(),
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 21,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isButtonSound = !isButtonSound;
                              });
                            },
                            child: Image.file(
                              ImagesService().getByFilename(isButtonSound
                                  ? assetsMap['checkbox_active']!
                                  : assetsMap['checkbox_disable']!)!,
                              fit: BoxFit.fill,
                              width: 57,
                              height: 61,
                            ),
                          ),
                          const SizedBox(
                            width: 21,
                          ),
                          SizedBox(
                            width: 80,
                            child: Text(
                              'button_sound'.tr(),
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: AppBackButton(),
              ),
            ),
            const SizedBox(
              height: 62,
            ),
          ],
        ),
      ),
    );
  }
}
