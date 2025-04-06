import 'package:flutter/material.dart';

class AppleScreen extends StatelessWidget {
  const AppleScreen({super.key});

  static const String path = '/apple';
  static const String name = 'apple_screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Apple Screen'),
      ),
      body: const Center(
        child: Text('This is the Apple Screen!'),
      ),
    );
  }
}
