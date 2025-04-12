import 'package:action_controller_sample/data/repositories/user/provider.dart';
import 'package:action_controller_sample/domain/enums/caller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'executor.g.dart';

@riverpod
class UpdateUserExecutor extends _$UpdateUserExecutor {
  @override
  Future<void> build(Caller caller) async {}

  Future<void> call() async {
    state = await AsyncValue.guard(() async {
      await ref.read(userRepositoryProvider).update();
    });
  }
}
