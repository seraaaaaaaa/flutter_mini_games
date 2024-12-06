import 'package:flutter/material.dart';
import 'package:mini_games/screen/home/home.dart';
import 'package:mini_games/themes/constant.dart';
import 'package:mini_games/themes/theme.dart';
import 'package:responsive_framework/responsive_framework.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kWhiteColor,
      alignment: Alignment.center,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 800),
        child: MaterialApp(
          title: 'Flutter Mini Games',
          debugShowCheckedModeBanner: false,
          themeMode: ThemeMode.light,
          theme: GlobalThemData.lightThemeData,
          home: const HomeScreen(),
          builder: (context, child) => ResponsiveBreakpoints.builder(
            child: child!,
            breakpoints: [
              const Breakpoint(start: 0, end: 480, name: MOBILE),
              const Breakpoint(start: 481, end: 1200, name: TABLET),
              const Breakpoint(
                  start: 1201, end: double.infinity, name: DESKTOP),
            ],
          ),
        ),
      ),
    );
  }
}
