import 'package:flutter/material.dart';
import 'package:mini_games/enum/prizes.dart';
import 'package:mini_games/screen/games/components/prize_widget.dart';
import 'package:mini_games/themes/constant.dart';
import 'package:responsive_framework/responsive_framework.dart';

class PrizeDialog extends StatelessWidget {
  final Prizes prize;
  final String prizeName;
  final VoidCallback onDone;

  const PrizeDialog({
    super.key,
    required this.prize,
    required this.prizeName,
    required this.onDone,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Center(
      child: Dialog(
        backgroundColor: Colors.transparent, //must have
        elevation: 0,
        child: Container(
            decoration: BoxDecoration(
                color: kWhiteColor, borderRadius: BorderRadius.circular(8)),
            height: size.height *
                (ResponsiveBreakpoints.of(context).smallerThan(TABLET)
                    ? .35
                    : .4),
            width: size.width *
                (ResponsiveBreakpoints.of(context).smallerThan(TABLET)
                    ? .5
                    : .35),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PrizeWidget(
                  prize: prize,
                  imgOnly: true,
                ),
                Padding(
                  padding: const EdgeInsets.all(kPadding),
                  child: Text(
                    prizeName == 'Try Again'
                        ? 'Unlucky Mate! Please try again.'
                        : prize.amount < 0
                            ? 'Opps! You lose ${prize.amount} coins'
                            : 'Congrats! You win $prizeName',
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontSize: 22, letterSpacing: 1),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: kPadding),
                  child: TextButton(
                    onPressed: onDone,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: kPadding, vertical: 8),
                      child: Text("OK"),
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
