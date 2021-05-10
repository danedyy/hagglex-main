import 'package:dartz/dartz.dart';
import 'package:hagglex/core/errors/failure.dart';
import 'package:hagglex/features/user/data/models/user_model.dart';
import 'package:hagglex/features/user/domain/entities/country_entity.dart';
import 'package:hagglex/features/user/domain/entities/user_entity.dart';
import 'package:meta/meta.dart';

abstract class UserRepository {
  Future<Either<Failure, UserEntity>> register({
    @required String email,
    @required String password,
    @required String username,
    @required String phone,
    @required CountryEntity country,
    String referralCode,
  });
  Future<Either<Failure, UserEntity>> verifyOtp(String code);
  Future<Either<Failure, List<CountryEntity>>> getCountries();
  Future<Either<Failure, bool>> resendOtp(String email);
  Future<Either<Failure, UserModel>> login(String email, String password);
}
