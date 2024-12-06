import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/material.dart';
import 'package:mini_games/themes/constant.dart';

class Header extends StatelessWidget {
  final String title;
  final String subtitle;
  final int coins;

  const Header({
    super.key,
    required this.title,
    this.subtitle = '',
    required this.coins,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: kPadding),
      padding: const EdgeInsets.all(4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.keyboard_backspace)),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: kWhiteColor.withOpacity(0.3)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/coin.png",
                      width: 34,
                      height: 34,
                    ),
                    const SizedBox(width: 4),
                    AnimatedFlipCounter(
                      duration: const Duration(milliseconds: 500),
                      value: coins,
                      textStyle: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: kWhiteColor, letterSpacing: 1.2),
                    ),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                color: kWhiteColor,
                fontWeight: FontWeight.w800,
                letterSpacing: 1.2),
          ),
          subtitle.isEmpty
              ? Container()
              : Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    subtitle,
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .copyWith(color: kWhiteColor, fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                ),
        ],
      ),
    );
  }
}
