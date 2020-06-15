import 'package:flutter/material.dart';
import 'package:localized/constants/translation_keys.dart';
import 'package:localized/util/utils.dart';

class AboutUs extends StatefulWidget {
  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(getTranslatedValue(context, about_us)),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(getTranslatedValue(context, about_detail)),
        ),
      ),
    );
  }
}
