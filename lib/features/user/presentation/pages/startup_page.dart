import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hagglex/core/constants/app_assets.dart';
import 'package:hagglex/core/navigations/route_paths.dart';
import 'package:hagglex/core/share_ui/shared/app_colors.dart';
import 'package:hagglex/core/share_ui/shared/ui_helpers.dart';
import 'package:hagglex/features/user/presentation/providers/auth_provider.dart';
import 'package:hagglex/features/user/presentation/widgets/hagglex_app_backgroun_widget.dart';
import 'package:provider/provider.dart';

class StartupPage extends StatefulWidget {
  const StartupPage({Key key}) : super(key: key);

  @override
  _StartupPageState createState() => _StartupPageState();
}

class _StartupPageState extends State<StartupPage> {
  Future<void> _navigateToAnotherPage() async {
    Timer(
      Duration(seconds: 3),
      () {
        final user = context.read<AuthProvider>().loginUser;
        // print(user.emailVerified);
        if (user != null) {
          if (user.emailVerified) {
            Navigator.pushReplacementNamed(context, Routes.dashboardPage);
          } else {
            Navigator.pushReplacementNamed(context, Routes.loginPage);
          }
        } else {
          Navigator.pushReplacementNamed(context, Routes.loginPage);
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _navigateToAnotherPage();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<AuthProvider>().getLoginUser();
    context.read<AuthProvider>().getcountries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: HaggleXAppBackgroundWidget(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              AppAssets.appLogoImage,
              width: 50,
              height: 50,
            ),
            verticalSpaceSmall,
            Text(
              'HaggleX',
              style: TextStyle(
                  color: Colors.white, fontSize: 27, fontFamily: 'BasisBold'),
            )
          ],
        ),
      ),
    );
  }
}
