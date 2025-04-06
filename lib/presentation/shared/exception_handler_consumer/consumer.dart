import 'package:action_controller_sample/data/repositories/user/exception.dart';
import 'package:action_controller_sample/presentation/action_controller/create_user_action_controller.dart';
import 'package:action_controller_sample/presentation/shared/dialog/app_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExceptionHandlerConsumer extends ConsumerWidget {
  const ExceptionHandlerConsumer({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _createUserExceptionHandler(context, ref);
    return child;
  }
}

extension on ExceptionHandlerConsumer {
  bool _isError(AsyncValue state) => state.hasError && state.isLoading == false;

  Future<void> _createUserExceptionHandler(
    BuildContext context,
    WidgetRef ref,
  ) async {
    ref.listen(
      createUserActionControllerProvider,
      (_, next) {
        if (_isError(next)) {
          switch (next.error) {
            case DuplicateUserNameException():
              showAppDialog(
                context,
                title: '重複エラー',
                message: '同じ名前のユーザーがすでに存在します。',
                buttonText: 'OK',
              );
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
}
