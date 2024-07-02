// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:personality_app/view/pages/history/history_page.dart';

void main() {
  testWidgets("app bar should show up", (tester)async{
    await tester.pumpWidget(HistoryPage());
    
    expect(find.byType(AppBar), findsOneWidget);
  });
  testWidgets("Title should show up", (tester)async{
    await tester.pumpWidget(HistoryPage());
    
    expect(find.text("History"), findsWidgets);
  });
  testWidgets("List should show up", (tester)async{
    await tester.pumpWidget(HistoryPage());
    
    expect(find.byType(ValueListenableBuilder), findsOneWidget);
  });
}
