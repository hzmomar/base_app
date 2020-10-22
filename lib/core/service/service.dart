import 'package:base_app/core/service/locator/locator.dart';
import 'package:base_app/core/service/sharedpreference/sharedpreference_service.dart';

abstract class Service {

}


class ServiceImpl implements Service {
  final PreferencesService _preferencesService = locator<PreferencesService>();
}