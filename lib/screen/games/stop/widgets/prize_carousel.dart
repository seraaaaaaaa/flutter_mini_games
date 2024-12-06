import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mini_games/enum/prizes.dart';

import 'package:mini_games/screen/games/components/prize_dialog.dart';
import 'package:mini_games/screen/games/components/prize_widget.dart';
import 'package:mini_games/screen/games/stop/widgets/stop_button.dart';
import 'package:mini_games/themes/constant.dart';
import 'package:responsive_framework/responsive_framework.dart';

class PrizeCarousel extends StatefulWidget {
  final List<Prizes> prizes;
  final bool canPlay;
  final Function() onStart;
  final Function(int) onEnd;

  const PrizeCarousel({
    super.key,
    required this.prizes,
    required this.canPlay,
    required this.onStart,
    required this.onEnd,
  });

  @override
  PrizeCarouselState createState() => PrizeCarouselState();
}

class PrizeCarouselState extends State<PrizeCarousel> {
  late List<Prizes> _prizes = [];

  final _carouselController = CarouselSliderController();
  bool _isAnimating = false;
  bool _isRunning = false;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();

    _prizes = widget.prizes;
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _toggleAnimation() async {
    if (_isAnimating) {
      await Future.delayed(const Duration(milliseconds: 100));
      _carouselController.stopAutoPlay();
      setState(() {
        _isAnimating = false;
        _isRunning = true;
      });

      await Future.delayed(const Duration(milliseconds: 400));
      // Display the selected prize
      if (mounted) {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return PrizeDialog(
                prize: _prizes[_currentIndex],
                prizeName: _prizes[_currentIndex].name,
                onDone: () async {
                  widget.onEnd(_currentIndex);

                  setState(() {
                    _isRunning = false;
                  });

                  Navigator.pop(context);
                },
              );
            });
      }
    } else {
      widget.onStart();

      _carouselController.startAutoPlay;

      setState(() {
        _isAnimating = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: ResponsiveBreakpoints.of(context).smallerThan(TABLET)
          ? size.height * .8
          : size.height * .75,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: kPadding),
          Container(
            width: 400,
            height: ResponsiveBreakpoints.of(context).smallerThan(TABLET)
                ? 250
                : 300,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: kGreyColor.withOpacity(0.2),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
                border: Border.all(color: kWhiteColor, width: 10)),
            margin: const EdgeInsets.all(kPadding),
            padding: const EdgeInsets.all(kPadding),
            child: CarouselSlider(
              items: _prizes.map((prize) {
                return Container(
                  padding: const EdgeInsets.all(kPadding),
                  color: kWhiteColor,
                  child: Center(
                    child: PrizeWidget(prize: prize),
                  ),
                );
              }).toList(),
              carouselController: _carouselController,
              options: CarouselOptions(
                aspectRatio:
                    ResponsiveBreakpoints.of(context).smallerThan(TABLET)
                        ? 2
                        : 3,
                viewportFraction: 1,
                autoPlayInterval: const Duration(milliseconds: 100),
                autoPlayAnimationDuration: const Duration(milliseconds: 50),
                autoPlay: _isAnimating,
                enlargeCenterPage: false,
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
              ),
            ),
          ),
          const SizedBox(height: 60),
          StopButton(
            isRunning: _isAnimating,
            onTap: !widget.canPlay || _isRunning
                ? null
                : () {
                    _toggleAnimation();
                  },
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
