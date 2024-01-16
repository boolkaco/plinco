import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:plinco/app.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:plinco/const/assets.dart';
import 'package:plinco/utils/image_loader.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  EasyLocalization.logger.enableBuildModes = [];
  await EasyLocalization.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await ImageLoader().loadImage(assets['bg']!);

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: const App(),
    ),
  );
}
