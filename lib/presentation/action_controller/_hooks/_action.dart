part of 'hooks.dart';

typedef Action = ({
  FutureOr<void> Function() action,
});

/// Actionを使用するためのフック
Action useAction(
  WidgetRef ref,
  Refreshable<AsyncValue<void>> provider, {
  required FutureOr<void> Function(BuildContext context) action,
}) {
  //----------------------------------------------------------------------------
  // property
  //----------------------------------------------------------------------------
  final cache = AsyncCache<void>.ephemeral();
  final context = useContext();

  //----------------------------------------------------------------------------
  // action
  //----------------------------------------------------------------------------

  FutureOr<void> actionWrapper() async {
    await cache.fetch(() async {
      await action(context);
    });
    return null;
  }

  return (action: actionWrapper);
}
