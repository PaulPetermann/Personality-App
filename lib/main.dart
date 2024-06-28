import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:personality_app/model/answer_model.dart';
import 'package:personality_app/model/history_model.dart';
import 'package:personality_app/model/question.dart';
import 'package:personality_app/view/bottom_navigation/root_bottom_navigation.dart';
import 'package:personality_app/view/splash_page.dart';
import 'package:personality_app/model/create_quiz.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDir = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(appDocumentDir.path);

  Hive.registerAdapter(QuestionAdapter());
  Hive.registerAdapter(HistoryAdapter());

  final Box settings = await Hive.openBox("settings");
  await Hive.openBox<History>("history");
  Box quizDb = await Hive.openBox<Question>("questions");

  // Innit Settings
  if (settings.get("isDarkmode") == null) {
    settings.put("isDarkmode", false);
  }
  if (settings.get("timerOn") == null) {
    settings.put("timerOn", false);
  }

  if (quizDb.isEmpty) {
    for (var question in Allquiz().quizzes["quizzes"][0]["questions"]){
      List<String> choicelist = [];
      for (var answer in question["choices"]){
        choicelist.add(answer["answer"]);
      }
      quizDb.add(Question(
        question: question["title"],
        options: choicelist,
        ));
    }
    // quizDb.add(Question(
    //     question: "I enjoy social gatherings.", options: ["Yes", "No"]));
    // quizDb.add(Question(
    //     question: "I prefer detailed planning over spontaneity.",
    //     options: ["Yes", "No"]));
    // quizDb.add(Question(
    //     question: 'I often think about the meaning of life.',
    //     options: ["1", "2", "3", "4"]));
    // quizDb.add(Question(
    //     question: "How Important is the Family to you!",
    //     options: ["Yes", "No"]));
  }

  bool? mode = settings.get("isDarkMode");
  runApp(MyApp(isDarkMode: mode ?? false));
}

/// The main app.
class MyApp extends StatelessWidget {
  /// Constructs a [MyApp]
  MyApp({super.key, required this.isDarkMode});
  bool isDarkMode;
  @override
  Widget build(BuildContext context) {
    /*return MaterialApp.router(
      routerConfig: _router,
    );
    */
    return MaterialApp(
      title: 'Flutter Splash Screen',
      theme: isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: SplashScreen(), // Display splash screen initially
    );
  }
}
