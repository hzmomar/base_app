import 'package:base_app/ui/view/auth/login_view.dart';
import 'package:base_app/ui/view/splash/splash_view.dart';
import 'package:flutter/material.dart';

class NavRouter {
  static const String loginRoute = 'login';
  static const String initialRoute = '/';

  static MaterialPageRoute _pageRoute(Widget page) {
    return MaterialPageRoute(builder: (_) => page);
  }

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case initialRoute :
        return _pageRoute(SplashView());
      case loginRoute:
        return _pageRoute(LoginView());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
              body: Center(
                  child: Text('No route defined for ${settings?.name}')),
            ));
    }
  }
}