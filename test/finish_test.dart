import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:personify/view/pages/quiz_pages/finish_page.dart';

String result = "this is a test";

void main() {
  testWidgets("sized boxes should show up", (tester)async{
    await tester.pumpWidget(ReviewPage(result: result,));
    
    expect(find.byType(SizedBox), findsWidgets);
  });
  testWidgets("Title should show up", (tester)async{
    await tester.pumpWidget(ReviewPage(result: result,));
    
    expect(find.text("Your results!"), findsWidgets);
  });
  testWidgets("Results should show up", (tester)async{
    await tester.pumpWidget(ReviewPage(result: result,));
    
    expect(find.text(result), findsOneWidget);
  });
}