import 'package:flutter/cupertino.dart';
import 'package:mini_games/enum/prizes.dart';
import 'package:mini_games/screen/games/components/prize_widget.dart';
import 'package:mini_games/themes/constant.dart';
import 'package:responsive_framework/responsive_framework.dart';

class SlotItem extends StatefulWidget {
  final FixedExtentScrollController scrollController;
  final List<Prizes> prizes;
  final bool isWin;
  final Prizes? winResult;

  const SlotItem({
    super.key,
    required this.scrollController,
    required this.prizes,
    required this.isWin,
    required this.winResult,
  });

  @override
  SlotItemState createState() => SlotItemState();
}

class SlotItemState extends State<SlotItem>
    with SingleTickerProviderStateMixin {
  double itemExtent = 180.0;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 800));
    _animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    itemExtent =
        ResponsiveBreakpoints.of(context).smallerThan(TABLET) ? 130 : 180.0;
    return Expanded(
      child: GestureDetector(
        onVerticalDragUpdate: (_) {}, // Block vertical drag gestures
        child: AbsorbPointer(
          // Prevent any touch interactions
          absorbing: true,
          child: CupertinoPicker(
            scrollController: widget.scrollController,
            itemExtent: itemExtent,
            diameterRatio: 20,
            squeeze: 1.2,
            looping: true,
            onSelectedItemChanged: (int index) {
              // print('$index');
            },
            children: <Widget>[
              for (var i = 0; i < widget.prizes.length; i++)
                widget.isWin &&
                        widget.winResult != null &&
                        widget.winResult == widget.prizes[i]
                    ? FadeTransition(
                        opacity: _animationController,
                        child: Container(
                            //  width: double.infinity,
                            margin: const EdgeInsets.all(kPadding),
                            padding: const EdgeInsets.all(kPadding),
                            decoration: BoxDecoration(
                              color: kWhiteColor,
                              boxShadow: [
                                BoxShadow(
                                  color: kWhiteColor.withOpacity(0.2),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: PrizeWidget(
                              prize: widget.prizes[i],
                              imgOnly: true,
                            )),
                      )
                    : Container(
                        // width: double.infinity,
                        margin: EdgeInsets.all(ResponsiveBreakpoints.of(context)
                                .smallerThan(TABLET)
                            ? 10
                            : kPadding),
                        padding: const EdgeInsets.all(kPadding),
                        color: kWhiteColor,
                        child: PrizeWidget(
                          prize: widget.prizes[i],
                          imgOnly: true,
                        )),
            ],
          ),
        ),
      ),
    );
  }
}
