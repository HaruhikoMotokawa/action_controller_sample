import 'package:action_controller_sample/domain/enums/caller.dart';
import 'package:action_controller_sample/domain/models/user.dart';
import 'package:action_controller_sample/presentation/action_controller/create_user/action_controller.dart';
import 'package:action_controller_sample/presentation/action_controller/update_user/action_controller.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AppleScreen extends HookConsumerWidget {
  const AppleScreen({super.key});

  static const String path = '/apple';
  static const String name = 'apple_screen';

  static const _caller = Caller.appleScreen;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final createUser = useCreateUserController(ref, caller: _caller);
    final updateUser = useUpdateUserController(ref, caller: _caller);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Apple Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 30,
          children: [
            ElevatedButton(
              onPressed: () async {
                final user = User(
                  id: '1',
                  name: 'test',
                  email: 'example@gmail.com',
                );
                await createUser.action(user);
              },
              child: const Text('Create User'),
            ),
            ElevatedButton(
              onPressed: updateUser.action,
              child: const Text('Update User'),
            ),
          ],
        ),
      ),
    );
  }
}
