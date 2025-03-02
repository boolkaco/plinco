import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plinco/bloc/app/app_cubit.dart';
import 'package:plinco/const/assets.dart';
import 'package:plinco/services/audio_service.dart';
import 'package:plinco/services/images_service.dart';
import 'package:plinco/utils/layout_wrapper.dart';
import 'package:plinco/widgets/app_logo.dart';
import 'package:plinco/widgets/back_button.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, appState) {
        return BackgroundWrapper(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Column(
              children: [
                SizedBox(
                  height: screenHeight * 0.08,
                ),
                const AppLogo(),
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
                                  context
                                      .read<AppCubit>().updateBackgroundSound();
                                  if (!appState.isBackgroundSound) {
                                    context.read<AudioService>().unMuteBackgroundMusic();
                                  } else {
                                    context.read<AudioService>().muteBackgroundMusic();
                                  }
                                },
                                child: Image.file(
                                  ImagesService().getByFilename(appState.isBackgroundSound
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
                                  context
                                      .read<AppCubit>()
                                      .updateButtonsSound();
                                },
                                child: Image.file(
                                  ImagesService().getByFilename(appState.isButtonsSound
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
                Expanded(child: Container(),),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: AppBackButton(),
                ),
                SizedBox(
                  height: screenHeight * 0.04,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
