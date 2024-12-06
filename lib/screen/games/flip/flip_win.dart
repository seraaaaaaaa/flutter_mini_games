import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mini_games/services/coin_services.dart';
import 'package:mini_games/enum/games.dart';
import 'package:mini_games/enum/prizes.dart';
import 'package:mini_games/screen/games/components/header.dart';
import 'package:mini_games/screen/games/flip/widgets/flip_cards.dart';
import 'package:mini_games/themes/constant.dart';

class FlipWinScreen extends StatefulWidget {
  final int coins;
  final Games game;

  const FlipWinScreen({
    super.key,
    required this.coins,
    required this.game,
  });

  @override
  State<FlipWinScreen> createState() => _FlipWinScreenState();
}

class _FlipWinScreenState extends State<FlipWinScreen>
    with SingleTickerProviderStateMixin {
  late int _coins = 0;
  late Games _game;

  final _coinService = CoinServices();
  final List<Prizes> _prizes = [
    Prizes.percent10,
    Prizes.specialgift,
    Prizes.percent50,
    Prizes.coins888,
    Prizes.coins100,
    Prizes.bomb,
    Prizes.tryagain,
    Prizes.coins300,
    Prizes.coins10
  ];

  @override
  void initState() {
    super.initState();

    _coins = widget.coins;
    _game = widget.game;
  }

  @override
  Widget build(BuildContext context) {
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
            SingleChildScrollView(
              padding: const EdgeInsets.all(kPadding),
              physics: const NeverScrollableScrollPhysics(),
              child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Header(
                      title: _game.name,
                      subtitle: _game.desc,
                      coins: _coins,
                    ),
                    FlipCards(
                        prizes: _prizes,
                        canPlay: _coins >= _game.requiredCoins,
                        onStart: () async {
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
                        onEnd: (index) async {
                          if (_prizes[index].isCoin) {
                            int winCoins = await _coinService.updateCoins(
                                _coins, _prizes[index].amount);
                            setState(() {
                              _coins = winCoins;
                            });
                          }
                        }),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
