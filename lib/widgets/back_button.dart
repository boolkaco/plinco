import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plinco/bloc/app/app_cubit.dart';
import 'package:plinco/const/assets.dart';
import 'package:plinco/screens/menu_screen.dart';
import 'package:plinco/services/audio_service.dart';
import 'package:plinco/services/images_service.dart';

class AppBackButton extends StatelessWidget {
  final Function()? callback;

  AppBackButton({super.key, this.callback});

  final AudioService audioService = AudioService();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (context.read<AppCubit>().state.isButtonsSound) {
          audioService.playSound('buttons_sound');
        }
        if (callback != null) {
          callback!();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const MenuScreen(
                isLoaded: true,
              ),
            ),
          );
        } else {
          Navigator.pop(context);
        }
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
