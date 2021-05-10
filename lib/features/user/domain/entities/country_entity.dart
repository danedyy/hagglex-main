import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class CountryEntity extends Equatable {
  final String id;
  final String name;
  final String flag;
  final String callingCode;
  final String currencyCode;
  CountryEntity({
    @required this.id,
    @required this.name,
    @required this.flag,
    @required this.callingCode,
    @required this.currencyCode,
  });

  @override
  List<Object> get props =>
      [id, name, flag, callingCode, currencyCode];
}
