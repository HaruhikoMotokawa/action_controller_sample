import 'package:action_controller_sample/domain/enums/screen_location.dart';
import 'package:action_controller_sample/presentation/action_controller/create_user/use_action.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AppleScreen extends HookConsumerWidget {
  const AppleScreen({super.key});

  static const String path = '/apple';
  static const String name = 'apple_screen';
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final createUser = useCreateUser(ref);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Apple Screen'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => createUser.action(location: ScreenLocation.apple),
          child: const Text('Create User'),
        ),
      ),
    );
  }
}
