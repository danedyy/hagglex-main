import 'package:hagglex/features/user/domain/entities/country_entity.dart';
import 'package:meta/meta.dart';

class CountryModel extends CountryEntity {
  CountryModel({
    @required String id,
    @required String callingCode,
    @required String currencyCode,
    @required String flag,
    @required String name,
  }) : super(
          id: id,
          callingCode: callingCode,
          currencyCode: currencyCode,
          flag: flag,
          name: name,
        );

  factory CountryModel.fromMap(Map<String, dynamic> map) {
    return CountryModel(
      id: map['_id'],
      callingCode: map['callingCode'],
      currencyCode: map['currencyCode'],
      flag: map['flag'],
      name: map['name'],
    );
  }
}
