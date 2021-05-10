import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// ignore: one_member_abstracts
abstract class DeleteUserSession {
  Future<void> call();
}

class DeleteUserSessionImpl implements DeleteUserSession {
  final FlutterSecureStorage flutterSecureStorage;

  DeleteUserSessionImpl(this.flutterSecureStorage);

  @override
  Future<void> call() async {
    await flutterSecureStorage.deleteAll();
  }
}
