import 'package:action_controller_sample/core/log/logger.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LocalNotificationRepository {
  LocalNotificationRepository(this.ref);
  final Ref ref;

  Future<void> scheduleNotification({
    required String title,
    required String body,
    required DateTime scheduledTime,
  }) async =>
      logger.d('Notification scheduled: $title, $body at $scheduledTime');
}
