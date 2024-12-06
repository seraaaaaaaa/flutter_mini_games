import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mini_games/themes/constant.dart';
import 'package:responsive_framework/responsive_framework.dart';

class RollButton extends StatefulWidget {
  final Function()? onTap;

  const RollButton({
    super.key,
    required this.onTap,
  });

  @override
  State<RollButton> createState() => _RollButtonState();
}

class _RollButtonState extends State<RollButton> {
  static const double _shadowHeight = 10;
  double _position = 10;

  @override
  Widget build(BuildContext context) {
    const double height = 64 - _shadowHeight;
    final size = MediaQuery.of(context).size;
    final double width = ResponsiveBreakpoints.of(context).smallerThan(TABLET)
        ? size.width * .8
        : size.width * .3;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        onTapUp: widget.onTap == null
            ? null
            : (_) {
                setState(() {
                  _position = 10;
                });
              },
        onTapDown: widget.onTap == null
            ? null
            : (_) {
                setState(() {
                  _position = 0;
                });
              },
        onTapCancel: widget.onTap == null
            ? null
            : () {
                setState(() {
                  _position = 10;
                });
              },
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
                    color: kAmberColor.shade700,
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
                    color: kAmberColor.shade400,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(40),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Play (100 Coins)',
                      style: GoogleFonts.poppins(
                        textStyle:
                            Theme.of(context).textTheme.headlineSmall!.copyWith(
                                  color: widget.onTap == null
                                      ? kGreyColor.shade300
                                      : kWhiteColor,
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
    );
  }
}
