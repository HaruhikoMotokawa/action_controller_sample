import 'package:action_controller_sample/application/services/notification/provider.dart';
import 'package:action_controller_sample/domain/enums/caller.dart';
import 'package:action_controller_sample/use_case/executors/_executor_base/executor_base.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'executor.g.dart';

@riverpod
class ScheduleTodoNotificationExecutor
    extends _$ScheduleTodoNotificationExecutor implements ExecutorBase {
  @override
  FutureOr<void> build(Caller caller) {}

  FutureOr<void> call({required String todoId}) async =>
      state = await AsyncValue.guard(() async {
        await ref
            .read(notificationServiceProvider)
            .scheduleTodoNotification(todoId: todoId);
      });
}
