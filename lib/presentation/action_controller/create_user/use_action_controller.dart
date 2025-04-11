import 'package:action_controller_sample/data/repositories/user/exception.dart';
import 'package:action_controller_sample/domain/enums/screen_location.dart';
import 'package:action_controller_sample/presentation/action_controller/_action_exception/exception.dart';
import 'package:action_controller_sample/presentation/action_controller/create_user/action_controller.dart';
import 'package:action_controller_sample/presentation/shared/dialog/app_dialog.dart';
import 'package:action_controller_sample/presentation/shared/snack_bar/app_snack_bar.dart';
import 'package:action_controller_sample/util/extension_async_value.dart';
import 'package:async/async.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

typedef CreateUserAction = ({
  Future<void> Function({required ScreenLocation location}) action,
});

/// CreateUserActionを使用するためのフック
CreateUserAction useCreateUserController(WidgetRef ref) {
  //----------------------------------------------------------------------------
  // property
  //----------------------------------------------------------------------------
  final provider = createUserActionControllerProvider;
  final actionController = ref.read(provider.notifier);
  final context = useContext();
  final cache = AsyncCache<void>.ephemeral();

  //----------------------------------------------------------------------------
  // action
  //----------------------------------------------------------------------------

  Future<void> action({required ScreenLocation location}) async {
    await cache.fetch(() async {
      await actionController.execute(location: location);

      final hasError = ref.read(provider).hasError;
      if (!context.mounted || hasError) return;

      await showAppSnackBar(context, message: 'User created successfully');
    });
  }

  return (action: action);
}

/// CreateUserActionControllerのエラーハンドリング
void useCreateUserHandler(WidgetRef ref) {
  final context = useContext();

  ref.listen(
    createUserActionControllerProvider,
    (_, next) {
      if (!next.isLoadingFailed) return;

      if (next.error
          case ActionException(
            exception: final exception,
            location: final location
          )) {
        switch (exception) {
          case DuplicateUserNameException():
            switch (location) {
              case ScreenLocation.home:
                showAppDialog(
                  context,
                  title: '重複エラー',
                  message: '$location 同じ名前のユーザーがすでに存在します。',
                  buttonText: 'OK',
                );
              case ScreenLocation.apple:
              case ScreenLocation.banana:
                showAppSnackBar(
                  context,
                  message: '$location 同じ名前のユーザーがすでに存在します。',
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
    },
  );
}
