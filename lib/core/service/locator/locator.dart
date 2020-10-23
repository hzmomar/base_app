import 'package:base_app/core/service/network/base_api.dart';
import 'package:base_app/core/service/service.dart';
import 'package:base_app/core/service/sharedpreference/sharedpreference_service.dart';
import 'package:base_app/core/viewmodel/startup_vm.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton<PreferencesService>(() => PreferencesServiceImpl());
  locator.registerLazySingleton<Service>(() => ServiceImpl());
  locator.registerLazySingleton<NetworkUtil>(() => NetworkUtil());
  locator.registerLazySingleton<StartupVM>(() => StartupVM());
}
