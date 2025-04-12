part of 'hooks.dart';

typedef ActionControllerBase = ({
  FutureOr<void> Function() action,
  void Function(Exception exception, BuildContext context)? onError,
});

/// ActionControllerを使用するための基本のカスタムフック
ActionControllerBase useActionControllerBase(
  WidgetRef ref,
  Refreshable<AsyncValue<void>> provider, {
  required FutureOr<void> Function(BuildContext context) action,
  void Function(Exception exception, BuildContext context)? onError,
}) {
  //----------------------------------------------------------------------------
  // action
  //----------------------------------------------------------------------------

  final wrappedAction = useAction(ref, provider, action: action);

  //----------------------------------------------------------------------------
  // Exception Handler
  //----------------------------------------------------------------------------
  if (onError case final onError?) {
    useActionExceptionHandler(
      provider,
      ref,
      onException: onError,
    );
  }

  return (action: wrappedAction.action, onError: onError);
}
