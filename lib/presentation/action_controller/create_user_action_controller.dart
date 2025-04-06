import 'package:action_controller_sample/data/repositories/user/provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'create_user_action_controller.g.dart';

@Riverpod(keepAlive: true)
class CreateUserActionController extends _$CreateUserActionController {
  @override
  FutureOr<void> build() {}

  Future<bool> execute() async {
    final repository = ref.read(userRepositoryProvider);
    state = const AsyncValue.loading();
    try {
      await repository.create(throwException: true);
      state = const AsyncValue.data(null);
      return true;
      // ignore: avoid_catches_without_on_clauses
    } catch (e, s) {
      state = AsyncValue.error(e, s);
      return false;
    }
  }
}
