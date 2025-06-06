import 'package:action_controller_sample/data/repositories/user/exception.dart';
import 'package:action_controller_sample/domain/enums/caller.dart';
import 'package:action_controller_sample/domain/models/user.dart';
import 'package:action_controller_sample/presentation/shared/dialog/app_dialog.dart';
import 'package:action_controller_sample/presentation/shared/snack_bar/app_snack_bar.dart';
import 'package:action_controller_sample/presentation/shared/state/throw_exception.dart';
import 'package:action_controller_sample/use_case/executors/create_user/executor.dart';
import 'package:async/async.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

typedef CreateUserAction = ({
  Future<void> Function(User user) action,
});

/// CreateUserActionを使用するためのフック
CreateUserAction useCreateUserController(
  WidgetRef ref, {
  required Caller caller,
}) {
  //----------------------------------------------------------------------------
  // property
  //----------------------------------------------------------------------------
  final provider = createUserExecutorProvider(caller);
  final createUser = ref.read(provider.notifier);
  final context = useContext();
  final cache = AsyncCache<void>.ephemeral();

  // INFO: テストのために例外をスローするかどうかをwatch
  final throwException = ref.watch(throwExceptionProvider);

  //----------------------------------------------------------------------------
  // action
  //----------------------------------------------------------------------------
  Future<void> action(User user) async {
    await cache.fetch(() async {
      // INFO: 例外をスローするかどうかを渡す
      await createUser(user, throwException: throwException);

      final hasError = ref.read(provider).hasError;
      if (!context.mounted || hasError) return;

      await showAppSnackBar(context, message: 'User created successfully');
    });
  }

  //----------------------------------------------------------------------------
  // Exception Handler
  //----------------------------------------------------------------------------
  ref.listen(provider, (_, next) {
    if (next.hasError == false && next.isLoading) return;

    if (next.error case final exception? when exception is Exception) {
      switch (exception) {
        case DuplicateUserNameException():
          switch (caller) {
            case Caller.homeScreen:
              showAppDialog(
                context,
                title: '重複エラー',
                message: '$caller 同じ名前のユーザーがすでに存在します。',
                buttonText: 'OK',
              );
            case Caller.appleScreen:
            case Caller.bananaScreen:
              showAppSnackBar(
                context,
                message: '$caller 同じ名前のユーザーがすでに存在します。',
              );
          }
        case ServerErrorException():
          showAppDialog(
            context,
            title: 'サーバーエラー',
            message: 'サーバーでエラーが発生しました。時間をおいて再試行してください。',
            buttonText: '閉じる',
          );
        default:
          showAppDialog(
            context,
            title: '不明なエラー',
            message: '予期しないエラーが発生しました。',
            buttonText: '閉じる',
          );
      }
    }
  });

  //----------------------------------------------------------------------------
  // return
  //----------------------------------------------------------------------------
  return (action: action);
}
