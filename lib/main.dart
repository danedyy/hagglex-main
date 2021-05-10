import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as dotenv;
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hagglex/core/navigations/navigation_service.dart';
import 'package:hagglex/core/navigations/route_generator.dart';
import 'package:hagglex/core/navigations/route_paths.dart';
import 'package:hagglex/core/share_ui/shared/app_colors.dart';
import 'package:hagglex/features/user/presentation/providers/auth_provider.dart';
import 'package:hagglex/injection_container.dart';
import 'package:provider/provider.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  await setupLocator();
  await initHiveForFlutter();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => sl<AuthProvider>(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: MaterialApp(
        title: 'HaggleX',
        navigatorKey: sl<NavigationService>().key,
        theme: ThemeData(
            primarySwatch: MaterialColor(
              0xff2E1963,
              AppColors.colorScratch,
            ),
            accentColor: Color(0xff2E1963),
            fontFamily: 'BasisRegular'),
        initialRoute: Routes.startUpPage,
        onGenerateRoute: generateRoute,
      ),
    );
  }
}
