import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TransitionContainer extends StatelessWidget {
  final Widget child;
  final double animationValue;
  final double width;
  final EdgeInsets margin;
  final double borderRadius;
  final double childOpacity;
  final Interval opacityInterval;

  TransitionContainer({
    this.animationValue = 0,
    this.child,
    this.width,
    this.margin,
    this.borderRadius = 0,
    this.childOpacity = 1.0,
    this.opacityInterval
  });

  @override
  Widget build(BuildContext context) {
    var animation = AlwaysStoppedAnimation(animationValue);
    var tween = Tween<double>(
      begin: 1.0 - childOpacity,
      end: childOpacity
    ).animate(
      CurvedAnimation(
        curve: opacityInterval,
        parent: animation,
      ),
    );
    return Container(
      width: width,
      margin: margin,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 4),
          BoxShadow(color: Colors.black12, blurRadius: 10),
        ],
      ),
      child: FadeTransition(
        opacity: tween,
        child: child,
      )
    );
  }
}