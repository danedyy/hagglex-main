import 'package:dartz/dartz.dart';
import 'package:hagglex/core/errors/failure.dart';
import 'package:hagglex/features/user/domain/entities/user_entity.dart';
import 'package:hagglex/features/user/domain/repositories/user_repository.dart';
import 'package:meta/meta.dart';

class LoginUsecase {
  final UserRepository userRepository;
  LoginUsecase({
    @required this.userRepository,
  });
  Future<Either<Failure, UserEntity>> call(
      String email, String password) async {
    return await userRepository.login(email, password);
  }
}
