import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mini_games/enum/prizes.dart';
import 'package:mini_games/themes/constant.dart';
import 'package:responsive_framework/responsive_framework.dart';

class PrizeWidget extends StatelessWidget {
  final Prizes prize;
  final bool imgOnly;

  const PrizeWidget({
    super.key,
    required this.prize,
    this.imgOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    double? size =
        ResponsiveBreakpoints.of(context).smallerThan(TABLET) ? 45 : null;
    double? fontSize =
        ResponsiveBreakpoints.of(context).smallerThan(TABLET) ? -6 : 0;

    String firstName = '';
    String lastName = '';

    if (prize.name.isNotEmpty) {
      // Split the name into parts
      List<String> parts = prize.name.trim().split(' ');

      // Assign values based on the parts count
      firstName = parts.isNotEmpty ? parts[0] : '';
      lastName = parts.length > 1
          ? parts[1]
          : ''; // Default to empty if no second part
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        prize.img.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Image.asset(
                  prize.img,
                  height: size,
                  width: size,
                  errorBuilder: (_, __, ___) {
                    return Image.asset(
                      prize.img,
                      height: size,
                      width: size,
                      errorBuilder: (_, __, ___) {
                        return const SizedBox();
                      },
                    );
                  },
                ),
              )
            : Container(),
        firstName.isEmpty || (imgOnly && prize.img.isNotEmpty)
            ? Container()
            : Text(
                prize.name.split(' ')[0],
                style: GoogleFonts.poppins(
                    textStyle: Theme.of(context).textTheme.headlineSmall,
                    fontSize: (prize.img.isNotEmpty ? 18 : 38) + fontSize,
                    fontWeight: FontWeight.w800,
                    color: prize.color,
                    letterSpacing: 1),
                overflow: TextOverflow.ellipsis,
              ),
        lastName.isEmpty || imgOnly
            ? Container()
            : Text(
                prize.name.split(' ')[1],
                style: GoogleFonts.poppins(
                    textStyle: Theme.of(context).textTheme.headlineSmall,
                    fontSize: (prize.img.isNotEmpty ? 18 : 28) + fontSize,
                    fontWeight: FontWeight.w700,
                    color: prize.color == kPrimaryColor
                        ? kBlackColor.withOpacity(0.7)
                        : prize.color,
                    letterSpacing: 1),
                overflow: TextOverflow.ellipsis,
              ),
      ],
    );
  }
}
