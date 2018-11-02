import 'package:flutter/material.dart';
import 'package:flutter_app/src/ui/home_ui.dart';
import 'package:flutter_app/src/ui/login_ui.dart';
import 'package:flutter_app/src/ui/register_ui.dart';
import 'package:flutter_app/src/ui/scanner_ui.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final routes = <String, WidgetBuilder>{
    Login.tag: (context) => Login(),
    Register.tag: (context) => Register(),
    Home.tag: (context) => Home(),
    ScanScreen.tag: (context) => ScanScreen(),
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'YoungHappy Staff',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      home: Login(),
      routes: routes,
    );
  }
}
