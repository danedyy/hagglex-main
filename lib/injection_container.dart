import 'package:connectivity/connectivity.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hagglex/core/constants/env_constants.dart';
import 'package:hagglex/core/local_data/user_data/delete_user_session.dart';
import 'package:hagglex/core/local_data/user_token/get_user_logged_in_token.dart';
import 'package:hagglex/core/local_data/user_token/set_user_logged_in_token.dart';
import 'package:hagglex/core/navigations/navigation_service.dart';
import 'package:hagglex/core/network/graph_client.dart';
import 'package:hagglex/core/network/network_info.dart';
import 'package:hagglex/features/user/data/datasources/remote_datasource.dart';
import 'package:hagglex/features/user/data/repositories/user_repository_impl.dart';
import 'package:hagglex/features/user/domain/repositories/user_repository.dart';
import 'package:hagglex/features/user/domain/usecases/login_usecase.dart';
import 'package:hagglex/features/user/domain/usecases/register_usecase.dart';
import 'package:hagglex/features/user/domain/usecases/resend_otp_usecase.dart';
import 'package:hagglex/features/user/domain/usecases/verify_otp_usecase.dart';
import 'package:hagglex/features/user/presentation/providers/auth_provider.dart';

import 'core/local_data/user_data/get_loggedin_user_data.dart';
import 'core/local_data/user_data/save_loggedin_user_data.dart';
import 'core/local_data/user_token/save_fresh_token.dart';
import 'features/user/domain/usecases/get_countries_usecase.dart';

GetIt sl = GetIt.instance;

Future<void> setupLocator() async {
  // final SharedPreferences sharedPreferences =
  //     await SharedPreferences.getInstance();
  //******************* Dependecences *************************

  // sl.registerLazySingleton(() => DioCacheManager(
  //       CacheConfig(),
  //     ));
  final storage = FlutterSecureStorage();

  sl.registerLazySingleton(
    () => Connectivity(),
  );

  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(sl()),
  );

  sl.registerLazySingleton(() => DataConnectionChecker());

  //********************** core */

  sl.registerLazySingleton<SaveLoggedInUserData>(
    () => SaveLoggedInUserDataImpl(
      storage,
    ),
  );

  sl.registerSingleton<GetLoggedInUserData>(
    GetLoggedInUserDataImpl(
      storage,
    ),
  );

  sl.registerLazySingleton<SaveRefreshToken>(
    () => SaveRefreshTokenImpl(
      storage,
    ),
  );
  sl.registerLazySingleton(
    () => GraphQLClientConc(
      authLink: AuthLink(
        getToken: () => '',
      ),
      httpLink: HttpLink(
        env[baseUrlEnv],
      ),
    ),
  );

  sl.registerLazySingleton<GetRefreshToken>(
    () => GetRefreshTokenImpl(
      storage,
    ),
  );

  sl.registerLazySingleton<GetLoggedInUserToken>(
    () => GetLoggedInUserTokenImpl(
      storage,
    ),
  );
  sl.registerLazySingleton<SaveLoggedInUserToken>(
    () => SaveLoggedInUserTokenImpl(
      storage,
    ),
  );

  sl.registerLazySingleton<DeleteUserSession>(
    () => DeleteUserSessionImpl(storage),
  );

  //******************* Usecases *************************

  sl.registerLazySingleton(
    () => RegisterUsecase(
      userRepository: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => LoginUsecase(
      userRepository: sl(),
    ),
  );
    sl.registerLazySingleton(
    () => GetCountriesUsecase(
      userRepository: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => ResendOtpUsecase(
      userRepository: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => VerifyOtpUsecase(
      userRepository: sl(),
    ),
  );

  //******************* Data sources *************************
  sl.registerLazySingleton<UserRemoteDatasource>(
    () => UserRemoteDatasourceImpl(
      networkInfo: sl(),
      graphQLClientConc: sl(),
      saveLoggedInUserData: sl(),
      saveLoggedInUserToken: sl(),
      getLoggedInUserToken: sl(),
    ),
  );

  //******************* Repositories *************************
  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(
      sl(),
    ),
  );

  //******************* Providers *************************
  sl.registerLazySingleton(
    () => AuthProvider(
      registerUsecase: sl(),
      loginUsecase: sl(),
      getCountriesUsecase: sl(),
      resendOtpUsecase: sl(),
      verifyOtpUsecase: sl(),
      getLoggedInUserData: sl()
    ),
  );

  //******************* Services *************************
  sl.registerLazySingleton(
    () => NavigationService(),
  );
}
