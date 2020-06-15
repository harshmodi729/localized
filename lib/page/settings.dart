import 'package:flutter/material.dart';
import 'package:localized/constants/route_names.dart';
import 'package:localized/constants/translation_keys.dart';
import 'package:localized/main.dart';
import 'package:localized/model/language.dart';
import 'package:localized/util/utils.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(getTranslatedValue(context, settingsPage)),
      ),
      body: Center(
        child: DropdownButton<Language>(
            underline: SizedBox(),
            iconSize: 30,
            hint: Text(getTranslatedValue(context, change_language)),
            items: Language.languageList
                .map<DropdownMenuItem<Language>>(
                  (language) => DropdownMenuItem<Language>(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(language.flag),
                        Text(language.name),
                      ],
                    ),
                    value: language,
                  ),
                )
                .toList(),
            onChanged: (Language language) {
              _changeLanguage(language);
            }),
      ),
    );
  }

  void _changeLanguage(Language language) async {
    Locale _locale = await setLocale(language.code);
    MyApp.setLocale(context, _locale);
  }
}
