import 'package:action_controller_sample/data/repositories/user/provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'action_controller.g.dart';

@Riverpod(keepAlive: true)
class CreateUserActionController extends _$CreateUserActionController {
  @override
  FutureOr<void> build() {}

  FutureOr<void> execute() async {
    final repository = ref.read(userRepositoryProvider);

    state = await AsyncValue.guard(() async {
      await repository.create();
    });
  }
}
