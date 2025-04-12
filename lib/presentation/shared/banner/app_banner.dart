import 'package:flutter/material.dart';

Future<void> showAppBanner(
  BuildContext context, {
  required String message,
}) async {
  final banner = MaterialBanner(
    content: Text(message),
    actions: [
      TextButton(
        onPressed: () {
          ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
        },
        child: const Text('OK'),
      ),
    ],
  );

  ScaffoldMessenger.of(context).showMaterialBanner(banner);
}
