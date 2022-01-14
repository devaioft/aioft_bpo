import 'package:aioft_bpo/Screens/dashboard.dart';
import 'package:aioft_bpo/Screens/fleet_screen.dart';
import 'package:aioft_bpo/Screens/onboarding.screen.dart';
import 'package:aioft_bpo/Screens/providers_screen.dart';
import 'package:aioft_bpo/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'settings/settings_controller.dart';
import 'settings/settings_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
    required this.settingsController,
  }) : super(key: key);

  final SettingsController settingsController;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: settingsController,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          restorationScopeId: 'app',

          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', ''),
          ],

          // onGenerateTitle: (BuildContext context) =>
          //     AppLocalizations.of(context)!.appTitle,

          theme: ThemeData(
            primaryColor: kPrimaryColor,
            fontFamily: 'Nunito-Bold',
            appBarTheme: const AppBarTheme(
              elevation: 1,
              backgroundColor: kBtnColor,
              foregroundColor: kCardColor,
            ),
          ),
          darkTheme: ThemeData.dark(),
          themeMode: settingsController.themeMode,
          onGenerateRoute: (RouteSettings routeSettings) {
            return MaterialPageRoute<void>(
              settings: routeSettings,
              builder: (BuildContext context) {
                switch (routeSettings.name) {
                  case SettingsView.routeName:
                    return SettingsView(controller: settingsController);
                  case ProviderScreen.routeName:
                    return const ProviderScreen();
                  case FleetScreen.routeName:
                    return const FleetScreen();
                  default:
                    return const OnBoardingPage();
                }
              },
            );
          },
        );
      },
    );
  }
}
