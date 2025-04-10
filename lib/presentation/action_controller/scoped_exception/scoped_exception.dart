import 'package:action_controller_sample/domain/enums/screen_location.dart';

class ExceptionWithLocation implements Exception {
  const ExceptionWithLocation(
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
  ExceptionWithLocation withLocation(ScreenLocation location) {
    return ExceptionWithLocation(this, location);
  }
}
