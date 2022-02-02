import 'package:aioft_bpo/Screens/dashboard/dashboard.dart';
import 'package:aioft_bpo/Screens/fleet/fleet_screen.dart';
import 'package:aioft_bpo/Screens/onboarding/onboarding.screen.dart';
import 'package:aioft_bpo/Screens/providers/components/provider_reg_form.dart';
import 'package:aioft_bpo/Screens/providers/providers_screen.dart';
import 'package:aioft_bpo/Services/preferences.dart';
import 'package:aioft_bpo/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'settings/settings_controller.dart';
import 'settings/settings_view.dart';

class MyApp extends StatefulWidget {
  const MyApp({
    Key? key,
    required this.settingsController,
  }) : super(key: key);

  final SettingsController settingsController;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _prefs = PreferecesServices();
  var _phoneNumber;
  @override
  void initState() {
    super.initState();
    popuLatesFeild();
  }

  popuLatesFeild() async {
    final profile = await _prefs.getData();
    setState(() {
      _phoneNumber = profile.phoneNumber;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.settingsController,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          title: 'Aioft BPO',
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
          themeMode: widget.settingsController.themeMode,
          onGenerateRoute: (RouteSettings routeSettings) {
            return MaterialPageRoute<void>(
              settings: routeSettings,
              builder: (BuildContext context) {
                switch (routeSettings.name) {
                  case SettingsView.routeName:
                    return SettingsView(controller: widget.settingsController);
                  case ProviderScreen.routeName:
                    return const ProviderScreen();
                  case ProviderRegistartion.routeName:
                    return const ProviderRegistartion();
                  case FleetScreen.routeName:
                    return const FleetScreen();
                
                  // case CallHistory.routeName:
                  //   return const CallHistory();
                  default:
                    return _phoneNumber.toString().length < 10
                        ? const OnBoardingPage()
                        : const DashBoardScreen();
                  // : const DashBoardScreen();
                }
              },
            );
          },
        );
      },
    );
  }
}
