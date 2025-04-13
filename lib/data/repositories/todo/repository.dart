import 'package:action_controller_sample/domain/models/todo.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TodoRepository {
  TodoRepository(this.ref);
  final Ref ref;

  Future<Todo> findById(String id) async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
    return Todo(
      id: id,
      title: 'Sample Title',
      description: 'Sample Description',
    );
  }
}
