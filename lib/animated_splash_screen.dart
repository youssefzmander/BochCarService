import 'package:flutter/material.dart';

enum SplashTransition {
  slideTransition,
  scaleTransition,
  rotationTransition,
  sizeTransition,
  fadeTransition,
  decoratedBoxTransition
}
enum PageTransitionType {
  fade,
  rightToLeft,
  leftToRight,
  upToDown,
  downToUp,
  scale,
  rotate,
  size,
  rightToLeftWithFade,
  leftToRightWithFade,
}

AnimatedSplashScreen({
    Curve curve = Curves.easeInCirc,
    Future Function()? function, // Here you can make something before change of screen
    int duration = 2500,
    @required dynamic splash,
    required Widget nextScreen,
    Color backgroundColor = Colors.white,
    Animatable? customTween,
    bool centered = true,
    SplashTransition splashTransition = SplashTransition.fadeTransition,
    PageTransitionType pageTransitionType = PageTransitionType.downToUp,
 } ) {
  
  print("Splash Screen");
 }