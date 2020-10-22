import 'package:base_app/core/constant/enum.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FlavorSettings {
  FlavorSettings({
    @required this.baseUrl,
  });

  final Map<DeployCountry, String> baseUrl;
}

class FlavorManager {
  final AppEnvironment env;
  final FlavorSettings settings;

  static FlavorManager _instance;

  factory FlavorManager(
      {@required AppEnvironment env, @required FlavorSettings settings}) {
    return _instance ??= FlavorManager._internal(env: env, settings: settings);
  }

  FlavorManager._internal({this.env, this.settings});

  static FlavorManager get instance => _instance;

  static bool isProd() => _instance.env == AppEnvironment.prod;

  static bool isDev() => _instance.env == AppEnvironment.dev;

  static bool isStage() => _instance.env == AppEnvironment.stage;
}
