import 'package:flutter/material.dart';
import 'package:personality_app/model/settings_model.dart';
import 'package:hive/hive.dart';

/// The Settings screen
class SettingsPage extends StatefulWidget {
  /// Constructs a [SettingsPage]
  SettingsPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return SettingsPageState();
  }
}

class SettingsPageState extends State<SettingsPage> {
  final Box settings = Hive.box("settings");

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: settings.get("isDarkmode") ? ThemeData.dark() : ThemeData.light(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Settings')),
        body: Column(
          children: [
            Text(
              settings.get("isDarkmode") ? 'Dark Mode' : 'Light Mode',
              style: const TextStyle(fontSize: 18.0),
            ),
            Switch(
              value: settings.get("isDarkmode"),
              onChanged: (value) {
                setState(() {
                  bool current = settings.get("isDarkmode");
                  settings.put("isDarkmode", !current);
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
