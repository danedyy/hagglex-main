import 'package:flutter/material.dart';
import 'package:hagglex/core/navigations/route_paths.dart';
import 'package:hagglex/features/user/presentation/pages/account_verification_page.dart';
import 'package:hagglex/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:hagglex/features/user/presentation/pages/login_page.dart';
import 'package:hagglex/features/user/presentation/pages/select_country_page.dart';
import 'package:hagglex/features/user/presentation/pages/setup_complete_page.dart';
import 'package:hagglex/features/user/presentation/pages/signup_page.dart';
import 'package:hagglex/features/user/presentation/pages/startup_page.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case Routes.startUpPage:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: StartupPage(),
      );
    case Routes.loginPage:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: LoginPage(),
      );
    case Routes.selectCountryPage:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: SelectCountryPage(),
      );
    case Routes.dashboardPage:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: DashboardPage(),
      );
    case Routes.signupPage:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: SignupPage(),
      );
    case Routes.setupSuccessPage:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: SetupCompletePage(),
      );
    case Routes.accountVerificationPage:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: AccountVerificationPage(),
      );

    default:
      return MaterialPageRoute(
        builder: (_) => Scaffold(
          body: Center(
            child: Text('No route defined for ${settings.name}'),
          ),
        ),
      );
  }
}

PageRoute _getPageRoute({String routeName, Widget viewToShow}) {
  return MaterialPageRoute(
    settings: RouteSettings(
      name: routeName,
    ),
    builder: (_) => viewToShow,
  );
}
