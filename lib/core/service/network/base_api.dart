import 'package:alice/alice.dart';
import 'package:base_app/core/model/flavor_manager.dart';
import 'package:base_app/core/service/locator/locator.dart';
import 'package:base_app/core/service/navigation/navigation_service.dart';
import 'package:dio/dio.dart';

class NetworkUtil {
  Dio dio;

  NetworkUtil() {
    // shake to view inspector tool
    final Alice alice = Alice(
      darkTheme: true,
      navigatorKey: locator<NavigationService>().navigationKey,
      showInspectorOnShake: true,
      showNotification: false,
    );
    dio = Dio();
    dio.options
      ..baseUrl = FlavorManager.instance.settings.baseUrl.toString()
      ..headers = {}
      ..responseType = ResponseType.json
      ..headers = {'fdsa': 'fsda'};
    // add alice Http inspector tool
    dio.interceptors.add(alice.getDioInterceptor());
  }

  Future<Map<String, dynamic>> get(String endpoint,
      {Map<String, dynamic> queryParam, bool authorizedHeader = false}) async {
    try {
      if(authorizedHeader) await setAuthorizedHeader();
      final Response response =
          await dio.get(endpoint, queryParameters: queryParam);
      return response.data;
    } catch (e) {
      throw e;
    }
  }

  Future<Map<String, dynamic>> post(String endpoint, Map<String, dynamic> body,
      {Map<String, dynamic> queryParam, bool authorizedHeader = false}) async {
    try {
      if(authorizedHeader) await setAuthorizedHeader();
      final Response response =
          await dio.post(endpoint, queryParameters: queryParam, data: body);
      return response.data;
    } catch (e) {
      throw e;
    }
  }

  Future<void> setAuthorizedHeader() async {
    dio.options.headers = {'token': '123423'};
  }
}
