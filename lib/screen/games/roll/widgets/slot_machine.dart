import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mini_games/enum/prizes.dart';
import 'package:mini_games/screen/games/components/prize_dialog.dart';
import 'package:mini_games/screen/games/roll/widgets/roll_button.dart';
import 'package:mini_games/screen/games/roll/widgets/slot_item.dart';
import 'package:responsive_framework/responsive_framework.dart';

class SlotMachine extends StatefulWidget {
  final List<Prizes> prizes;
  final bool canPlay;
  final Function() onStart;
  final Function(int) onEnd;

  const SlotMachine({
    super.key,
    required this.prizes,
    required this.canPlay,
    required this.onStart,
    required this.onEnd,
  });

  @override
  SlotMachineState createState() => SlotMachineState();
}

class SlotMachineState extends State<SlotMachine> {
  List<Prizes> _prizes = [];
  late Prizes? _result1, _result2, _result3;

  late Prizes? _winResult;
  final _random = Random();

  bool _isRolling = false;

  late List<FixedExtentScrollController> _scrollControllers;

  @override
  void initState() {
    super.initState();

    _prizes = widget.prizes;
    _scrollControllers = List.generate(3, (_) => FixedExtentScrollController());

    _resetResult();
  }

  @override
  void dispose() {
    // Dispose all controllers
    for (final controller in _scrollControllers) {
      controller.dispose();
    }

    super.dispose();
  }

  void _resetResult() {
    setState(() {
      _winResult = null;
      _result1 = null;
      _result2 = null;
      _result3 = null;
    });
  }

  Future _startRoll() async {
    widget.onStart();

    _resetResult();

    setState(() {
      _isRolling = true;
    });

    final List<int> randomNumbers = List.generate(
        _scrollControllers.length, (_) => _random.nextInt(_prizes.length));
    final int round = _prizes.length * 3;
    // Animate each scroll controller
    for (int i = 0; i < _scrollControllers.length; i++) {
      final int newIndex =
          _scrollControllers[i].selectedItem + randomNumbers[i] + round;

      _scrollControllers[i].animateToItem(
        newIndex,
        duration: const Duration(milliseconds: 4000),
        curve: Curves.ease,
      );
    }

    // Wait for the animations to complete
    await Future.delayed(const Duration(milliseconds: 4000), () {
      setState(() {
        // Normalize indices and map results
        _result1 = _prizes[_scrollControllers[0].selectedItem % _prizes.length];
        _result2 = _prizes[_scrollControllers[1].selectedItem % _prizes.length];
        _result3 = _prizes[_scrollControllers[2].selectedItem % _prizes.length];
      });
      _evaluateResult();
    });
  }

  void _evaluateResult() async {
    int winCoins = 0;

    // Extract results into a list for comparison
    final results = [_result1, _result2, _result3];

    if (results.every((result) => result == _result1)) {
      if (_result1!.amount != 0) {
        _winResult = _result1;
        winCoins = _result1!.amount * 3;
      }
    } else if (results.where((result) => result == _result1).length >= 2) {
      if (_result1!.amount != 0) {
        _winResult = _result1;
        winCoins = _result1!.amount;
      }
    } else if (results.where((result) => result == _result2).length >= 2) {
      if (_result2!.amount != 0) {
        _winResult = _result2;
        winCoins = _result2!.amount;
      }
    } else if (results.where((result) => result == _result3).length >= 2) {
      if (_result3!.amount != 0) {
        _winResult = _result3;
        winCoins = _result3!.amount;
      }
    }

    await Future.delayed(Duration(milliseconds: winCoins == 0 ? 200 : 900), () {
      setState(() {
        _isRolling = false;
      });
      if (mounted) {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return PrizeDialog(
                prize: _winResult != null ? _winResult! : Prizes.tryagain,
                prizeName: _winResult != null ? '$winCoins Coins' : 'Try Again',
                onDone: () async {
                  widget.onEnd(winCoins);

                  Navigator.pop(context);
                },
              );
            });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(
            height:
                ResponsiveBreakpoints.of(context).smallerThan(TABLET) ? 10 : 0),
        SizedBox(
          height:
              ResponsiveBreakpoints.of(context).smallerThan(TABLET) ? 320 : 420,
          child: Row(
            children: List.generate(
              _scrollControllers.length,
              (index) => SlotItem(
                scrollController: _scrollControllers[index],
                prizes: _prizes,
                isWin: _winResult != null &&
                    _winResult == [_result1, _result2, _result3][index],
                winResult: _winResult,
              ),
            ),
          ),
        ),
        const SizedBox(height: 70),
        RollButton(
          onTap: _isRolling || !widget.canPlay
              ? null
              : () {
                  _startRoll();
                },
        ),
      ],
    );
  }
}
