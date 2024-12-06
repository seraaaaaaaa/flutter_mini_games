import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mini_games/services/coin_services.dart';
import 'package:mini_games/enum/games.dart';
import 'package:mini_games/enum/prizes.dart';
import 'package:mini_games/screen/games/components/header.dart';
import 'package:mini_games/screen/games/stop/widgets/prize_carousel.dart';
import 'package:mini_games/themes/constant.dart';

class StopWinScreen extends StatefulWidget {
  final int coins;
  final Games game;

  const StopWinScreen({
    super.key,
    required this.coins,
    required this.game,
  });

  @override
  StopWinScreenState createState() => StopWinScreenState();
}

class StopWinScreenState extends State<StopWinScreen> {
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
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(kPadding),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Header(
                    title: _game.name,
                    subtitle: _game.desc,
                    coins: _coins,
                  ),
                  PrizeCarousel(
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
          ],
        ),
      ),
    );
  }
}
