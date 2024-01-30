// ignore_for_file: depend_on_referenced_packages

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:plinco/utils/layout_wrapper.dart';
import 'package:plinco/widgets/back_button.dart';
import 'package:plinco/widgets/common/stroke_text.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
import 'package:webview_flutter_platform_interface/webview_flutter_platform_interface.dart';

class PrivacyScreen extends StatelessWidget {
  PrivacyScreen({super.key});

  final PlatformWebViewController controller = PlatformWebViewController(
    WebKitWebViewControllerCreationParams(allowsInlineMediaPlayback: true),
  )
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(Colors.transparent);

  @override
  Widget build(BuildContext context) {
    String privacyUrl = '${dotenv.env['BASE_PATH']}/privacy';
    controller.loadRequest(LoadRequestParams(uri: Uri.parse(privacyUrl)));

    return BackgroundWrapper(
      child: Column(
        children: [
          const SizedBox(
            height: 70,
          ),
          Center(child: StrokeText('privacy'.tr())),
          const SizedBox(
            height: 10,
          ),
          Expanded(
              child: PlatformWebViewWidget(
            PlatformWebViewWidgetCreationParams(controller: controller),
          ).build(context)),
          const SizedBox(
            height: 12,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: AppBackButton(),
          ),
          const SizedBox(
            height: 62,
          ),
        ],
      ),
    );
  }
}
