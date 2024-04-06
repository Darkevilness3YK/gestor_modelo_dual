// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:gestor_modelo_dual/widgets/animated_page_routes/animated_page_route_slide/enum_slide_directions.dart';

// Código basado de https://www.youtube.com/watch?v=_R3E_aof69c
// Animación generada con ayuda de ChatGPT.
class AnimatedPageRouteSlide extends PageRouteBuilder {
  final Widget page;
  final SlideDirection slideDirection;

  AnimatedPageRouteSlide({required this.page, required this.slideDirection})
      : super(
          transitionDuration: Duration(milliseconds: 500),
          reverseTransitionDuration: Duration(milliseconds: 500),
          pageBuilder: (context, animation, secondaryAnimation) => page,
        );

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    final begin = getBeginOffset();
    const end = Offset.zero;
    const curve = Curves.easeInOut;

    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
    var offsetAnimation = animation.drive(tween);

    return SlideTransition(
      position: offsetAnimation,
      child: child,
    );
  }

  Offset getBeginOffset() {
    switch (slideDirection) {
      case SlideDirection.bottomToTop:
        return Offset(0.0, 1.0);
      case SlideDirection.leftToRight:
        return Offset(-1.0, 0.0);
      case SlideDirection.rightToLeft:
        return Offset(1.0, 0.0);
      case SlideDirection.topToBottom:
        return Offset(0.0, -1.0);
    }
  }
}

// PageRouteBuilder<dynamic> PageTransitionRightToLeft() {
//   return PageRouteBuilder(
//     pageBuilder: (context, animation, secondaryAnimation) => ViewPerfilDualista(dualista: dualista),
//     transitionDuration: Duration(milliseconds: 500),
//     reverseTransitionDuration: Duration(milliseconds: 500),
//     transitionsBuilder: (context, animation, secondaryAnimation, child) {
//       const begin = Offset(1.0, 0.0);
//       const end = Offset.zero;
//       const curve = Curves.easeInOut;

//       var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

//       var offsetAnimation = animation.drive(tween);

//       return SlideTransition(
//         position: offsetAnimation,
//         child: child,
//       );
//     },
//   );
// }
