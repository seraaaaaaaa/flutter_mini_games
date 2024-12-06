import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mini_games/services/coin_services.dart';
import 'package:mini_games/enum/games.dart';
import 'package:mini_games/enum/prizes.dart';
import 'package:mini_games/screen/games/spin/widgets/spin_wheel.dart';
import 'package:mini_games/screen/games/components/header.dart';
import 'package:mini_games/themes/constant.dart';

class SpinWinScreen extends StatefulWidget {
  final int coins;
  final Games game;

  const SpinWinScreen({
    super.key,
    required this.coins,
    required this.game,
  });

  @override
  SpinWinScreenState createState() => SpinWinScreenState();
}

class SpinWinScreenState extends State<SpinWinScreen> {
  late int _coins = 0;
  late Games _game;

  final _coinService = CoinServices();

  final List<Prizes> _prizes = [
    Prizes.percent10,
    Prizes.specialgift,
    Prizes.percent50,
    Prizes.coins888,
    Prizes.bomb,
    Prizes.coins100,
  ];

  @override
  void initState() {
    super.initState();

    _coins = widget.coins;
    _game = widget.game;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: SvgPicture.asset(
                _game.backgroundImg,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: size.height,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(kPadding),
                child: Column(
                  children: [
                    Header(
                      title: _game.name,
                      subtitle: _game.desc,
                      coins: _coins,
                    ),
                    SpinWheel(
                        prizes: _prizes,
                        canPlay: _coins >= _game.requiredCoins,
                        onSpinStart: () async {
                          int? useCoins = await _coinService.useCoins(
                              _coins, _game.requiredCoins);
                          if (useCoins != null) {
                            setState(() {
                              _coins = useCoins;
                            });
                          } else if (context.mounted) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text('Not Enough Coins'),
                            ));
                          }
                        },
                        onSpinEnd: (index) async {
                          if (_prizes[index].isCoin) {
                            int winCoins = await _coinService.updateCoins(
                                _coins, _prizes[index].amount);

                            setState(() {
                              _coins = winCoins;
                            });
                          }
                        }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
