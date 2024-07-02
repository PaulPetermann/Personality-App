import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:personify/view/bottom_navigation/root_bottom_navigation.dart';

/*
class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});
  final Box settings = Hive.box("settings");

  @override
  Widget build(BuildContext context) {
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
      body: Center(
        child: Text(
          'Personify',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}*/
class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    // Navigate to home page after a delay
    Future.delayed(Duration(seconds: 4), () {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const RootBottomNavigation()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/perso.png',
              width: 100,
              height: 100,
            ),
            SizedBox(height: 20),
            Text(
              'Personify',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Discover Your True Self',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
