import 'package:base_app/core/service/navigation/navigation_service.dart';
import 'package:base_app/core/service/service.dart';
import 'package:base_app/core/service/sharedpreference/sharedpreference_service.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton<NavigationService>(() => NavigationService());
  locator.registerLazySingleton<PreferencesService>(() => PreferencesServiceImpl());
  locator.registerLazySingleton<Service>(() => ServiceImpl());
}
