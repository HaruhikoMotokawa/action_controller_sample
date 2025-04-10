import 'package:action_controller_sample/domain/enums/screen_location.dart';

class ActionException implements Exception {
  const ActionException(
    this.exception,
    this.location,
  );
  final Exception exception;
  final ScreenLocation location;

  @override
  String toString() =>
      'ExceptionWithLocation(exception: $exception, location: $location)';
}

extension ExceptionWithLocationExtension on Exception {
  ActionException withLocation(ScreenLocation location) {
    return ActionException(this, location);
  }
}
