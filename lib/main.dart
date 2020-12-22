import 'package:flutter/material.dart';
import 'package:movies_flutter_app/screens/splash_screen.dart';
import 'package:movies_flutter_app/utils/constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movies App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: kMainColor,
        fontFamily: 'Poppins',
        scaffoldBackgroundColor: kScaffoldBGColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreen(),
    );
  }
}
