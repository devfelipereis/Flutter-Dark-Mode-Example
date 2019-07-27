import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  Brightness brightness;
  SharedPreferences prefs = await SharedPreferences.getInstance();

  //the brightness value will be a ture or false
  //depending on the shared preferences check
  brightness =
      (prefs.getBool("isDark") ?? false) ? Brightness.dark : Brightness.light;

  runApp(MyApp(brightness));
}

class MyApp extends StatelessWidget {
  final Brightness brightness;

  MyApp(this.brightness);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new DynamicTheme(
        defaultBrightness: Brightness.light,
        data: (brightness) => new ThemeData(
              primarySwatch: Colors.indigo,
              brightness: brightness,
            ),
        themedWidgetBuilder: (context, theme) {
          return new MaterialApp(
            title: 'Dark Mode Example',
            theme: theme,
            home: new MyHomePage(title: 'Dark Mode Example'),
          );
        });
  }
}

class MyHomePage extends StatelessWidget {
  final String title;

  MyHomePage({this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              onPressed: () => changeBrightness(context),
              child: const Text("Change brightness"),
            ),
            RaisedButton(
              onPressed: () => changeColor(context),
              child: const Text("Change color"),
            ),
          ],
        ),
      ),
    );
  }

  void changeBrightness(context) {
    DynamicTheme.of(context).setBrightness(
        Theme.of(context).brightness == Brightness.dark
            ? Brightness.light
            : Brightness.dark);
  }

  void changeColor(context) {
    DynamicTheme.of(context).setThemeData(ThemeData(
        primaryColor: Theme.of(context).primaryColor == Colors.indigo
            ? Colors.red
            : Colors.indigo));
  }
}
