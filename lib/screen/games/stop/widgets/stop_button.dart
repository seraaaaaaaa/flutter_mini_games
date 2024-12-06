import 'package:flutter/material.dart';
import 'package:mini_games/themes/constant.dart';

class StopButton extends StatefulWidget {
  final bool isRunning;
  final Function()? onTap;

  const StopButton({
    super.key,
    required this.isRunning,
    required this.onTap,
  });

  @override
  State<StopButton> createState() => _StopButtonState();
}

class _StopButtonState extends State<StopButton> {
  static const double _shadowHeight = 10;
  double _position = 10;

  @override
  Widget build(BuildContext context) {
    const double height = 70 - _shadowHeight;
    const double width = 120;

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
                    color: widget.isRunning
                        ? kRedColor.shade700
                        : kAmberColor.shade700,
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
                    color: widget.isRunning
                        ? kRedColor.shade400
                        : kAmberColor.shade400,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(40),
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      widget.isRunning
                          ? Icons.stop_circle
                          : Icons.play_arrow_outlined,
                      color: kWhiteColor,
                      size: 50,
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
