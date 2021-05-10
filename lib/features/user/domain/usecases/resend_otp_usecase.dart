import 'package:dartz/dartz.dart';
import 'package:hagglex/core/errors/failure.dart';
import 'package:hagglex/features/user/domain/repositories/user_repository.dart';
import 'package:meta/meta.dart';

class ResendOtpUsecase {
  final UserRepository userRepository;
  ResendOtpUsecase({
    @required this.userRepository,
  });
  Future<Either<Failure, bool>> call(String email) async {
    return await userRepository.resendOtp(email);
  }
}
