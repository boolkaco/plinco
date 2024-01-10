import 'package:flutter/material.dart';
import 'package:plinco/const/levels.dart';
import 'package:plinco/models/level_model.dart';
import 'package:plinco/screens/level_screen.dart';
import 'package:plinco/utils/layout_wrapper.dart';
import 'package:plinco/widgets/menu/level_select_menu.dart';

class MenuScreen extends StatefulWidget {
  final bool isLoaded;

  const MenuScreen({super.key, this.isLoaded = false});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  late bool _isLoaded;

  @override
  void initState() {
    super.initState();
    _isLoaded = widget.isLoaded;
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isLoaded = true;
      });
    });
  }

  void _selectLevel(LevelModel level) {
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
            Image.asset(
              "assets/images/logo.png",
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
                child: Image.asset(
                  "assets/images/ball.png",
                  fit: BoxFit.contain,
                ),
              )
          ],
        ),
      ),
    );
  }
}
