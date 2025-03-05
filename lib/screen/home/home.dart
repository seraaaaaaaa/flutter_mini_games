import 'dart:math';

import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mini_games/screen/home/widgets/game_button.dart';
import 'package:mini_games/services/coin_services.dart';
import 'package:mini_games/enum/games.dart';
import 'package:mini_games/screen/games/stop/stop_win.dart';
import 'package:mini_games/screen/games/spin/spin_win.dart';
import 'package:mini_games/screen/games/tap/tap_win.dart';
import 'package:mini_games/screen/games/roll/roll_win.dart';
import 'package:mini_games/screen/games/flip/flip_win.dart';
import 'package:mini_games/themes/constant.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  int _coins = 0;
  final _coinService = CoinServices();
  final _random = Random();

  final List<Games> _games = Games.values;

  @override
  void initState() {
    super.initState();

    _getCoins();
  }

  Future<void> _getCoins() async {
    int coins = await _coinService.getCoins();
    setState(() {
      _coins = coins;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Available Coins',
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge!
                            .copyWith(color: kBlackColor, letterSpacing: 1),
                      ),
                      Row(
                        children: [
                          Image.asset(
                            "assets/coin.png",
                            width: 40,
                            height: 40,
                          ),
                          AnimatedFlipCounter(
                            duration: const Duration(milliseconds: 200),
                            value: _coins,
                            textStyle: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .copyWith(
                                    color: kBlackColor,
                                    letterSpacing: 2,
                                    fontWeight: FontWeight.w900),
                          ),
                        ],
                      ),
                    ],
                  ),
                  TextButton(
                      onPressed: _coins >= 100
                          ? null
                          : () async {
                              int randomCoins = (_random.nextInt(10) + 1) * 100;

                              int winCoins = await _coinService.updateCoins(
                                  _coins, randomCoins);

                              setState(() {
                                _coins = winCoins;
                              });
                            },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 6),
                        child: Text('Get Coins'),
                      )),
                ],
              ),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.only(top: kPadding, bottom: 10),
                child: Text(
                  'Play a Game',
                  style: GoogleFonts.poppins(
                    textStyle: Theme.of(context)
                        .textTheme
                        .headlineMedium!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              ...List.generate(_games.length, (index) {
                final game = _games[index];
                return GameButton(
                  game: game,
                  onTap: () async {
                    if (_coins < game.requiredCoins) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Not Enough Coins'),
                      ));
                      return;
                    }

                    await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        if (game == Games.spinwin) {
                          return SpinWinScreen(coins: _coins, game: game);
                        } else if (game == Games.flipwin) {
                          return FlipWinScreen(coins: _coins, game: game);
                        } else if (game == Games.tapwin) {
                          return TapWinScreen(coins: _coins, game: game);
                        } else if (game == Games.rollwin) {
                          return RollWinScreen(coins: _coins, game: game);
                        } else {
                          return StopWinScreen(coins: _coins, game: game);
                        }
                      }),
                    );
                    _getCoins();
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
