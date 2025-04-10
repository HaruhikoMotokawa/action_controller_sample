import 'package:action_controller_sample/domain/enums/screen_location.dart';
import 'package:action_controller_sample/presentation/action_controller/create_user/use_action_controller.dart';
import 'package:action_controller_sample/presentation/screen/apple/screen.dart';
import 'package:action_controller_sample/presentation/screen/banana/screen.dart';
import 'package:action_controller_sample/presentation/shared/exception_handler_consumer/consumer.dart';
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
    final createUser = useCreateUserController(ref);
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
                  onPressed: () =>
                      createUser.action(location: ScreenLocation.home),
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
