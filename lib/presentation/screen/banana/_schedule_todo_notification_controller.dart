part of 'screen.dart';

typedef _ScheduleTodoNotificationAction = ({
  FutureOr<void> Function(String todoId) action,
});

/// Todoの通知をスケジュールするためのカスタムフック
///
/// 特定の画面でしか使用しない場合はプライベートにしてしまえば良い。
///
/// 逆に他の画面でも使うようになったらこのまま切り出してしまえばいい。
_ScheduleTodoNotificationAction _useScheduleTodoNotificationController(
  WidgetRef ref, {
  required Caller caller,
}) {
  //----------------------------------------------------------------------------
  // property
  //----------------------------------------------------------------------------
  final provider = scheduleTodoNotificationExecutorProvider(caller);
  final scheduleTodoNotification = ref.read(provider.notifier);
  final (:cache, :context) = useCacheAndContext();

  //----------------------------------------------------------------------------
  // action
  //----------------------------------------------------------------------------

  Future<void> action(String todoId) async {
    await cache.fetch(() async {
      scheduleTodoNotification(todoId: todoId);
      final hasError = ref.read(provider).hasError;
      if (!context.mounted || hasError) return;
      await showAppSnackBar(context, message: 'Todo scheduled successfully');
    });
  }

  //----------------------------------------------------------------------------
  // Exception Handler
  //----------------------------------------------------------------------------

  // 今回は省略

  //----------------------------------------------------------------------------
  // return
  //----------------------------------------------------------------------------
  return (action: action);
}
