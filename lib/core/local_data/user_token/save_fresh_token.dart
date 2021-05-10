import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hagglex/core/constants/loca_data_constants.dart';


// ignore: one_member_abstracts
abstract class SaveRefreshToken {
  Future<void> call(String token);
}

class SaveRefreshTokenImpl implements SaveRefreshToken {
  final FlutterSecureStorage flutterSecureStorage;

  SaveRefreshTokenImpl(this.flutterSecureStorage);

  @override
  Future<void> call(String token) async {
    return await flutterSecureStorage.write(key: refreshToken, value: token);
  }
}

// ignore: one_member_abstracts
abstract class GetRefreshToken {
  Future<String> call();
}

class GetRefreshTokenImpl implements GetRefreshToken {
  final FlutterSecureStorage flutterSecureStorage;

  GetRefreshTokenImpl(this.flutterSecureStorage);

  @override
  Future<String> call() async {
    return await flutterSecureStorage.read(key: refreshToken);
  }
}
