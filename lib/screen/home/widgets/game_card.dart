import 'package:flutter/material.dart';
import 'package:mini_games/enum/games.dart';
import 'package:mini_games/themes/constant.dart';

class GameCard extends StatelessWidget {
  final Games game;
  final Function() onTap;

  const GameCard({
    super.key,
    required this.game,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: game.color,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: kShadowColor,
            blurRadius: 3,
            offset: Offset(1, 2),
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Positioned(
            top: -50,
            right: -120,
            child: Container(
              width: 280,
              height: 280,
              padding: EdgeInsets.zero,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(280),
                  color: kWhiteColor.withOpacity(0.3)),
            ),
          ),
          Positioned(
            top: 40,
            right: 15,
            child: Icon(
              game.icon,
              size: 100,
              color: game.color,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  game.name,
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(color: kWhiteColor, letterSpacing: 1),
                ),
                const SizedBox(height: 8),
                TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: kWhiteColor,
                      foregroundColor: game.color,
                    ),
                    onPressed: onTap,
                    child: const Text('Play')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
