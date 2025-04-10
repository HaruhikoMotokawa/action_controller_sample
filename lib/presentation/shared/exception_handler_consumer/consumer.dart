import 'package:action_controller_sample/presentation/action_controller/create_user/use_action_controller.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// アプリで発生する例外をキャッチして、ハンドリングするためのWidget
class ExceptionHandlerConsumer extends HookConsumerWidget {
  const ExceptionHandlerConsumer({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useCreateUserHandler(ref);
    // ...

    //
    return child;
  }
}
