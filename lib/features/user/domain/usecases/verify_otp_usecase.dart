import 'package:dartz/dartz.dart';
import 'package:hagglex/core/errors/failure.dart';
import 'package:hagglex/features/user/domain/entities/user_entity.dart';
import 'package:hagglex/features/user/domain/repositories/user_repository.dart';
import 'package:meta/meta.dart';

class VerifyOtpUsecase {
  final UserRepository userRepository;
  VerifyOtpUsecase({
    @required this.userRepository,
  });
  Future<Either<Failure, UserEntity>> call(String code) async {
    return await userRepository.verifyOtp(code);
  }
}
