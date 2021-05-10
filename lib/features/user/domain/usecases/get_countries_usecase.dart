import 'package:dartz/dartz.dart';
import 'package:hagglex/core/errors/failure.dart';
import 'package:hagglex/features/user/domain/entities/country_entity.dart';
import 'package:hagglex/features/user/domain/repositories/user_repository.dart';
import 'package:meta/meta.dart';

class GetCountriesUsecase {
  final UserRepository userRepository;
  GetCountriesUsecase({
    @required this.userRepository,
  });
  Future<Either<Failure, List<CountryEntity>>> call() async {
    return await userRepository.getCountries();
  }
}
