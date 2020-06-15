import 'package:localized/constants/language_code.dart';

class Language {
  final int id;
  final String flag;
  final String name;
  final String code;

  Language(this.id, this.flag, this.name, this.code);

  static List<Language> languageList = [
    Language(1, "🇸🇦", 'عربى', ARABIC),
    Language(2, "🇺🇸", 'English', ENGLISH),
    Language(3, "🇫🇷", 'français', FRENCH),
  ];
}
