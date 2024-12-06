import 'package:flutter/material.dart';
import 'package:mini_games/enum/prizes.dart';

import 'package:mini_games/screen/games/components/prize_widget.dart';
import 'package:mini_games/themes/constant.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:scratcher/widgets.dart';

class ScratchItem extends StatelessWidget {
  final GlobalKey<ScratcherState>? scratchKey;
  final Function()? onThreshold;
  final Prizes prize;

  const ScratchItem({
    super.key,
    required this.scratchKey,
    required this.onThreshold,
    required this.prize,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Scratcher(
        key: scratchKey,
        brushSize:
            ResponsiveBreakpoints.of(context).smallerThan(TABLET) ? 20 : 35,
        threshold: 60,
        color: kGreyColor.shade300,
        onThreshold: onThreshold,
        child: Container(
            color: kWhiteColor,
            width: double.infinity,
            child: PrizeWidget(
              prize: prize,
            )),
      ),
    );
  }
}
