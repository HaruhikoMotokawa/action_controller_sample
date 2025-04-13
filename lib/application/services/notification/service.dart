import 'package:action_controller_sample/data/repositories/local_notification/provider.dart';
import 'package:action_controller_sample/data/repositories/todo/provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class NotificationService {
  NotificationService(this.ref);
  final Ref ref;

  /// TODOを時間で通知する
  Future<void> scheduleTodoNotification({required String todoId}) async {
    final todoRepository = ref.read(todoRepositoryProvider);
    final localNotificationRepository =
        ref.read(localNotificationRepositoryProvider);

    final todo = await todoRepository.findById(todoId);
    final scheduledTime = DateTime.now().add(const Duration(seconds: 5));

    await localNotificationRepository.scheduleNotification(
      title: todo.title,
      body: todo.description,
      scheduledTime: scheduledTime,
    );
  }
}
