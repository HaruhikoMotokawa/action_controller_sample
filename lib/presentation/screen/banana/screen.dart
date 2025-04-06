import 'package:flutter/material.dart';

class BananaScreen extends StatelessWidget {
  const BananaScreen({super.key});

  static const String path = '/banana';
  static const String name = 'banana_screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Banana Screen'),
      ),
      body: const Center(
        child: Text('This is the Banana Screen!'),
      ),
    );
  }
}
