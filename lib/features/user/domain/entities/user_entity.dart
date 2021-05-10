import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class UserEntity extends Equatable {
  final String email;
  final String username;
  final String phone;
  final bool emailVerified;
  UserEntity({
    @required this.email,
    @required this.username,
    @required this.phone,
    @required this.emailVerified,
  });

  @override
  List<Object> get props => [email, username, phone];
}
