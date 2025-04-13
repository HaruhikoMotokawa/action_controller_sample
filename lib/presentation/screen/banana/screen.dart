import 'package:action_controller_sample/data/repositories/user/provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BananaScreen extends HookConsumerWidget {
  const BananaScreen({super.key});

  static const String path = '/banana';
  static const String name = 'banana_screen';
  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
    );
  }
}
