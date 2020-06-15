import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:localized/constants/language_code.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of(context, AppLocalizations);
  }

  Map<String, String> _localizedValues;

  Future<bool> loadLanguage() async {
    String jsonStrings = await rootBundle
        .loadString('lib/languages/${locale.languageCode}.json');

    Map<String, dynamic> mappedString = json.decode(jsonStrings);
    _localizedValues = mappedString.map((key, value) => MapEntry(key, value));
    return true;
  }

  String translate(String key) {
    return _localizedValues[key];
  }

  static _AppLocalizationDelegate delegate = _AppLocalizationDelegate();
}

class _AppLocalizationDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationDelegate();

  @override
  bool isSupported(Locale locale) {
    return [ARABIC, ENGLISH, FRENCH].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    AppLocalizations appLocalization = AppLocalizations(locale);
    await appLocalization.loadLanguage();
    return appLocalization;
  }

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalizations> old) => false;
}
