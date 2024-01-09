import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:plinco/utils/layout_wrapper.dart';
import 'package:plinco/widgets/app_button.dart';

class LevelScreen extends StatelessWidget {
  const LevelScreen({super.key});

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
            AppButton(
              label: "start".tr(),
            ),
            const SizedBox(
              height: 20,
            ),
            AppButton(
              label: "settings".tr(),
              type: AppButtonType.settings,
            ),
            const SizedBox(
              height: 20,
            ),
            AppButton(
              label: "privacy".tr(),
              type: AppButtonType.privacy,
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Image.asset(
                    "assets/images/back.png",
                    fit: BoxFit.fill,
                    width: 57,
                    height: 61,
                  ),
                ),
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
