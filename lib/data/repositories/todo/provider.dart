import 'package:action_controller_sample/data/repositories/todo/repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'provider.g.dart';

@Riverpod(keepAlive: true)
TodoRepository todoRepository(Ref ref) => TodoRepository(ref);
