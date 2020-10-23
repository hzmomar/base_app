import 'package:base_app/core/service/locator/locator.dart';
import 'package:base_app/core/service/navigation/nav_router.dart';
import 'package:base_app/core/service/navigation/navigation_service.dart';
import 'package:base_app/core/service/service.dart';
import 'package:flutter/cupertino.dart';
// ignore_for_file: unawaited_futures

class StartupVM extends ChangeNotifier {
  final Service _service = locator<Service>();


  Future<void> handleStartUp(BuildContext context) async {
    // handle all logic code
    await Future.delayed(const Duration(seconds: 2));
    navigationService.pushAndRemoveUntil(NavRouter.loginRoute);
  }
}