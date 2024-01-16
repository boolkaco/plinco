import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:plinco/const/assets.dart';
import 'package:plinco/screens/menu_screen.dart';
import 'package:plinco/utils/image_loader.dart';
import 'package:plinco/utils/layout_wrapper.dart';
import 'package:plinco/widgets/common/stroke_text.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      for (var asset in assets.values) {
        await ImageLoader().loadImage(asset);
      }
      
      Future.delayed(const Duration(seconds: 0), () {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) =>
                const MenuScreen(),
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero,
          ),
        );
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
              height: 188,
            ),
            Center(child: StrokeText('loading'.tr())),
          ],
        ),
      ),
    );
  }
}
