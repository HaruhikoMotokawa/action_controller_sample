import 'dart:async';

import 'package:action_controller_sample/data/repositories/user/exception.dart';
import 'package:action_controller_sample/domain/enums/caller.dart';
import 'package:action_controller_sample/presentation/action_controller/_hooks/hooks.dart';
import 'package:action_controller_sample/presentation/shared/banner/app_banner.dart';
import 'package:action_controller_sample/presentation/shared/dialog/app_dialog.dart';
import 'package:action_controller_sample/presentation/shared/snack_bar/app_snack_bar.dart';
import 'package:action_controller_sample/use_case/executors/update_user/executor.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

typedef UpdateUserAction = ({
  FutureOr<void> Function() action,
});

/// UpdateUserActionを使用するためのフック
UpdateUserAction useUpdateUserController(
  WidgetRef ref, {
  required Caller caller,
}) {
  //----------------------------------------------------------------------------
  // property
  //----------------------------------------------------------------------------
  final provider = updateUserExecutorProvider(caller);
  final updateUser = ref.read(provider.notifier);

  //----------------------------------------------------------------------------
  // action and exception handler
  //----------------------------------------------------------------------------
  final base = useActionControllerBase(
    ref,
    provider,
    action: (context) async {
      await updateUser();

      final hasError = ref.read(provider).hasError;
      if (!context.mounted || hasError) return;

      await showAppSnackBar(
        context,
        message: 'User updated successfully in $caller',
      );
    },
    onError: (exception, context) {
      switch ((exception, caller)) {
        case (DuplicateUserNameException(), Caller.homeScreen):
          showAppSnackBar(
            context,
            message: '$caller 同じ名前のユーザーがすでに存在します。',
          );
        case (DuplicateUserNameException(), Caller.appleScreen):
          showAppDialog(
            context,
            title: 'エラー',
            message: '$caller 同じ名前のユーザーがすでに存在します。',
            buttonText: '閉じる',
          );
        case (DuplicateUserNameException(), Caller.bananaScreen):
          showAppBanner(
            context,
            message: '$caller 同じ名前のユーザーがすでに存在します。',
          );
        case (UserNotFoundException(), Caller.homeScreen):
          showAppSnackBar(
            context,
            message: '$caller ユーザーが見つかりません。',
          );
        case (UserNotFoundException(), Caller.appleScreen):
          showAppDialog(
            context,
            title: 'エラー',
            message: '$caller ユーザーが見つかりません。',
            buttonText: '閉じる',
          );
        case (UserNotFoundException(), Caller.bananaScreen):
          showAppBanner(
            context,
            message: '$caller ユーザーが見つかりません。',
          );
        case (ServerErrorException(), Caller.bananaScreen):
          showAppBanner(
            context,
            message: 'サーバーでエラーが発生しました。時間をおいて再試行してください。',
          );
        case (ServerErrorException(), Caller.appleScreen):
          showAppDialog(
            context,
            title: 'サーバーエラー',
            message: 'サーバーでエラーが発生しました。時間をおいて再試行してください。',
            buttonText: '了解',
          );
        case (ServerErrorException(), _):
          showAppSnackBar(
            context,
            message: 'サーバーでエラーが発生しました。時間をおいて再試行してください。',
          );
        case (Exception(), Caller.bananaScreen):
          showAppBanner(
            context,
            message: '予期しないエラーが発生しました。',
          );
        case (Exception(), Caller.appleScreen):
          showAppDialog(
            context,
            title: '不明なエラー',
            message: '予期しないエラーが発生しました。',
            buttonText: '閉じる',
          );
        case (Exception(), _):
          showAppSnackBar(
            context,
            message: '予期しないエラーが発生しました。',
          );
      }
    },
  );

  return (action: base.action);
}
