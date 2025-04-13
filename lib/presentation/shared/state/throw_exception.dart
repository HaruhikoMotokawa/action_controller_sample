import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'throw_exception.g.dart';

@riverpod
class ThrowException extends _$ThrowException {
  @override
  bool build() => false;

  void call() => state = !state;
}
