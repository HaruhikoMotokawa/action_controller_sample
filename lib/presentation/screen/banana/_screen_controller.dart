part of 'screen.dart';

typedef _ScreenController = ({
  FutureOr<void> Function(User user) createUser,
  FutureOr<void> Function() updateUser,
  FutureOr<void> Function(String todoId) scheduleTodoNotification,
});

_ScreenController _useScreenController(WidgetRef ref) {
  const caller = Caller.bananaScreen;
  final createUserController = useCreateUserController(ref, caller: caller);
  final updateUserController = useUpdateUserController(ref, caller: caller);
  final scheduleTodoNotificationController =
      _useScheduleTodoNotificationController(ref, caller: caller);

  return (
    createUser: createUserController.action,
    updateUser: updateUserController.action,
    scheduleTodoNotification: scheduleTodoNotificationController.action,
  );
}
