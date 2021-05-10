import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hagglex/core/constants/loca_data_constants.dart';

// ignore: one_member_abstracts
abstract class GetLoggedInUserToken {
  Future<String> call();
}

class GetLoggedInUserTokenImpl implements GetLoggedInUserToken {
  final FlutterSecureStorage flutterSecureStorage;

  GetLoggedInUserTokenImpl(this.flutterSecureStorage);

  @override
  Future<String> call() async {
    return await flutterSecureStorage.read(key: loggedInUserToken);
  }
}
