import 'package:flutter/material.dart';
import 'package:mini_games/themes/constant.dart';

class FlipItem extends StatelessWidget {
  const FlipItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      padding: const EdgeInsets.all(kPadding),
      decoration: BoxDecoration(
        color: kWhiteColor,
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        boxShadow: [
          BoxShadow(
            color: kGreyColor.withOpacity(0.2),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Container(
        decoration: BoxDecoration(
            color: kSecondaryColor.shade50,
            borderRadius: const BorderRadius.all(Radius.circular(4.0)),
            border: Border.all(color: kGreyColor.shade200)),
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Image(
            image: AssetImage(
              "assets/flip.png",
            ),
          ),
        ),
      ),
    );
  }
}
