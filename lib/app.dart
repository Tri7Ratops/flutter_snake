import 'package:flutter/material.dart';
import 'package:flutter_snake/config/theme.dart';
import 'package:flutter_snake/screens/home/home.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppThemeData.light,
      initialRoute: HomeScreen.routeName,
      routes: {
        HomeScreen.routeName: (BuildContext context ) => HomeScreen()
      },
    );
  }
}
