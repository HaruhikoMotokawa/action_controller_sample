part of 'screen.dart';

typedef _ScreenController = ({
  FutureOr<void> Function(User user) createUser,
  FutureOr<void> Function() updateUser,
});

_ScreenController _useScreenController(WidgetRef ref) {
  const caller = Caller.bananaScreen;
  final createUser = useCreateUserController(ref, caller: caller);
  final updateUser = useUpdateUserController(ref, caller: caller);

  return (
    createUser: createUser.action,
    updateUser: updateUser.action,
  );
}
