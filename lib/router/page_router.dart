import 'package:flutter/material.dart';
import 'package:localized/constants/route_names.dart';
import 'package:localized/page/about_us.dart';
import 'package:localized/page/home.dart';
import 'package:localized/page/not_found.dart';
import 'package:localized/page/settings.dart';

Route<dynamic> pageRouter(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case homePage:
      return MaterialPageRoute(
        builder: (context) => Home(),
      );
    case aboutUsPage:
      return MaterialPageRoute(
        builder: (context) => AboutUs(),
      );
    case settingsPage:
      return MaterialPageRoute(
        builder: (context) => Settings(),
      );
    default:
      return MaterialPageRoute(
        builder: (context) => NotFound(),
      );
  }
}
