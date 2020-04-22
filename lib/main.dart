import 'package:flutter/material.dart';
import 'package:flutter_password/home.dart';
import 'package:flutter_password/pages/password_set.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Password',
      theme: ThemeData(
        primaryColor: new Color(0xff075E54),
        accentColor: new Color(0xff25D366),
      ),
      home: HomePage(title: 'Home'),
      routes: <String, WidgetBuilder>{
        '/a': (BuildContext context) => HomePage(title: 'page A'),
        '/b': (BuildContext context) => PasswordSet(),
        '/c': (BuildContext context) => HomePage(title: 'page C'),
      },
    );
  }
}


