import 'package:action_controller_sample/data/repositories/user/provider.dart';
import 'package:action_controller_sample/domain/enums/screen_location.dart';
import 'package:action_controller_sample/presentation/action_controller/_action_exception/exception.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'action_controller.g.dart';

@Riverpod(keepAlive: true)
class CreateUserActionController extends _$CreateUserActionController {
  @override
  FutureOr<void> build() {}

  FutureOr<void> execute({required ScreenLocation location}) async {
    final repository = ref.read(userRepositoryProvider);
    state = const AsyncLoading();
    try {
      await repository.create();
      state = const AsyncData(null);
    } on Exception catch (e, s) {
      state = AsyncError(e.withLocation(location), s);
    }
  }
}
