import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mini_games/enum/games.dart';
import 'package:mini_games/themes/constant.dart';
import 'package:responsive_framework/responsive_framework.dart';

class GameButton extends StatefulWidget {
  final Games game;
  final Function() onTap;

  const GameButton({
    super.key,
    required this.game,
    required this.onTap,
  });

  @override
  State<GameButton> createState() => _GameButtonState();
}

class _GameButtonState extends State<GameButton> {
  static const double _shadowHeight = 10;
  double _position = 10;

  @override
  Widget build(BuildContext context) {
    const double height = 64 - _shadowHeight;
    final size = MediaQuery.of(context).size;
    final double width = ResponsiveBreakpoints.of(context).smallerThan(TABLET)
        ? size.width * .8
        : size.width * .32;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        onTapUp: (_) {
          setState(() {
            _position = 10;
          });
        },
        onTapDown: (_) {
          setState(() {
            _position = 0;
          });
        },
        onTapCancel: () {
          setState(() {
            _position = 10;
          });
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: kPadding),
          child: SizedBox(
            height: height + _shadowHeight,
            width: width,
            child: Stack(
              children: [
                Positioned(
                  bottom: 0,
                  child: Container(
                    height: height,
                    width: width,
                    decoration: BoxDecoration(
                      color: widget.game.color.withOpacity(0.8),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(40),
                      ),
                    ),
                  ),
                ),
                AnimatedPositioned(
                  curve: Curves.easeIn,
                  bottom: _position,
                  duration: const Duration(milliseconds: 70),
                  child: Container(
                    height: height,
                    width: width,
                    decoration: BoxDecoration(
                      color: widget.game.color,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(40),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        widget.game.name,
                        style: GoogleFonts.poppins(
                          textStyle: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(
                                color: kWhiteColor,
                              ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
