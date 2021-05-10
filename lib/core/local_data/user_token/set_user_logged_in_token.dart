import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hagglex/core/constants/loca_data_constants.dart';

// ignore: one_member_abstracts
abstract class SaveLoggedInUserToken {
  Future<void> call(String token);
}

class SaveLoggedInUserTokenImpl implements SaveLoggedInUserToken {
  final FlutterSecureStorage flutterSecureStorage;

  SaveLoggedInUserTokenImpl(this.flutterSecureStorage);

  @override
  Future<void> call(String token) async {
    return await flutterSecureStorage.write(
        key: loggedInUserToken, value: token);
  }
}
