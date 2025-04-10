import 'package:action_controller_sample/domain/enums/screen_location.dart';

/// ActionControllerで発生した例外を、どの画面で発生したかを保持するためのクラス
///
/// 画面単位でハンドリングする場合は必ずラップする
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

extension ExceptionWithLocation on Exception {
  /// ActionExceptionにラップするヘルパー関数
  ActionException withLocation(ScreenLocation location) =>
      ActionException(this, location);
}
