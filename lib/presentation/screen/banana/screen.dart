import 'package:action_controller_sample/data/repositories/user/provider.dart';
import 'package:action_controller_sample/domain/enums/caller.dart';
import 'package:action_controller_sample/domain/models/user.dart';
import 'package:action_controller_sample/presentation/action_controller/create_user/action_controller.dart';
import 'package:action_controller_sample/presentation/action_controller/update_user/action_controller.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BananaScreen extends HookConsumerWidget {
  const BananaScreen({super.key});

  static const String path = '/banana';
  static const String name = 'banana_screen';

  static const _caller = Caller.bananaScreen;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final createUser = useCreateUserController(ref, caller: _caller);
    final updateUser = useUpdateUserController(ref, caller: _caller);

    final asyncUsers = ref.watch(usersProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Banana Screen'),
      ),
      body: switch (asyncUsers) {
        AsyncData(value: final users) => ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              return ListTile(
                title: Text(user.name),
                subtitle: Text(user.email),
                onTap: () async {
                  await updateUser.action();
                },
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
          await createUser.action(user);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
