import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mini_games/enum/prizes.dart';
import 'package:mini_games/screen/games/components/prize_dialog.dart';
import 'package:mini_games/screen/games/spin/widgets/go_button.dart';
import 'package:mini_games/screen/games/spin/widgets/wheel_item.dart';
import 'package:mini_games/themes/constant.dart';

class SpinWheel extends StatefulWidget {
  final List<Prizes> prizes;
  final bool canPlay;
  final Function() onSpinStart;
  final Function(int) onSpinEnd;

  const SpinWheel({
    super.key,
    required this.prizes,
    required this.canPlay,
    required this.onSpinStart,
    required this.onSpinEnd,
  });

  @override
  SpinWheelState createState() => SpinWheelState();
}

class SpinWheelState extends State<SpinWheel>
    with SingleTickerProviderStateMixin {
  double _angle = 0;
  double _current = 0;

  int _selectedIndex = -1;
  final _random = Random();
  bool _spinning = false;

  late AnimationController _animationController;
  late Animation _animation;

  List<Prizes> _prizes = [];

  @override
  void initState() {
    super.initState();

    _prizes = widget.prizes;
    var duration = const Duration(milliseconds: 5000);
    _animationController = AnimationController(vsync: this, duration: duration);
    _animation = CurvedAnimation(
        parent: _animationController, curve: Curves.fastLinearToSlowEaseIn)
      ..addStatusListener((AnimationStatus status) {
        if (status == AnimationStatus.completed) {
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return PrizeDialog(
                  prize: _prizes[_selectedIndex],
                  prizeName: _prizes[_selectedIndex].name,
                  onDone: () async {
                    widget.onSpinEnd(_selectedIndex);
                    setState(() {
                      _spinning = false;
                    });
                    Navigator.pop(context);
                  },
                );
              });
        } else if (status == AnimationStatus.forward) {}
      });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: kPadding),
      child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                final value = _animation.value;
                final angle = value * _angle;
                var index = _calIndex(value * _angle + _current);

                _selectedIndex = index;

                return WheelItem(
                    prizes: _prizes, current: _current, angle: angle);
              }),
          GoButton(
              onTap: !widget.canPlay || _spinning
                  ? null
                  : () {
                      setState(() {
                        _spinning = true;
                      });
                      widget.onSpinStart();

                      _spinWheel();
                    }),
        ],
      ),
    );
  }

  void _spinWheel() {
    if (!_animationController.isAnimating) {
      var random = _random.nextDouble();
      _angle = 20 + _random.nextInt(5) + random;
      _animationController.forward(from: 0.0).then((_) {
        _current = (_current + random);
        _current = _current - _current ~/ 1;
        _animationController.reset();
      });
    }
  }

  int _calIndex(value) {
    var base = (2 * pi / _prizes.length / 2) / (2 * pi);
    return (((base + value) % 1) * _prizes.length).floor();
  }
}
