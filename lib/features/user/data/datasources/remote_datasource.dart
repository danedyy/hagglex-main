import 'package:gql/language.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hagglex/core/errors/error.dart';
import 'package:hagglex/core/local_data/user_data/save_loggedin_user_data.dart';
import 'package:hagglex/core/local_data/user_token/get_user_logged_in_token.dart';
import 'package:hagglex/core/local_data/user_token/set_user_logged_in_token.dart';
import 'package:hagglex/core/network/graph_client.dart';
import 'package:hagglex/core/network/network_info.dart';
import 'package:hagglex/core/network/queries/mutation/mutation.dart' as mutaion;
import 'package:hagglex/core/network/queries/queries/queries.dart' as queries;
import 'package:hagglex/features/user/data/models/country_model.dart';
import 'package:hagglex/features/user/data/models/user_model.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';

// ignore: one_member_abstracts
abstract class UserRemoteDatasource {
  Future<UserModel> register({
    @required String email,
    @required String password,
    @required String username,
    @required String phone,
    @required CountryModel country,
    String referralCode,
  });
  Future<UserModel> verifyUser({
    @required String code,
  });
  Future<List<CountryModel>> getCountries();
  Future<bool> resendVerificationCode({
    @required String email,
  });
  Future<UserModel> login({
    @required String email,
    @required String password,
  });
}

class UserRemoteDatasourceImpl implements UserRemoteDatasource {
  final NetworkInfo networkInfo;
  final GraphQLClientConc graphQLClientConc;
  final SaveLoggedInUserData saveLoggedInUserData;
  final SaveLoggedInUserToken saveLoggedInUserToken;
  final GetLoggedInUserToken getLoggedInUserToken;

  UserRemoteDatasourceImpl({
    @required this.networkInfo,
    @required this.graphQLClientConc,
    @required this.saveLoggedInUserData,
    @required this.saveLoggedInUserToken,
    @required this.getLoggedInUserToken,
  });

  @override
  Future<UserModel> register({
    @required String email,
    @required String password,
    @required String username,
    @required String phone,
    @required CountryModel country,
    String referralCode,
  }) async {
    if (await networkInfo.isConnected) {
      Logger().i(
        '0$phone',
      );
      // print(country.name);
      final _options = MutationOptions(
        document: parseString(mutaion.registerQuery),
        variables: <String, dynamic>{
          'input': {
            'username': username,
            'password': password,
            'email': email,
            'currency': country.currencyCode,
            'country': country.name,
            'phonenumber': phone,
            'phoneNumberDetails': {
              'flag': country.flag,
              'callingCode': country.callingCode,
              'phoneNumber': phone
            }
          },
        },
      );

      var queryResult = await graphQLClientConc.mutate(_options);
      if (queryResult.hasException) {
        throw queryResult.exception;
      }
      Logger().i(queryResult.data);
      Logger().i(queryResult);
      var user = UserModel.fromMap(
        queryResult.data['register']['user'],
      );

      await saveLoggedInUserData(
        user,
      );
      await saveLoggedInUserToken(
        queryResult.data['register']['token'],
      );
      return user;
    } else {
      throw NoInternetException();
    }
  }

  @override
  Future<UserModel> verifyUser({String code}) async {
    if (await networkInfo.isConnected) {
      final _options = MutationOptions(
        document: parseString(mutaion.verifyAccountQuery),
        variables: <String, dynamic>{
          'input': {
            'code': int.parse(code),
          },
        },
      );

      var token = await getLoggedInUserToken();
      var queryResult = await graphQLClientConc
          .copyWith(
              authLink: AuthLink(
            getToken: () => 'Bearer $token',
          ))
          .mutate(_options);
      if (queryResult.hasException) {
        throw queryResult.exception;
      }
      Logger().i(queryResult.data);
      Logger().i(queryResult);
      var user = UserModel.fromMap(
        queryResult.data['verifyUser']['user'],
      );

      await saveLoggedInUserData(
        user,
      );
      await saveLoggedInUserToken(
        queryResult.data['verifyUser']['token'],
      );
      return user;
    } else {
      throw NoInternetException();
    }
  }

  @override
  Future<UserModel> login({String email, String password}) async {
    if (await networkInfo.isConnected) {
      final _options = MutationOptions(
        document: parseString(mutaion.loginQuery),
        variables: <String, dynamic>{
          'input': {
            'input': email,
            'password': password,
          },
        },
      );

      // print(qres.data);
      var token = await getLoggedInUserToken();

      var queryResult = await graphQLClientConc
          .copyWith(
            authLink: AuthLink(
              getToken: () => 'Bearer $token',
            ),
          )
          .mutate(_options);
      if (queryResult.hasException) {
        throw queryResult.exception;
      }
      Logger().i(queryResult.data);
      Logger().i(queryResult);
      var user = UserModel.fromMap(
        queryResult.data['login']['user'],
      );

      await saveLoggedInUserData(
        user,
      );
      await saveLoggedInUserToken(
        queryResult.data['login']['token'],
      );

      return user;
    } else {
      throw NoInternetException();
    }
  }

  @override
  Future<List<CountryModel>> getCountries() async {
    if (await networkInfo.isConnected) {
      final _query = QueryOptions(
        document: parseString(queries.getCountries),
      );
      var queryResult = await graphQLClientConc.query(_query);

      if (queryResult.hasException) {
        throw queryResult.exception;
      }
      Logger().i(queryResult.data);
      Logger().i(queryResult);
      var countries = <CountryModel>[];

      queryResult.data['getActiveCountries'].forEach((ele) {
        countries.add(CountryModel.fromMap(ele));
      });

      return countries;
    } else {
      throw NoInternetException();
    }
  }

  @override
  Future<bool> resendVerificationCode({String email}) async {
    if (await networkInfo.isConnected) {
      // print(email);
      final _options = QueryOptions(
        document: parseString(mutaion.resentCodeQuery),
        variables: <String, dynamic>{
          'input': {
            'email': email,
          },
        },
      );
      var token = await getLoggedInUserToken();
      var queryResult = await graphQLClientConc
          .copyWith(
              authLink: AuthLink(
            getToken: () => 'Bearer $token',
          ))
          .query(_options);
      if (queryResult.hasException) {
        throw queryResult.exception;
      }
      Logger().i(queryResult.data);
      Logger().i(queryResult);

      return queryResult.data['resendVerificationCode'];
    } else {
      throw NoInternetException();
    }
  }
}
