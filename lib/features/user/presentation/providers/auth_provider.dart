import 'package:flutter/material.dart';
import 'package:hagglex/core/errors/failure.dart';
import 'package:hagglex/core/local_data/user_data/get_loggedin_user_data.dart';
import 'package:hagglex/core/navigations/navigation_service.dart';
import 'package:hagglex/core/navigations/route_paths.dart';
import 'package:hagglex/core/share_ui/shared/flushbar_notification.dart';
import 'package:hagglex/features/user/domain/entities/country_entity.dart';
import 'package:hagglex/features/user/domain/entities/user_entity.dart';
import 'package:hagglex/features/user/domain/usecases/get_countries_usecase.dart';
import 'package:hagglex/features/user/domain/usecases/login_usecase.dart';
import 'package:hagglex/features/user/domain/usecases/register_usecase.dart';
import 'package:hagglex/features/user/domain/usecases/resend_otp_usecase.dart';
import 'package:hagglex/features/user/domain/usecases/verify_otp_usecase.dart';
import 'package:hagglex/injection_container.dart';

class AuthProvider extends ChangeNotifier {
  final RegisterUsecase registerUsecase;
  final LoginUsecase loginUsecase;
  final GetCountriesUsecase getCountriesUsecase;
  final ResendOtpUsecase resendOtpUsecase;
  final VerifyOtpUsecase verifyOtpUsecase;
  final GetLoggedInUserData getLoggedInUserData;
  AuthProvider(
      {@required this.registerUsecase,
      @required this.loginUsecase,
      @required this.getCountriesUsecase,
      @required this.resendOtpUsecase,
      @required this.verifyOtpUsecase,
      @required this.getLoggedInUserData});

  UserEntity _userEntity;
  UserEntity get loginUser => _userEntity;
  List<CountryEntity> _tempCountries = [];
  List<CountryEntity> _countries;
  List<CountryEntity> get countires => _countries;

  CountryEntity selectedCountry;

  Future<void> getcountries() async {
    final get_countries = await getCountriesUsecase.call();
    get_countries.fold((l) => null, (r) {
      _countries = r;
      _tempCountries = r;
      selectedCountry =
          r.firstWhere((element) => element.name.toLowerCase() == 'nigeria');
      notifyListeners();
    });
  }

  void selectCountry(CountryEntity country) {
    selectedCountry = country;
    notifyListeners();
  }

  Future<void> getLoginUser() async {
    final user = await getLoggedInUserData.call();
    _userEntity = user;
    notifyListeners();
    // return user;
  }

  void searchCountry(String keyword) {
    final result = _tempCountries
        .where((element) =>
            element.name.toLowerCase().contains(keyword.toLowerCase()) ||
            element.callingCode.toLowerCase().contains(keyword.toLowerCase()))
        .toList();
    _countries = result;
    notifyListeners();
  }

  Future<void> register({
    @required String email,
    @required String password,
    @required String username,
    @required String phone,
    String referralCode,
    @required BuildContext context,
  }) async {
    final registered = await registerUsecase(
        email: email,
        password: password,
        username: username,
        phone: phone,
        referralCode: referralCode,
        country: selectedCountry);
    registered.fold(
      (l) {
        FlushBarNotification.showErrorMessage(
          context: context,
          message: FailureToMessage.mapFailureToMessage(l),
          title: 'Error',
        );
      },
      (r) {
        _userEntity = r;
        sl<NavigationService>().navigateTo(
          Routes.accountVerificationPage,
        );
      },
    );
  }

  Future<void> login({
    @required String email,
    @required String password,
    @required BuildContext context,
  }) async {
    final response = await loginUsecase(
      email,
      password,
    );
    response.fold(
      (l) {
        FlushBarNotification.showErrorMessage(
          context: context,
          message: FailureToMessage.mapFailureToMessage(l),
          title: 'Error',
        );
      },
      (r) {
        if (r.emailVerified) {
          sl<NavigationService>().removeAllAndNavigateTo(
            Routes.dashboardPage,
          );
        } else {
          sl<NavigationService>().navigateTo(
            Routes.accountVerificationPage,
          );
        }
      },
    );
  }

  Future<void> resendOtp({
    @required BuildContext context,
  }) async {
    final response = await resendOtpUsecase(
      _userEntity.email,
    );
    response.fold(
      (l) {
        FlushBarNotification.showErrorMessage(
          context: context,
          message: FailureToMessage.mapFailureToMessage(l),
          title: 'Error',
        );
      },
      (r) {
        FlushBarNotification.showInfoMessage(
          context: context,
          message: 'OTP resent successfully, please check you mail.',
        );
      },
    );
  }

  Future<void> verifyOtp({
    @required BuildContext context,
    @required String otp,
  }) async {
    final response = await verifyOtpUsecase(
      otp,
    );
    response.fold(
      (l) {
        FlushBarNotification.showErrorMessage(
          context: context,
          message: FailureToMessage.mapFailureToMessage(l),
          title: 'Error',
        );
      },
      (r) {
        Navigator.pushNamed(
          context,
          Routes.setupSuccessPage,
        );
      },
    );
  }
}
