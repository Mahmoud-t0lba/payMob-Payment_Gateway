import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:payment/modules/register/register.dart';
import 'package:payment/shared/components/components.dart';
import 'package:payment/shared/components/constants.dart';
import 'package:webview_flutter/webview_flutter.dart';

class VisaCardScreen extends StatelessWidget {
  const VisaCardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: payColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            exit(context);
          },
          icon: Transform.rotate(
            angle: 180 * math.pi / 180,
            child: const Icon(Icons.exit_to_app),
          ),
        ),
      ),
      body: WebView(
        // 441110
        // 441111
        initialUrl:
            'https://accept.paymob.com/api/acceptance/iframes/441111?payment_token=$payMobFinalToken',
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }

  void exit(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text(
            'Are you sure complete payMent',
            style: TextStyle(
              color: payColor,
              fontSize: 14,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                navigateAndFinish(
                  context,
                  const RegisterScreen(),
                );
              },
              child: const Text(
                'Yes',
                style: TextStyle(
                  color: payColor,
                  fontSize: 14,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'No',
                style: TextStyle(
                  color: payColor,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
