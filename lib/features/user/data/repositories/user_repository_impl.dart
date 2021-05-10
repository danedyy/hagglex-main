import 'package:dartz/dartz.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hagglex/core/errors/error.dart';
import 'package:hagglex/core/errors/failure.dart';
import 'package:hagglex/features/user/data/datasources/remote_datasource.dart';
import 'package:hagglex/features/user/data/models/user_model.dart';
import 'package:hagglex/features/user/domain/entities/country_entity.dart';
import 'package:hagglex/features/user/domain/entities/user_entity.dart';
import 'package:hagglex/features/user/domain/repositories/user_repository.dart';
import 'package:logger/logger.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDatasource userRemoteDatasource;

  UserRepositoryImpl(this.userRemoteDatasource);

  @override
  Future<Either<Failure, UserEntity>> register({
    String email,
    String password,
    String username,
    String phone,
    String referralCode,
    CountryEntity country,
  }) async {
    try {
      var response = await userRemoteDatasource.register(
        email: email,
        password: password,
        username: username,
        phone: phone,
        referralCode: referralCode,
        country: country,
      );
      return Right(response);
    } catch (e) {
      Logger().e(e);
      if (e is NoInternetException) {
        return Left(NoInternetFailure());
      } else if (e is OperationException) {
        return Left(
          ServerFailure(
            message: e.graphqlErrors[0].message,
          ),
        );
      } else {
        return Left(UnknownFailure());
      }
    }
  }

  @override
  Future<Either<Failure, UserModel>> login(
      String email, String password) async {
    try {
      var response = await userRemoteDatasource.login(
        email: email,
        password: password,
      );
      return Right(response);
    } catch (e) {
      Logger().e(e);
      if (e is NoInternetException) {
        return Left(NoInternetFailure());
      } else if (e is OperationException) {
        return Left(
          ServerFailure(
            message: e.graphqlErrors[0].message,
          ),
        );
      } else {
        return Left(UnknownFailure());
      }
    }
  }

  @override
  Future<Either<Failure, bool>> resendOtp(String email) async {
    try {
      var response = await userRemoteDatasource.resendVerificationCode(
        email: email,
      );
      return Right(response);
    } catch (e) {
      Logger().e(e);
      if (e is NoInternetException) {
        return Left(NoInternetFailure());
      } else if (e is OperationException) {
        return Left(
          ServerFailure(
            message: e.graphqlErrors.isNotEmpty
                ? e.graphqlErrors[0].message
                : 'Server error',
          ),
        );
      } else {
        return Left(UnknownFailure());
      }
    }
  }

  @override
  Future<Either<Failure, UserEntity>> verifyOtp(String code) async {
    try {
      var response = await userRemoteDatasource.verifyUser(
        code: code,
      );
      return Right(response);
    } catch (e) {
      Logger().e(e);
      if (e is NoInternetException) {
        return Left(NoInternetFailure());
      } else if (e is OperationException) {
        return Left(
          ServerFailure(
            message: e.graphqlErrors.isNotEmpty
                ? e.graphqlErrors[0].message
                : 'Server error',
          ),
        );
      } else {
        return Left(UnknownFailure());
      }
    }
  }

  @override
  Future<Either<Failure,List<CountryEntity>>> getCountries() async {
    try {
      var response = await userRemoteDatasource.getCountries();
      return Right(response);
    } catch (e) {
      Logger().e(e);
      if (e is NoInternetException) {
        return Left(NoInternetFailure());
      } else if (e is OperationException) {
        return Left(
          ServerFailure(
            message: e.graphqlErrors[0].message,
          ),
        );
      } else {
        return Left(UnknownFailure());
      }
    }
  }
}
