part of 'hooks.dart';

typedef Action<R, Args> = ({FutureOr<R> Function([Args args]) action});

/// Actionをキャッシュして、多重実行を防ぐためのカスタムフック
///
/// ```dart
/// final action = useCacheAction<void, Null>(
///  action: (context) async {
///    await updateUser.call();
///   final hasError = ref.read(provider).hasError;
///   if (!context.mounted || hasError) return;
///   showAppSnackBar(context, message: 'User created successfully');
///  },
/// ```
Action<R, Args> useCacheAction<R, Args>({
  required FutureOr<R> Function(BuildContext context) action,
}) {
  //----------------------------------------------------------------------------
  // property
  //----------------------------------------------------------------------------
  final cache = AsyncCache<void>.ephemeral();
  final context = useContext();

  //----------------------------------------------------------------------------
  // action
  //----------------------------------------------------------------------------

  FutureOr<R> cacheAction([Args? args]) async {
    late final R result;
    await cache.fetch(() async {
      result = await action(context);
      return;
    });
    return result;
  }

  return (action: cacheAction);
}
