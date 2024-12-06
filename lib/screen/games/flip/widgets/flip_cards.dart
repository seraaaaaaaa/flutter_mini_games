import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:mini_games/enum/prizes.dart';

import 'package:mini_games/screen/games/components/prize_dialog.dart';
import 'package:mini_games/screen/games/flip/widgets/flip_item.dart';
import 'package:mini_games/screen/games/flip/widgets/scratch_item.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:scratcher/scratcher.dart';

class FlipCards extends StatefulWidget {
  final List<Prizes> prizes;
  final bool canPlay;
  final Function() onStart;
  final Function(int) onEnd;

  const FlipCards({
    super.key,
    required this.prizes,
    required this.canPlay,
    required this.onStart,
    required this.onEnd,
  });

  @override
  State<FlipCards> createState() => _FlipCardsState();
}

class _FlipCardsState extends State<FlipCards>
    with SingleTickerProviderStateMixin {
  late List<Prizes> _prizes;

  final int _count = 3;
  double size = 160;
  double space = 8;
  double height = 180;

  late final int _totalItem = _prizes.length;
  late List<Rect> _positions = List.generate(
      _totalItem, (index) => _getRectangle(index, _totalItem, size, height));

  var cardKeys = <int, GlobalKey<FlipCardState>>{};
  var scratchKeys = <int, GlobalKey<ScratcherState>>{};

  int _selectedIndex = -1;
  bool _canFlip = true;

  @override
  void initState() {
    super.initState();

    _prizes = widget.prizes;
    if (widget.canPlay) {
      _shuffle();
    } else {
      _canFlip = false;
    }
  }

  Future _shuffle() async {
    await Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _positions.shuffle();
      });
    });
  }

  void _updatePositions(double newSize, double newHeight) {
    setState(() {
      height = newHeight;
      size = newSize;
      _positions = List.generate(_totalItem,
          (index) => _getRectangle(index, _totalItem, size, height));
    });
  }

  @override
  Widget build(BuildContext context) {
    final screensize = MediaQuery.of(context).size;
    final width = screensize.width;

    // Update positions based on screen width
    if (ResponsiveBreakpoints.of(context).smallerThan(TABLET) && size != 110) {
      _updatePositions(110, 150);
    } else if (width >= 600 && size != 160) {
      _updatePositions(160, 180);
    }

    return SizedBox(
      height: screensize.height * .8,
      width: _count * (size + space),
      child: Stack(
        alignment: Alignment.center,
        children: List.generate(_totalItem, (index) {
          cardKeys.putIfAbsent(index, () => GlobalKey<FlipCardState>());
          scratchKeys.putIfAbsent(index, () => GlobalKey<ScratcherState>());
          GlobalKey<FlipCardState>? cardKey = cardKeys[index];
          GlobalKey<ScratcherState>? scratchKey = scratchKeys[index];

          return AnimatedPositioned.fromRect(
            rect: _positions[index],
            duration: const Duration(milliseconds: 200),
            child: FlipCard(
              key: cardKey,
              flipOnTouch: _canFlip,
              direction: FlipDirection.HORIZONTAL,
              side: CardSide.FRONT,
              speed: 800,
              onFlip: () async {
                if (_canFlip) {
                  setState(() {
                    _canFlip = false;
                    _selectedIndex = index;
                  });

                  widget.onStart();
                }
              },
              front: const FlipItem(),
              back: ScratchItem(
                scratchKey: scratchKey,
                onThreshold: () async {
                  scratchKey?.currentState
                      ?.reveal(duration: const Duration(milliseconds: 1500));

                  await Future.delayed(const Duration(milliseconds: 1500), () {
                    if (context.mounted) {
                      showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return PrizeDialog(
                              prize: _prizes[_selectedIndex],
                              prizeName: _prizes[_selectedIndex].name,
                              onDone: () async {
                                widget.onEnd(_selectedIndex);

                                Navigator.pop(context);

                                scratchKey?.currentState?.reset();
                                cardKey?.currentState?.toggleCard();

                                await Future.delayed(
                                    const Duration(milliseconds: 500),
                                    () async {
                                  _positions.shuffle();
                                });

                                setState(() {
                                  _selectedIndex = -1;
                                  _canFlip = true;
                                });
                              },
                            );
                          });
                    }
                  });
                },
                prize: _prizes[index],
              ),
            ),
          );
        }),
      ),
    );
  }

  Rect _getRectangle(int index, int length, double size, double height) {
    return Offset(index % _count * (size + space),
            index ~/ _count * (height + space)) &
        Size(size, height);
  }
}
