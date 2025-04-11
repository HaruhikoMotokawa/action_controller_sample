import 'package:action_controller_sample/domain/enums/screen_location.dart';
import 'package:action_controller_sample/presentation/action_controller/_action_exception/exception.dart';
import 'package:action_controller_sample/util/extension_async_value.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void useExceptionHandler<T>(
  Refreshable<AsyncValue<T>> provider,
  WidgetRef ref, {
  required void Function({
    required Exception exception,
    required BuildContext context,
  }) onException,
}) {
  final context = useContext();

  ref.listen<AsyncValue<T>>(
    provider,
    (_, next) {
      if (!next.isLoadingFailed) return;

      if (next.error case final exception? when exception is Exception) {
        onException(
          exception: exception,
          context: context,
        );
      }
    },
  );
}

void useActionExceptionHandler<T>(
  Refreshable<AsyncValue<T>> provider,
  WidgetRef ref,
  ScreenLocation handlerLocation, {
  required void Function({
    required Exception exception,
    required ScreenLocation location,
    required BuildContext context,
  }) onException,
}) {
  final context = useContext();

  ref.listen<AsyncValue<T>>(
    provider,
    (_, next) {
      if (!next.isLoadingFailed) return;

      if (next.error
          case ActionException(
            exception: final exception,
            location: final location
          )) {
        // 例外が発生した場所と、ハンドリングする場所が異なる場合は、何もしない
        if (location != handlerLocation) return;

        onException(
          exception: exception,
          location: location,
          context: context,
        );
      }
    },
  );
}
