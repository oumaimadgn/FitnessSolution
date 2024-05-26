import 'package:flutter/material.dart';
import 'login.dart';
import 'register.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FitFolio',
      debugShowCheckedModeBanner: false,
      routes: {
        '/Register': (context) => Register(),
        '/Login': (context) => Login(),
      },
      initialRoute: '/Meal',
    );
  }
}
