import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:base_app/core/service/locator/locator.dart';
import 'package:base_app/core/service/sharedpreference/sharedpreference_service.dart';
import 'package:flutter/services.dart';

class LocalizationService {
  static final LocalizationService _translations =
      LocalizationService._internal();

  factory LocalizationService() {
    return _translations;
  }

  LocalizationService._internal();

  Locale _locale;
  Map<dynamic, dynamic> _localizedValues;
  VoidCallback _onLocaleChangedCallback;
  final PreferencesService _preferencesService = locator<PreferencesService>();
  static const List<String> supportedLanguages = [
    'Bahasa Indonesia',
    'English',
  ];
  static const List<String> supportedLanguagesCodes = [
    'id',
    'en',
  ];
  static const String localizedFilePath = 'asset/locale/';
  static const String localizedFileFormat = '.json';
  static const String localizedPrefix = 'localization_';
  static const String _storageKey = 'MyApplication_';

  String get currentLanguage => _locale == null ? '' : _locale.languageCode;

  Locale get locale => _locale;

  set onLocaleChangedCallback(VoidCallback callback) {
    _onLocaleChangedCallback = callback;
  }

  Iterable<Locale> supportedLocales() =>
      supportedLanguagesCodes.map<Locale>((lang) => Locale(lang, ''));

  String text(String key) {
    return (_localizedValues == null || _localizedValues[key] == null)
        ? '** $key not found'
        : _localizedValues[key];
  }

  Future<Null> init([String language]) async {
    if (_locale == null) {
      await setNewLanguage(language);
    }
    return null;
  }

  Future<String> getPreferredLanguage() async {
    return getApplicationSavedInformation('language');
  }

  Future<bool> setPreferredLanguage(String lang) async {
    return _setApplicationSavedInformation('language', lang);
  }

  Future<Null> setNewLanguage(
      [String newLanguage, bool saveInPrefs = true]) async {
    String language = newLanguage;
    language ??= await getPreferredLanguage();
    if (language == '') {
      language = supportedLanguagesCodes.first;
    }
    _locale = Locale(language, '');
    final String jsonContent = await rootBundle
        .loadString('$localizedFilePath$localizedPrefix${locale.languageCode}$localizedFileFormat');
    _localizedValues = json.decode(jsonContent);

    if (saveInPrefs) {
      await setPreferredLanguage(language);
    }
    if (_onLocaleChangedCallback != null) {
      _onLocaleChangedCallback();
    }

    return null;
  }

  Future<String> getApplicationSavedInformation(String name) async {
    return await _preferencesService.getString(key: '$_storageKey$name') ?? '';
  }

  Future<bool> _setApplicationSavedInformation(
      String name, String value) async {
    return _preferencesService.setString(
        key: '$_storageKey$name', value: value);
  }
}

LocalizationService localizationService = LocalizationService();
