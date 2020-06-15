import 'package:flutter/material.dart';
import 'package:localized/constants/route_names.dart';
import 'package:localized/constants/translation_keys.dart';
import 'package:localized/main.dart';
import 'package:localized/model/language.dart';
import 'package:localized/util/utils.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GlobalKey<FormState> _key = GlobalKey();
  TextEditingController _dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _createDrawer(),
      appBar: AppBar(
        title: Text(getTranslatedValue(context, home_page)),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.all(8.0),
            child: DropdownButton(
              //below line will remove icon's underline
              underline: SizedBox(),

              icon: Icon(Icons.language, color: Colors.white),
              items: Language.languageList
                  .map<DropdownMenuItem<Language>>(
                      (language) => DropdownMenuItem(
                            value: language,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Text(language.flag),
                                Text(language.name),
                              ],
                            ),
                          ))
                  .toList(),
              onChanged: (Language language) {
                _changeLanguage(language);
              },
            ),
          )
        ],
      ),
      body: _createHomePageUI(),
    );
  }

  //Below method will create Home page body UI
  _createHomePageUI() => Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Flexible(
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  getTranslatedValue(context, personal_information),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
              ),
              flex: 1,
            ),
            Flexible(
              child: Container(
                child: Form(
                    key: _key,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          TextFormField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              labelText: getTranslatedValue(context, name),
                              hintText: getTranslatedValue(context, enter_name),
                              prefixIcon: Icon(Icons.person),
                            ),
                            validator: (value) {
                              if (value.isEmpty)
                                return getTranslatedValue(
                                    context, please_enter_name);
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              labelText: getTranslatedValue(context, email),
                              hintText:
                                  getTranslatedValue(context, enter_email),
                              prefixIcon: Icon(Icons.mail),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value.isEmpty)
                                return getTranslatedValue(
                                    context, please_enter_email);
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          TextFormField(
                            controller: _dateController,
                            onTap: () async {
                              FocusScope.of(context).requestFocus(FocusNode());
                              await showDatePicker(
                                helpText: getTranslatedValue(
                                    context, select_birth_date),
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(DateTime.now().year - 30),
                                lastDate: DateTime.now(),
                              ).then((value) {
                                if (value != null)
                                  _dateController.text = formatDate(value);
                              });
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              labelText: getTranslatedValue(
                                  context, select_birth_date),
                              hintText: getTranslatedValue(
                                  context, select_birth_date),
                              prefixIcon: Icon(Icons.cake),
                            ),
                            validator: (value) {
                              if (value.isEmpty)
                                return getTranslatedValue(
                                    context, please_enter_birth_date);
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          RaisedButton(
                            onPressed: () {
                              if (_key.currentState.validate()) {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      content: Text(getTranslatedValue(
                                          context, successfully_done)),
                                      actions: <Widget>[
                                        FlatButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                              getTranslatedValue(context, ok)),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
                            },
                            child: Center(
                              child: Text(
                                getTranslatedValue(context, submit),
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            color: Theme.of(context).accentColor,
                            splashColor: Theme.of(context).primaryColor,
                            shape: StadiumBorder(),
                          ),
                        ],
                      ),
                    )),
              ),
              flex: 4,
            ),
          ],
        ),
      );

  //Below methods will create Navigation Drawer
  _createDrawer() => Container(
        width: MediaQuery.of(context).size.width / 1.5,
        color: Theme.of(context).primaryColor,
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: Container(
                height: 100,
                child: CircleAvatar(
                  backgroundColor: Colors.lightGreen,
                ),
              ),
            ),
            _createDrawerItem(
                getTranslatedValue(context, about_us), aboutUsPage, Icons.info),
            _createDrawerItem(getTranslatedValue(context, settings),
                settingsPage, Icons.settings),
          ],
        ),
      );

  _createDrawerItem(String title, String routeName, IconData iconData) {
    TextStyle _textStyle = TextStyle(fontSize: 20, color: Colors.white);
    return ListTile(
      leading: _createPrefixIcon(iconData),
      title: Text(
        title,
        style: _textStyle,
      ),
      onTap: () {
        Navigator.pop(context);
        Navigator.pushNamed(context, routeName);
      },
    );
  }

  _createPrefixIcon(IconData iconData) => Icon(
        iconData,
        color: Colors.white,
        size: 25,
      );

  void _changeLanguage(Language language) async {
    Locale _locale = await setLocale(language.code);
    MyApp.setLocale(context, _locale);
  }
}
