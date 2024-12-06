import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mini_games/themes/constant.dart';
import 'package:responsive_framework/responsive_framework.dart';

class GoButton extends StatefulWidget {
  final Function()? onTap;

  const GoButton({
    super.key,
    required this.onTap,
  });

  @override
  State<GoButton> createState() => _GoButtonState();
}

class _GoButtonState extends State<GoButton> {
  static const double _shadowHeight = 8;
  double _position = 8;

  @override
  Widget build(BuildContext context) {
    double size =
        ResponsiveBreakpoints.of(context).smallerThan(TABLET) ? 50 : 62;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        onTapUp: widget.onTap == null
            ? null
            : (_) {
                setState(() {
                  _position = 8;
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
                  _position = 8;
                });
              },
        child: SizedBox(
          height: size + _shadowHeight,
          width: size,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                bottom: 0,
                child: Container(
                  height: size,
                  width: size,
                  decoration: BoxDecoration(
                    color: kPrimaryColor.shade700,
                    borderRadius: BorderRadius.circular(60),
                  ),
                ),
              ),
              AnimatedPositioned(
                curve: Curves.easeIn,
                bottom: _position,
                duration: const Duration(milliseconds: 70),
                child: Container(
                  height: size,
                  width: size,
                  decoration: BoxDecoration(
                    color: kPrimaryColor.shade400,
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        'GO',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          textStyle: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(
                                  color: widget.onTap == null
                                      ? kGreyColor.shade300
                                      : kWhiteColor,
                                  fontSize: 20),
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
