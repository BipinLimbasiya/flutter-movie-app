import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:movies_flutter_app/screens/movie_list_page.dart';
import 'package:movies_flutter_app/utils/constants.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSplashScreen(
          duration: 3000,
          splash: Image.asset("assets/images/launch_icon.jpg"),
          nextScreen: MovieListPage(),
          splashTransition: SplashTransition.fadeTransition,
          backgroundColor: kMainColor),
    );
  }
}
