import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:plinco/app.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:plinco/const/assets.dart';
import 'package:plinco/services/audio_service.dart';
import 'package:plinco/utils/image_loader.dart';
import 'package:provider/provider.dart';
import 'package:sentry_flutter/sentry_flutter.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  EasyLocalization.logger.enableBuildModes = [];
  await EasyLocalization.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Hive.initFlutter();
  await ImageLoader().loadImage(assetsMap['bg']!);

  final sentryDsn = dotenv.env['SENTRY_DSN'];
  if (sentryDsn != null) {
    await SentryFlutter.init(
          (options) => options.dsn = sentryDsn,
    );
  }

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(
      EasyLocalization(
        supportedLocales: const [Locale('en')],
        path: 'assets/translations',
        fallbackLocale: const Locale('en'),
        child: Provider<AudioService>(
          create: (_) => AudioService(),
          child: const App(),
        ),
      ),
    );
  });
}
