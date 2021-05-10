import 'package:dartz/dartz.dart';
import 'package:hagglex/core/errors/failure.dart';
import 'package:hagglex/features/user/domain/entities/country_entity.dart';
import 'package:hagglex/features/user/domain/entities/user_entity.dart';
import 'package:hagglex/features/user/domain/repositories/user_repository.dart';
import 'package:meta/meta.dart';

class RegisterUsecase {
  final UserRepository userRepository;
  RegisterUsecase({
    @required this.userRepository,
  });
  Future<Either<Failure, UserEntity>> call({
    @required String email,
    @required String password,
    @required String username,
    @required String phone,
    @required CountryEntity country,
    String referralCode,
  }) async {
    return await userRepository.register(
      email: email,
      password: password,
      username: username,
      phone: phone,
      referralCode: referralCode,
      country: country,
    );
  }
}
