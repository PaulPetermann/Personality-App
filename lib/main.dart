import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:personality_app/model/history_model.dart';
import 'package:personality_app/view/bottom_navigation/root_bottom_navigation.dart';
import 'package:personality_app/view/splash_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDir = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(appDocumentDir.path);
  await Hive.openBox("settings");
  await Hive.openBox<History>("history");

  runApp(const MyApp());
}

/// The main app.
class MyApp extends StatelessWidget {
  /// Constructs a [MyApp]
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    /*return MaterialApp.router(
      routerConfig: _router,
    );
    */
    return MaterialApp(
      title: 'Flutter Splash Screen',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(), // Display splash screen initially
    );
  }
}
