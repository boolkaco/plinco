import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plinco/bloc/app/app_cubit.dart';
import 'package:plinco/const/assets.dart';
import 'package:plinco/models/level_model.dart';
import 'package:plinco/screens/level_screen.dart';
import 'package:plinco/services/audio_service.dart';
import 'package:plinco/services/images_service.dart';
import 'package:plinco/utils/layout_wrapper.dart';
import 'package:plinco/utils/lifecircle_event_handler.dart';
import 'package:plinco/widgets/app_logo.dart';
import 'package:plinco/widgets/menu/level_select_menu.dart';

class MenuScreen extends StatefulWidget {
  final bool isLoaded;

  const MenuScreen({super.key, this.isLoaded = false});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  final AudioService audioService = AudioService();
  late bool _isLoaded;
  late LifecycleEventHandler _lifecycleEventHandler;

  @override
  void initState() {
    super.initState();
    _isLoaded = widget.isLoaded;
    _lifecycleEventHandler = LifecycleEventHandler(
      audioService: context.read<AudioService>(),
    );
    WidgetsBinding.instance.addObserver(_lifecycleEventHandler);
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isLoaded = true;
      });
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(_lifecycleEventHandler);
    super.dispose();
  }

  void _selectLevel(LevelModel level) {
    if (!level.isLock) {
      if (context.read<AppCubit>().state.isButtonsSound) {
        audioService.playSound('buttons_sound');
      }
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) => LevelScreen(
            level: level,
          ),
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        ),
      );
    }
  }

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
                const Center(
                  child: AppLogo(),
                ),
                if (_isLoaded)
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(0),
                      itemCount: appState.levels.length,
                      itemBuilder: (context, index) {
                        return LevelSelectMenu(
                          backgroundUrl: appState.levels[index].previewUrl,
                          isRightPlay: index % 2 == 0,
                          isLock: appState.levels[index].isLock,
                          score: appState.levels[index].stars,
                          onTap: () => _selectLevel(appState.levels[index]),
                        );
                      },
                    ),
                  )
                else
                  Expanded(
                    child: Image.file(
                      ImagesService().getByFilename(assetsMap['ball_decoration']!)!,
                      fit: BoxFit.contain,
                    ),
                  )
              ],
            ),
          ),
        );
      },
    );
  }
}
