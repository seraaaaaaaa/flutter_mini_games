import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mini_games/themes/constant.dart';
import 'package:responsive_framework/responsive_framework.dart';

class TapButton extends StatefulWidget {
  final Function()? onTap;

  const TapButton({
    super.key,
    required this.onTap,
  });

  @override
  State<TapButton> createState() => _TapButtonState();
}

class _TapButtonState extends State<TapButton> {
  static const double _shadowHeight = 10;
  double _position = 10;

  @override
  Widget build(BuildContext context) {
    double width =
        ResponsiveBreakpoints.of(context).smallerThan(TABLET) ? 100 : 200;
    double height =
        (ResponsiveBreakpoints.of(context).smallerThan(TABLET) ? 100 : 150) -
            _shadowHeight;

    return Center(
      child: MouseRegion(
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
              alignment: Alignment.center,
              children: [
                Positioned(
                  bottom: 0,
                  child: Container(
                    height: height,
                    width: width,
                    decoration: BoxDecoration(
                      color: kAmberColor.shade700,
                      borderRadius: BorderRadius.circular(kPadding),
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
                      borderRadius: BorderRadius.circular(kPadding),
                    ),
                    child: Center(
                      child: Padding(
                          padding: const EdgeInsets.all(kPadding),
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              text: 'Play',
                              style: GoogleFonts.poppins(
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .headlineSmall!
                                    .copyWith(
                                        color: widget.onTap == null
                                            ? kGreyColor.shade300
                                            : kWhiteColor,
                                        fontSize:
                                            ResponsiveBreakpoints.of(context)
                                                    .smallerThan(TABLET)
                                                ? 16
                                                : 28),
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                    text: '\n100 Coins',
                                    style: TextStyle(
                                        fontSize:
                                            ResponsiveBreakpoints.of(context)
                                                    .smallerThan(TABLET)
                                                ? 12
                                                : 20)),
                              ],
                            ),
                          )),
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
