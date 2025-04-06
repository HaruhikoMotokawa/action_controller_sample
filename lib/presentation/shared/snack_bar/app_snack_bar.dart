import 'package:flutter/material.dart';

Future<void> showAppSnackBar(
  BuildContext context, {
  required String message,
}) async {
  final snackBar = SnackBar(
    content: Text(message),
    duration: const Duration(seconds: 1),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
