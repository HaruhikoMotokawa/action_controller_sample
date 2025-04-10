import 'package:hooks_riverpod/hooks_riverpod.dart';

extension AsyncValueX<T> on AsyncValue<T> {
  bool get isLoadingFailed => hasError && isLoading == false;
}
