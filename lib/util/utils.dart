import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:localized/constants/country_code.dart';
import 'package:localized/constants/language_code.dart';
import 'package:localized/constants/preference_name.dart';
import 'package:localized/localization/app_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';

String getTranslatedValue(BuildContext context, String key) {
  return AppLocalizations.of(context).translate(key);
}

Future<Locale> setLocale(String languageCode) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setString(LANGUAGE_CODE, languageCode);
  return _locale(languageCode);
}

Future<Locale> getLocale() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return _locale(preferences.getString(LANGUAGE_CODE) ?? ENGLISH );
}

Locale _locale(languageCode) {
  switch (languageCode) {
    case ARABIC:
      return Locale(ARABIC, SAUDI_ARABIA);
    case ENGLISH:
      return Locale(ENGLISH, USA);
    case FRENCH:
      return Locale(FRENCH, FRANCE);
    default:
      return Locale(ENGLISH, USA);
  }
}

String formatDate(DateTime dateTime) {
  return DateFormat("dd/MM/yyyy").format(dateTime);
}
