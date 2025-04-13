import 'package:action_controller_sample/data/repositories/user/provider.dart';
import 'package:action_controller_sample/domain/enums/caller.dart';
import 'package:action_controller_sample/domain/models/user.dart';
import 'package:action_controller_sample/use_case/executors/_executor_base/executor_base.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'executor.g.dart';

@riverpod
class CreateUserExecutor extends _$CreateUserExecutor implements ExecutorBase {
  @override
  FutureOr<void> build(Caller caller) {}

  FutureOr<void> call(User user, {required bool throwException}) async {
    state = await AsyncValue.guard(() async {
      await ref
          .read(userRepositoryProvider)
          .create(user, throwException: throwException);
    });
  }
}
