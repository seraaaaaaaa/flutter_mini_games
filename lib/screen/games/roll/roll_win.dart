import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mini_games/services/coin_services.dart';
import 'package:mini_games/enum/games.dart';
import 'package:mini_games/enum/prizes.dart';
import 'package:mini_games/screen/games/components/header.dart';
import 'package:mini_games/screen/games/roll/widgets/slot_machine.dart';
import 'package:mini_games/themes/constant.dart';

class RollWinScreen extends StatefulWidget {
  final int coins;
  final Games game;

  const RollWinScreen({
    super.key,
    required this.coins,
    required this.game,
  });

  @override
  RollWinScreenState createState() => RollWinScreenState();
}

class RollWinScreenState extends State<RollWinScreen> {
  late int _coins = 0;
  late Games _game;

  final _coinService = CoinServices();

  final List<Prizes> _prizes = [
    Prizes.coins100,
    Prizes.coins888,
    Prizes.coins10,
    Prizes.tryagain,
    Prizes.coins300,
    Prizes.bomb,
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
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(
              height: size.height,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(kPadding),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Header(
                      title: _game.name,
                      subtitle: _game.desc,
                      coins: _coins,
                    ),
                    SlotMachine(
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
                      onEnd: (coins) async {
                        int winCoins =
                            await _coinService.updateCoins(_coins, coins);

                        setState(() {
                          _coins = winCoins;
                        });
                      },
                    ),
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
