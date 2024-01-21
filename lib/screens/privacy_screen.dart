import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:plinco/utils/layout_wrapper.dart';
import 'package:plinco/widgets/back_button.dart';
import 'package:plinco/widgets/common/stroke_text.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PrivacyScreen extends StatelessWidget {
  PrivacyScreen({
    super.key,
  });

  final WebViewController controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(Colors.transparent)
    ..setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {
          // Update loading bar.
        },
        onPageStarted: (String url) {},
        onPageFinished: (String url) {},
        onWebResourceError: (WebResourceError error) {},
        onNavigationRequest: (NavigationRequest request) {
          if (request.url.startsWith('${dotenv.env['BASE_PATH']!}/privacy')) {
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ),
    )
    ..loadRequest(Uri.parse('${dotenv.env['BASE_PATH']!}/privacy'));

  @override
  Widget build(BuildContext context) {
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
          Expanded(child: WebViewWidget(controller: controller)),
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
