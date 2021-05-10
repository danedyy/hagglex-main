import 'package:flutter/material.dart';
import 'package:hagglex/core/constants/app_assets.dart';
import 'package:hagglex/core/navigations/route_paths.dart';
import 'package:hagglex/core/share_ui/shared/app_colors.dart';
import 'package:hagglex/core/share_ui/shared/ui_helpers.dart';
import 'package:hagglex/features/user/presentation/widgets/gold_button_widget.dart';
import 'package:hagglex/features/user/presentation/widgets/hagglex_app_backgroun_widget.dart';

class SetupCompletePage extends StatefulWidget {
  SetupCompletePage({Key key}) : super(key: key);

  @override
  _SetupCompletePageState createState() => _SetupCompletePageState();
}

class _SetupCompletePageState extends State<SetupCompletePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: HaggleXAppBackgroundWidget(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              AppAssets.goldCheckIcon,
              width: 64,
              height: 64,
            ),
            verticalSpace(18.36),
            Text(
              'Setup Complete',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            verticalSpace(20),
            Text(
              'Thank you for setting up your HaggleX account',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            verticalSpaceMassive,
            verticalSpaceSmall,
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 36,
              ),
              child: GoldButton(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    Routes.dashboardPage,
                  );
                },
                title: 'start exploring'.toUpperCase(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
