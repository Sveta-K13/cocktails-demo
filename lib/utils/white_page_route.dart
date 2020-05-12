import 'package:flutter/material.dart';

//Create a transition that fades in the new view, while fading out a white background
class WhitePageRoute extends PageRouteBuilder {
  final Widget enterPage;
  final double startPosition;
  final int duration;

  WhitePageRoute({this.enterPage, this.startPosition = 0.65, this.duration = 1500})
      : super(
            transitionDuration: Duration(milliseconds: duration),
            pageBuilder: (context, animation, secondaryAnimation) => enterPage,
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              var fadeIn = Tween<double>(begin: 0, end: 1).animate(
                CurvedAnimation(
                  curve: Interval(startPosition, 1),
                  parent: animation,
                ),
              );
              return Stack(children: <Widget>[
                FadeTransition(opacity: fadeIn, child: child),
              ]);
            });
}
