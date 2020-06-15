import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:localized/constants/country_code.dart';
import 'package:localized/constants/language_code.dart';
import 'package:localized/constants/route_names.dart';
import 'package:localized/localization/app_localization.dart';
import 'package:localized/router/page_router.dart';
import 'package:localized/util/utils.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();

  static setLocale(BuildContext context, Locale locale) {
    _MyAppState state = context.findRootAncestorStateOfType<_MyAppState>();
    state.setLocale(locale);
  }
}

class _MyAppState extends State<MyApp> {
  Locale _locale;

  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() {
    getLocale().then((locale) => _locale = locale);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Localized',
      theme: ThemeData(primarySwatch: Colors.indigo),
      locale: _locale,
      initialRoute: homePage,
      onGenerateRoute: pageRouter,
      supportedLocales: [
        Locale(ENGLISH, USA),
        Locale(FRENCH, FRANCE),
        Locale(ARABIC, SAUDI_ARABIA),
      ],
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        //Below line will translate all in-app words into selected language.
        AppLocalizations.delegate
      ],
      debugShowCheckedModeBanner: false,
      localeResolutionCallback: (deviceLocales, supportedLocales) {
        for (var locale in supportedLocales) {
          if (locale.languageCode == deviceLocales.languageCode &&
              locale.countryCode == deviceLocales.countryCode) {
            return deviceLocales;
          }
        }
        return supportedLocales.first;
      },
    );
  }
}
