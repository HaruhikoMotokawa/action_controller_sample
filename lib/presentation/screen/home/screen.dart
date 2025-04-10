import 'package:action_controller_sample/presentation/action_controller/create_user/action_controller.dart';
import 'package:action_controller_sample/presentation/screen/apple/screen.dart';
import 'package:action_controller_sample/presentation/screen/banana/screen.dart';
import 'package:action_controller_sample/presentation/shared/exception_handler_consumer/consumer.dart';
import 'package:action_controller_sample/presentation/shared/snack_bar/app_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part '_list_tile.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  static const String path = '/';
  static const String name = 'home_screen';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // listen _handler
    return ExceptionHandlerConsumer(
      child: Scaffold(
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
                  onPressed: () => _createUser(context, ref),
                  child: const Text('Create User'),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Update User'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

extension on HomeScreen {
  Future<void> _createUser(BuildContext context, WidgetRef ref) async {
    final actionController =
        ref.read(createUserActionControllerProvider.notifier);
    await actionController.execute();
    final state = ref.read(createUserActionControllerProvider);

    if (!context.mounted || state.hasError) return;
    await showAppSnackBar(context, message: 'User Created');
  }
}
