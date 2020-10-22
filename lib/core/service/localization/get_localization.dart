import 'package:base_app/core/service/localization/localization_service.dart';

/// helper class to add getter for localization class
class GetLocalization{
  String get appTitle => localizationService.text('appTitle');
}

GetLocalization getLocalization = GetLocalization();