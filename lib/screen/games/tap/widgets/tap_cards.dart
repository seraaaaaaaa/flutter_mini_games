import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mini_games/enum/prizes.dart';
import 'package:mini_games/screen/games/components/prize_dialog.dart';
import 'package:mini_games/screen/games/components/prize_widget.dart';
import 'package:mini_games/screen/games/tap/widgets/tap_button.dart';
import 'package:mini_games/themes/constant.dart';
import 'package:responsive_framework/responsive_framework.dart';

class TapCards extends StatefulWidget {
  final List<Prizes> prizes;
  final bool canPlay;
  final Function() onStart;
  final Function(int) onEnd;

  const TapCards({
    super.key,
    required this.prizes,
    required this.canPlay,
    required this.onStart,
    required this.onEnd,
  });

  @override
  TapCardsState createState() => TapCardsState();
}

class TapCardsState extends State<TapCards>
    with SingleTickerProviderStateMixin {
  int _currentId = -1;
  int _winId = 0;

  late List<Prizes> _prizes;
  late AnimationController _animationController;

  final _random = Random();
  bool _running = false;

  @override
  void initState() {
    super.initState();

    _prizes = widget.prizes;
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
    final height = MediaQuery.of(context).size.height;

    return SizedBox(
      height: ResponsiveBreakpoints.of(context).smallerThan(TABLET)
          ? height * .7
          : height * .8,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, // 3 rows and columns
            mainAxisSpacing: kPadding,
            crossAxisSpacing: kPadding,
            childAspectRatio:
                ResponsiveBreakpoints.of(context).smallerThan(TABLET)
                    ? 0.9
                    : 1.45),
        itemCount: 9,
        itemBuilder: (context, index) {
          // Determine if the cell should display content or remain empty
          final item = _getItemForPosition(index);

          return item != null
              ? _winId == item.id
                  ? FadeTransition(
                      opacity: _animationController,
                      child: Container(
                          decoration: BoxDecoration(
                            color: kWhiteColor,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8.0)),
                            boxShadow: [
                              BoxShadow(
                                color: kBlackColor.withOpacity(0.2),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: PrizeWidget(prize: item)),
                    )
                  : Opacity(
                      opacity:
                          _currentId == -1 || _currentId == item.id ? 1 : 0.8,
                      child: Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          color: kWhiteColor,
                        ),
                        child: PrizeWidget(
                          prize: item,
                        ),
                      ),
                    )
              : TapButton(
                  onTap: !widget.canPlay || _running
                      ? null
                      : () async {
                          setState(() {
                            _winId = 0;
                            _currentId = -1;
                            _running = true;
                          });

                          widget.onStart();

                          int randomNumber = _random.nextInt(8);

                          int round = 3;
                          for (int j = 0; j < round; j++) {
                            for (int i = 0; i < _prizes.length; i++) {
                              setState(() {
                                _currentId = _prizes[i].id;
                              });
                              await Future.delayed(
                                  const Duration(milliseconds: 180));
                              if (j == round - 1 && i == randomNumber) {
                                setState(() {
                                  _winId = _prizes[i].id;
                                });

                                break;
                              }
                            }
                          }
                          await Future.delayed(
                              const Duration(milliseconds: 900), () async {
                            if (context.mounted) {
                              showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (BuildContext context) {
                                    return PrizeDialog(
                                      prize: _prizes[randomNumber],
                                      prizeName: _prizes[randomNumber].name,
                                      onDone: () async {
                                        widget.onEnd(randomNumber);

                                        Navigator.pop(context);
                                      },
                                    );
                                  });
                            }

                            await Future.delayed(
                                const Duration(milliseconds: 900), () {
                              setState(() {
                                _winId = 0;
                                _currentId = -1;
                                _running = false;
                              });
                            });
                          });
                        },
                );
        },
      ),
    );
  }

  Prizes? _getItemForPosition(int index) {
    // Map positions to items (0-2, 3, 5, 6-8)
    switch (index) {
      case 0:
        return _prizes[0];
      case 1:
        return _prizes[1];
      case 2:
        return _prizes[2];
      case 3:
        return _prizes[7];
      case 5:
        return _prizes[3];
      case 6:
        return _prizes[6];
      case 7:
        return _prizes[5];
      case 8:
        return _prizes[4];
      default:
        return null; // Empty cells
    }
  }
}
