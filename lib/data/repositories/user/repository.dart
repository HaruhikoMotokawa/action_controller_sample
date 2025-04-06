import 'package:action_controller_sample/core/log/logger.dart';
import 'package:action_controller_sample/data/repositories/user/exception.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UserRepository {
  UserRepository(this.ref);
  final Ref ref;

  /// 新規作成
  Future<void> create({
    UserRepositoryError error = UserRepositoryError.none,
  }) async {
    try {
      await Future<void>.delayed(const Duration(microseconds: 1));

      _throwException(error);
      logger.d('create');
    } on DuplicateUserNameException catch (e) {
      throw DuplicateUserNameException(e.message);
    } on ServerErrorException catch (e) {
      throw ServerErrorException(e.message);
    } on Exception catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
  }

  /// 更新
  Future<void> update() async {
    try {
      await Future<void>.delayed(const Duration(microseconds: 1));
      logger.d('update');
    } on UserNotFoundException catch (e) {
      throw UserNotFoundException(e.message);
    } on ServerErrorException catch (e) {
      throw ServerErrorException(e.message);
    } on Exception catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
  }
}

extension on UserRepository {
  void _throwException(UserRepositoryError error) {
    switch (error) {
      case UserRepositoryError.firstException:
        throw DuplicateUserNameException('Duplicate user name');
      case UserRepositoryError.serverError:
        throw ServerErrorException('Server error');
      case UserRepositoryError.exception:
        throw Exception('An unexpected error occurred');
      case UserRepositoryError.none:
        // 正常系
        break;
    }
  }
}

enum UserRepositoryError {
  none,
  firstException,
  serverError,
  exception,
}
