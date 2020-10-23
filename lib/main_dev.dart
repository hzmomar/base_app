import 'package:base_app/core/constant/enum.dart';
import 'package:base_app/core/model/flavor_manager.dart';
import 'package:base_app/core/service/localization/localization_service.dart';
import 'package:base_app/core/service/locator/locator.dart';
import 'package:base_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Register all the models and services before the app starts
  setupLocator();
  FlavorManager(
    env: AppEnvironment.dev,
    settings: FlavorSettings(baseUrl: Uri.https('example.com', '/api')),
  );
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));

  localizationService.init().then((_) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
        .then((_) {
      runApp(MyApp());
    });
  });
}
