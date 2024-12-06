import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mini_games/services/coin_services.dart';
import 'package:mini_games/enum/games.dart';
import 'package:mini_games/enum/prizes.dart';
import 'package:mini_games/screen/games/components/header.dart';
import 'package:mini_games/screen/games/tap/widgets/tap_cards.dart';
import 'package:mini_games/themes/constant.dart';

class TapWinScreen extends StatefulWidget {
  final int coins;
  final Games game;

  const TapWinScreen({
    super.key,
    required this.coins,
    required this.game,
  });

  @override
  TapWinScreenState createState() => TapWinScreenState();
}

class TapWinScreenState extends State<TapWinScreen> {
  late int _coins = 0;
  late Games _game;

  final _coinService = CoinServices();

  final List<Prizes> _prizes = [
    Prizes.percent10,
    Prizes.specialgift,
    Prizes.bomb,
    Prizes.coins888,
    Prizes.coins100,
    Prizes.percent50,
    Prizes.tryagain,
    Prizes.coins300,
  ];

  @override
  void initState() {
    super.initState();

    _coins = widget.coins;
    _game = widget.game;
  }

  @override
  void dispose() {
    super.dispose();
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
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.all(kPadding),
                child: Column(
                  children: [
                    Header(
                      title: _game.name,
                      subtitle: _game.desc,
                      coins: _coins,
                    ),
                    TapCards(
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
