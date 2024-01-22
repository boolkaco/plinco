import 'package:flutter/material.dart';
import 'package:plinco/bloc/app/app_cubit.dart';
import 'package:plinco/const/assets.dart';
import 'package:plinco/const/levels.dart';
import 'package:plinco/models/level_model.dart';
import 'package:plinco/screens/level_screen.dart';
import 'package:plinco/services/audio_service.dart';
import 'package:plinco/services/images_service.dart';
import 'package:plinco/utils/layout_wrapper.dart';
import 'package:plinco/utils/lifecircle_event_handler.dart';
import 'package:plinco/widgets/menu/level_select_menu.dart';
import 'package:provider/provider.dart';

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

  @override
  Widget build(BuildContext context) {
    final levels = Levels.list;

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
            if (_isLoaded)
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(0),
                  itemCount: levels.length,
                  itemBuilder: (context, index) {
                    return LevelSelectMenu(
                      backgroundUrl: levels[index].previewUrl,
                      isRightPlay: index % 2 == 0,
                      score: index,
                      onTap: () => _selectLevel(levels[index]),
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
  }
}
