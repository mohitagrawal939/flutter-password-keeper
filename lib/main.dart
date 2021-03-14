import 'package:flutter/material.dart';
import 'SplashScreenPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Passwords Keeper',
      theme: ThemeData(
        primaryColor: Colors.black,
        accentColor: Colors.black12,
        accentColorBrightness: Brightness.light,
        textSelectionColor: Colors.grey,
        textSelectionHandleColor: Colors.grey,
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreenPage(),
    );
  }
}