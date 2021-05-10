import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class Failure extends Equatable {
  Failure([List properties = const <dynamic>[]]) : super();
}

class NoInternetFailure extends Failure {
  @override
  List<Object> get props => [];
}

class ServerFailure extends Failure {
  final String message;
  ServerFailure({
    @required this.message,
  });

  @override
  List<Object> get props => [message];
}

class CacheFailure extends Failure {
  @override
  List<Object> get props => [];
}

class NoEntityFailure extends Failure {
  @override
  List<Object> get props => [];
}

class PendingFailure extends Failure {
  @override
  List<Object> get props => [];
}

class UpdateRequiredFailure extends Failure {
  final String message;
  UpdateRequiredFailure({
    this.message,
  });
  @override
  List<Object> get props => [message];
}

class NullFailure extends Failure {
  @override
  List<Object> get props => [];
}

class UnknownFailure extends Failure {
  @override
  List<Object> get props => [];
}

class FailureToMessage {
  static String mapFailureToMessage(Failure failure) {
    var message = 'An Error occurred, please try again';
    if (failure is NoInternetFailure) {
      message = 'Please check your internet connection and try again';
    } else if (failure is ServerFailure) {
      message = failure.message;
    } else if (failure is CacheFailure || failure is NoEntityFailure) {
      message = 'Entity not found, please try again';
    } else if (failure is PendingFailure) {
      message = 'Request is pending, please try again later';
    } else if (failure is UpdateRequiredFailure) {
      message = failure.message;
    }
    return message;
  }
}
