import 'package:flutter/material.dart';
import 'package:plinco/screens/level_screen.dart';
import 'package:plinco/utils/layout_wrapper.dart';
import 'package:plinco/widgets/menu/level_select_menu.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  bool _isLoaded = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isLoaded = true;
      });
    });
  }

  void _selectLevel() {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) => const LevelScreen(),
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      ),
    );
  }

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
            Image.asset(
              "assets/images/logo.png",
              fit: BoxFit.cover,
            ),
            if (_isLoaded)
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      LevelSelectMenu(
                        backgroundUrl: 'assets/images/levels/first.png',
                        onTap: _selectLevel,
                      ),
                      LevelSelectMenu(
                        backgroundUrl: 'assets/images/levels/second.png',
                        isRightPlay: false,
                        score: 1,
                        onTap: _selectLevel,
                      ),
                      LevelSelectMenu(
                        backgroundUrl: 'assets/images/levels/third.png',
                        score: 2,
                        onTap: _selectLevel,
                      ),
                      LevelSelectMenu(
                        backgroundUrl: 'assets/images/levels/fourth.png',
                        isRightPlay: false,
                        score: 3,
                        onTap: _selectLevel,
                      ),
                    ],
                  ),
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