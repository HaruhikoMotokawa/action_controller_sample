import 'package:action_controller_sample/data/repositories/user/provider.dart';
import 'package:action_controller_sample/domain/enums/caller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'executor.g.dart';

@riverpod
class CreateUserExecutor extends _$CreateUserExecutor {
  @override
  FutureOr<void> build(Caller caller) {}

  FutureOr<void> call() async {
    state = await AsyncValue.guard(() async {
      await ref.read(userRepositoryProvider).create();
    });
  }

  void reset() {
    state = const AsyncValue.data(null);
  }
}
