import 'package:flutter/material.dart';

enum Games {
  spinwin(
    name: 'Spin & Win',
    desc: 'Spin the wheel with 100 coins for a chance to win.',
    icon: Icons.games_outlined,
    backgroundImg: 'assets/background/stacked-waves-haikei.svg',
    requiredCoins: 100,
    color: Colors.red,
  ),
  flipwin(
    name: 'Flip & Win',
    desc: 'Flip a card with 100 coins, then scratch it to reveal your prize.',
    icon: Icons.style,
    backgroundImg: 'assets/background/stacked-peaks-haikei.svg',
    requiredCoins: 100,
    color: Colors.orange,
  ),
  rollwin(
    name: 'Roll & Win',
    desc: 'Roll the slot machine with 100 coins and try your luck.',
    icon: Icons.videogame_asset,
    backgroundImg: 'assets/background/layered-waves-haikei.svg',
    requiredCoins: 100,
    color: Colors.amber,
  ),
  tapwin(
    name: 'Tap & Win',
    desc: 'Tap the PLAY button with 100 coins, and start winning.',
    icon: Icons.dashboard,
    backgroundImg: 'assets/background/blob-scene-haikei.svg',
    requiredCoins: 100,
    color: Colors.green,
  ),
  stopwin(
    name: 'Stop & Win',
    desc: 'Start it with 100 coins then stop the roll to win your prize.',
    icon: Icons.pan_tool_alt,
    backgroundImg: 'assets/background/vertical-waves-haikei.svg',
    requiredCoins: 100,
    color: Colors.teal,
  ),
  ;

  const Games({
    required this.name,
    required this.desc,
    required this.icon,
    required this.backgroundImg,
    required this.requiredCoins,
    required this.color,
  });

  final String name;
  final String desc;
  final IconData icon;
  final String backgroundImg;
  final int requiredCoins;
  final Color color;
}
