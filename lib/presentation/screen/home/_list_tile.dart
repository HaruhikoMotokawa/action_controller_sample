part of 'screen.dart';

class _ListTile extends StatelessWidget {
  const _ListTile({
    required this.screenName,
    required this.onTap,
  });

  final String screenName;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        title: Text('Go to $screenName Screen'),
        onTap: onTap,
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}

class _SwitchListTile extends ConsumerWidget {
  const _SwitchListTile();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final throwExceptionState = ref.watch(throwExceptionProvider);
    final switchThrowException = ref.watch(throwExceptionProvider.notifier);
    return Container(
      decoration: BoxDecoration(
        color: Colors.red[100],
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: SwitchListTile(
        title: const Text('Throw Exception'),
        value: throwExceptionState,
        onChanged: (value) => switchThrowException(),
      ),
    );
  }
}
