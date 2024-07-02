import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:personify/view/pages/settings/settings_page.dart';

String result = "this is a test";

void main() {
  testWidgets("App bar should show up", (tester)async{
    await tester.pumpWidget(SettingsPage());
    
    expect(find.byType(AppBar), findsWidgets);
  });
  testWidgets("Title should show up", (tester)async{
    await tester.pumpWidget(SettingsPage());
    
    expect(find.text("Settings"), findsWidgets);
  });
}