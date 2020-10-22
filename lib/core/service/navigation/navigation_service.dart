import 'package:flutter/cupertino.dart';

// ignore: avoid_classes_with_only_static_members
class NavigationService {
  static final navigatorKey = GlobalKey<NavigatorState>();

  static NavigatorState get navigatorState => navigatorKey.currentState;

  static Future<T> pushAndRemoveUntil<T extends Object>(
      String pushNamed, String removeUntilNamed,
      {Object arguments}) async {
    return navigatorState.pushNamedAndRemoveUntil(
      pushNamed,
      ModalRoute.withName(removeUntilNamed),
      arguments: arguments,
    );
  }

  static Future<T> pushReplacementNamed<T extends Object, TO extends Object>(
    String routeName, {
    TO result,
    Object arguments,
  }) {
    return navigatorState.pushReplacementNamed(routeName,
        result: result, arguments: arguments);
  }
}
