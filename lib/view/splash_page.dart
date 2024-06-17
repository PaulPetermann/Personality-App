import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:personality_app/view/bottom_navigation/root_bottom_navigation.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});
  final Box settings = Hive.box("settings");
  void checkSettings() {
    if (settings.get("isDarkmode") == null) {
      settings.put("isDarkmode", false);
    }
    if (settings.get("timerOn") == null) {
      settings.put("timerOn", false);
    }
  }

  @override
  Widget build(BuildContext context) {
    checkSettings();

    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => MaterialApp(
                  theme: ThemeData(appBarTheme: const AppBarTheme()),
                  home: const RootBottomNavigation(),
                )),
      );
    });

    return const Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Center(
        child: Text(
          'Personality-Test App',
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
      ),
    );
  }
}
