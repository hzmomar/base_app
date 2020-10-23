import 'package:base_app/core/service/localization/localization_service.dart';
import 'package:base_app/core/service/navigation/nav_router.dart';
import 'package:base_app/core/service/navigation/navigation_service.dart';
import 'package:base_app/ui/view/splash/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      onGenerateRoute: NavRouter.generateRoute,
      navigatorKey: navigationService.navigationKey,
      supportedLocales: localizationService.supportedLocales(),
      home: SplashView(),
      initialRoute: NavRouter.initialRoute,
    );
  }
}
