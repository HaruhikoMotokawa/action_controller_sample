/// ユーザー名が重複している
class DuplicateUserNameException implements Exception {
  DuplicateUserNameException(this.message);
  final String message;

  @override
  String toString() {
    return 'DuplicateUserNameException: $message';
  }
}

/// ユーザーが見つからない
class UserNotFoundException implements Exception {
  UserNotFoundException(this.message);
  final String message;

  @override
  String toString() {
    return 'UserNotFoundException: $message';
  }
}

/// サーバーエラー
class ServerErrorException implements Exception {
  ServerErrorException(this.message);
  final String message;

  @override
  String toString() {
    return 'ServerErrorException: $message';
  }
}
