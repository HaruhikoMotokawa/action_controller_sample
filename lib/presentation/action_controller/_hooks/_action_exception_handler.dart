part of 'hooks.dart';

/// ActionControllerで発生したExceptionをハンドリングするためのカスタムフック
void useActionExceptionHandler<T>(
  Refreshable<AsyncValue<T>> provider,
  WidgetRef ref, {
  required void Function(
    Exception exception,
    BuildContext context,
  ) onException,
}) {
  final context = useContext();

  ref.listen<AsyncValue<T>>(
    provider,
    (_, next) {
      if (!next.isLoadingFailed) return;

      if (next.error case final exception? when exception is Exception) {
        onException(exception, context);
      }
    },
  );
}
