import 'package:flutter/material.dart';
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
        appBar: AppBar(
          title: const Text('Settings'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildSwitchTile(
                icon: Icons.brightness_6,
                title: 'Dark Mode',
                value: settings.get("isDarkmode"),
                onChanged: (value) {
                  setState(() {
                    bool current = settings.get("isDarkmode");
                    settings.put("isDarkmode", !current);
                  });
                },
              ),
              const Divider(),
              _buildSwitchTile(
                icon: Icons.timer,
                title: 'Timer',
                value: settings.get("timerOn"),
                onChanged: (value) {
                  setState(() {
                    bool current = settings.get("timerOn");
                    settings.put("timerOn", !current);
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSwitchTile({
    required IconData icon,
    required String title,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(
        title,
        style: const TextStyle(fontSize: 18.0),
      ),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
      ),
    );
  }
}
