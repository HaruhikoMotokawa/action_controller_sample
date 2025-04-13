import 'dart:async';

import 'package:action_controller_sample/data/repositories/user/provider.dart';
import 'package:action_controller_sample/domain/enums/caller.dart';
import 'package:action_controller_sample/domain/models/user.dart';
import 'package:action_controller_sample/presentation/action_controller/_hooks/hooks.dart';
import 'package:action_controller_sample/presentation/action_controller/create_user/action_controller.dart';
import 'package:action_controller_sample/presentation/action_controller/update_user/action_controller.dart';
import 'package:action_controller_sample/presentation/shared/snack_bar/app_snack_bar.dart';
import 'package:action_controller_sample/use_case/executors/schedule_todo_notification/executor.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part '_schedule_todo_notification_controller.dart';
part '_screen_controller.dart';

class BananaScreen extends HookConsumerWidget {
  const BananaScreen({super.key});

  static const String path = '/banana';
  static const String name = 'banana_screen';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenController = _useScreenController(ref);

    final asyncUsers = ref.watch(usersProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Banana Screen'),
        actions: [
          IconButton(
            onPressed: () async {
              const todoId = 'your_todo_id_here';
              await screenController.scheduleTodoNotification(todoId);
            },
            icon: const Icon(Icons.notification_add),
          ),
        ],
      ),
      body: switch (asyncUsers) {
        AsyncData(value: final users) => ListView.separated(
            itemCount: users.length,
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, index) {
              final user = users[index];
              return ListTile(
                title: Text(user.name),
                subtitle: Text(user.email),
                onTap: screenController.updateUser,
              );
            },
          ),
        AsyncError() => Center(
            child: Column(
              spacing: 40,
              children: [
                const Text('Error'),
                ElevatedButton(
                  onPressed: () {
                    ref.invalidate(usersProvider);
                  },
                  child: const Text('Retry'),
                ),
              ],
            ),
          ),
        _ => const Center(
            child: CircularProgressIndicator(),
          ),
      },
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final user = User(
            id: '1',
            name: 'test',
            email: 'example@gmail.com',
          );
          await screenController.createUser(user);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
