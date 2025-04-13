import 'dart:async';

import 'package:action_controller_sample/domain/enums/caller.dart';

abstract interface class ExecutorBase {
  FutureOr<void> build(Caller caller);
}
