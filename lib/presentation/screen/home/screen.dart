import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const String path = '/';
  static const String name = 'home_screen';

  @override
  Widget build(BuildContext context) =>
      const Scaffold(body: Center(child: Text('Hello World!')));
}
