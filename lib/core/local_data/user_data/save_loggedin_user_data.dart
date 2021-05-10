import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hagglex/core/constants/loca_data_constants.dart';
import 'package:hagglex/features/user/data/models/user_model.dart';

// ignore: one_member_abstracts
abstract class SaveLoggedInUserData {
  Future<void> call(UserModel userModel);
}

class SaveLoggedInUserDataImpl implements SaveLoggedInUserData {
  final FlutterSecureStorage flutterSecureStorage;

  SaveLoggedInUserDataImpl(this.flutterSecureStorage);

  @override
  Future<void> call(UserModel userModel) {
    return flutterSecureStorage.write(
      key: loggedInUserData,
      value: json.encode(
        userModel.toMap(),
      ),
    );
  }
}
