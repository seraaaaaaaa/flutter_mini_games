import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mini_games/themes/constant.dart';
import 'package:responsive_framework/responsive_framework.dart';

class Arrow extends StatelessWidget {
  const Arrow({super.key});

  @override
  Widget build(BuildContext context) {
    double extraSize =
        ResponsiveBreakpoints.of(context).smallerThan(TABLET) ? -8 : 0;
    return Align(
      alignment: Alignment.center,
      child: Transform.rotate(
        angle: pi,
        child: Padding(
          padding: EdgeInsets.only(
              top: ResponsiveBreakpoints.of(context).smallerThan(TABLET)
                  ? 70
                  : 80),
          child: ClipPath(
            clipper: _ArrowClipper(),
            child: Container(
              color: kPrimaryColor.shade600,
              height: 35 + extraSize,
              width: 40 + extraSize,
            ),
          ),
        ),
      ),
    );
  }
}

class _ArrowClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    Offset center = size.center(Offset.zero);
    path.lineTo(center.dx, size.height);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
