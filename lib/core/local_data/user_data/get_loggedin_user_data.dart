import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hagglex/core/constants/loca_data_constants.dart';
import 'package:hagglex/features/user/data/models/user_model.dart';

// ignore: one_member_abstracts
abstract class GetLoggedInUserData {
  Future<UserModel> call();
}

class GetLoggedInUserDataImpl implements GetLoggedInUserData {
  final FlutterSecureStorage flutterSecureStorage;

  GetLoggedInUserDataImpl(this.flutterSecureStorage);

  @override
  Future<UserModel> call() async {
    if (await flutterSecureStorage.read(key: loggedInUserData) == null) {
      return Future.value(null);
    }
    return UserModel.fromMap(
      json.decode(await flutterSecureStorage.read(key: loggedInUserData)),
    );
  }
}
