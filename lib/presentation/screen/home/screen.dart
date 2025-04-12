import 'package:action_controller_sample/domain/enums/caller.dart';
import 'package:action_controller_sample/presentation/action_controller/create_user/action_controller.dart';
import 'package:action_controller_sample/presentation/action_controller/update_user/action_controller.dart';
import 'package:action_controller_sample/presentation/screen/apple/screen.dart';
import 'package:action_controller_sample/presentation/screen/banana/screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part '_list_tile.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});

  static const String path = '/';
  static const String name = 'home_screen';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final createUser = useCreateUserController(ref, caller: Caller.homeScreen);

    final updateUser = useUpdateUserController(ref, caller: Caller.homeScreen);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            spacing: 12,
            children: [
              _ListTile(
                screenName: 'Apple',
                onTap: () => context.push(AppleScreen.path),
              ),
              _ListTile(
                screenName: 'Banana',
                onTap: () => context.push(BananaScreen.path),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: createUser.action,
                child: const Text('Create User'),
              ),
              ElevatedButton(
                onPressed: updateUser.action,
                child: const Text('Update User'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
