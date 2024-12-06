import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mini_games/enum/prizes.dart';

import 'package:mini_games/screen/games/spin/widgets/arrow.dart';
import 'package:mini_games/screen/games/components/prize_widget.dart';
import 'package:mini_games/themes/constant.dart';
import 'package:responsive_framework/responsive_framework.dart';

class WheelItem extends StatefulWidget {
  final double angle;
  final double current;
  final List<Prizes> prizes;

  const WheelItem(
      {super.key,
      required this.angle,
      required this.current,
      required this.prizes});

  @override
  WheelItemState createState() => WheelItemState();
}

class WheelItemState extends State<WheelItem> {
  Size get size => Size(
      MediaQuery.of(context).size.width *
          (ResponsiveBreakpoints.of(context).smallerThan(TABLET)
              ? 0.85 //mobile
              : ResponsiveBreakpoints.of(context).smallerThan(DESKTOP)
                  ? 0.5
                  : 0.32),
      MediaQuery.of(context).size.width *
          (ResponsiveBreakpoints.of(context).smallerThan(TABLET)
              ? 0.85
              : ResponsiveBreakpoints.of(context).smallerThan(DESKTOP)
                  ? 0.5 //tablet
                  : 0.32));

  double _rotote(int index) => (index / widget.prizes.length) * 2 * pi;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        //shadow
        Container(
          height: size.height + 20,
          width: size.width + 20,
          decoration: const BoxDecoration(
              color: kWhiteColor,
              shape: BoxShape.circle,
              boxShadow: [BoxShadow(blurRadius: 20, color: Colors.black38)]),
        ),
        Transform.rotate(
          angle: -(widget.current + widget.angle) * 2 * pi,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              for (var entry in widget.prizes.asMap().entries) ...[
                _WheelCard(
                  rotate: _rotote(entry.key),
                  angle: 2 * pi / widget.prizes.length,
                  size: size,
                  index: entry.key,
                )
              ],
              for (var prize in widget.prizes) ...[
                _WheelImg(
                  prize: prize,
                  size: size,
                  rotate: _rotote(
                    widget.prizes.indexOf(prize),
                  ),
                )
              ],
            ],
          ),
        ),
        SizedBox(
          height: size.height,
          width: size.width,
          child: const Arrow(),
        ),
      ],
    );
  }
}

class _WheelCard extends StatelessWidget {
  const _WheelCard({
    required this.rotate,
    required this.angle,
    required this.size,
    required this.index,
  });

  final double rotate;
  final double angle;
  final Size size;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: rotate,
      child: ClipPath(
        clipper: _WheelPath(angle),
        child: Container(
          height: size.height,
          width: size.width,
          decoration: BoxDecoration(
            color:
                index.isOdd ? kYellowColor.shade100 : Colors.amberAccent[200],
          ),
        ),
      ),
    );
  }
}

class _WheelImg extends StatelessWidget {
  const _WheelImg({
    required this.prize,
    required this.size,
    required this.rotate,
  });

  final Prizes prize;
  final Size size;
  final double rotate;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: rotate,
      child: Container(
        height: size.height,
        width: size.width,
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints:
              BoxConstraints.expand(height: size.height / 2.8, width: 120),
          child: PrizeWidget(
            prize: prize,
          ),
        ),
      ),
    );
  }
}

class _WheelPath extends CustomClipper<Path> {
  final double angle;

  _WheelPath(this.angle);

  @override
  Path getClip(Size size) {
    Path path = Path();
    Offset center = size.center(Offset.zero);
    Rect rect = Rect.fromCircle(center: center, radius: size.width / 2);
    path.moveTo(center.dx, center.dy);
    path.arcTo(rect, -pi / 2 - angle / 2, angle, false);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(_WheelPath oldClipper) {
    return angle != oldClipper.angle;
  }
}
