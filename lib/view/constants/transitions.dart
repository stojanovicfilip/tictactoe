import 'package:flutter/material.dart';

class FadeRoute extends PageRouteBuilder {
  final Widget enterPage;

  FadeRoute({
    required this.enterPage,
  }) : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              enterPage,
          transitionDuration: const Duration(milliseconds: 1000),
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) {
            animation =
                CurvedAnimation(curve: Curves.easeInCubic, parent: animation);
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        );
}

class SlideRoute extends PageRouteBuilder {
  final Widget enterPage;
  final Offset begin;
  final Offset end;

  SlideRoute({
    required this.enterPage,
    required this.begin,
    required this.end,
  }) : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              enterPage,
          transitionDuration: const Duration(milliseconds: 1600),
          reverseTransitionDuration: const Duration(milliseconds: 800),
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) {
            animation = CurvedAnimation(
              curve: Curves.easeInOutCirc,
              reverseCurve: Curves.easeInOutCirc,
              parent: animation,
            );
            return SlideTransition(
              position: Tween<Offset>(
                begin: begin,
                end: end,
              ).animate(animation),
              child: child,
            );
          },
        );
}
