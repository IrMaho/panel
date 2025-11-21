import 'package:flutter/material.dart';

class AppAnimations {
  // Duration Constants
  static const fast = Duration(milliseconds: 200);
  static const normal = Duration(milliseconds: 300);
  static const slow = Duration(milliseconds: 500);
  static const verySlow = Duration(milliseconds: 800);

  // Curves
  static const easeInOut = Curves.easeInOut;
  static const easeOut = Curves.easeOut;
  static const bounceOut = Curves.bounceOut;
  static const elasticOut = Curves.elasticOut;

  // Fade In Animation
  static Widget fadeIn({
    required Widget child,
    Duration duration = normal,
    Duration delay = Duration.zero,
  }) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: duration,
      curve: easeOut,
      builder: (context, value, child) {
        return Opacity(opacity: value, child: child);
      },
      child: child,
    );
  }

  // Slide In Animation
  static Widget slideIn({
    required Widget child,
    Duration duration = normal,
    Offset begin = const Offset(0, 0.3),
  }) {
    return TweenAnimationBuilder<Offset>(
      tween: Tween(begin: begin, end: Offset.zero),
      duration: duration,
      curve: easeOut,
      builder: (context, value, child) {
        return Transform.translate(offset: value * 100, child: child);
      },
      child: child,
    );
  }

  // Scale In Animation
  static Widget scaleIn({required Widget child, Duration duration = normal}) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.8, end: 1.0),
      duration: duration,
      curve: elasticOut,
      builder: (context, value, child) {
        return Transform.scale(scale: value, child: child);
      },
      child: child,
    );
  }
}
