import 'package:flutter/material.dart';
import 'package:plinco/utils/layout_wrapper.dart';
import 'package:plinco/widgets/menu/level_select_menu.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
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
              const Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      LevelSelectMenu(
                        backgroundUrl: 'assets/images/levels/first.png',
                      ),
                      LevelSelectMenu(
                        backgroundUrl: 'assets/images/levels/second.png',
                        isRightPlay: false,
                        score: 1,
                      ),
                      LevelSelectMenu(
                        backgroundUrl: 'assets/images/levels/third.png',
                        score: 2,
                      ),
                      LevelSelectMenu(
                        backgroundUrl: 'assets/images/levels/fourth.png',
                        isRightPlay: false,
                        score: 3,
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
