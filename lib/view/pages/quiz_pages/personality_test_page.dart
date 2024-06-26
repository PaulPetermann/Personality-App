import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:personality_app/model/history_model.dart';
import 'package:personality_app/model/question.dart';
import 'package:personality_app/model/create_quiz.dart';

class PersonalityTestPage extends StatefulWidget {
  // const PersonalityTestPage({super.key, required this.selected});
  // final int selected;
  @override
  _PersonalityTestPageState createState() => _PersonalityTestPageState();
}

class _PersonalityTestPageState extends State<PersonalityTestPage> {
  double _progressValue = 0.0;
  final findname = TextEditingController();                             // controller for the name input
  final Box<Question> _questionsBox = Hive.box<Question>('questions');
  final Box _settings = Hive.box("settings");
  late List<Question> _questionsList = _questionsBox.values.toList();
  late List<String?> _answers =
      List<String?>.filled(_questionsList.length, null);

  late Timer _timer;
  int _elapsedSeconds = 0;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _elapsedSeconds++;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void updateProgress() {
    setState(() {
      int i = 0;
      for (String? ans in _answers) {
        if (ans != null) {
          i++;
        }
      }
      _progressValue = i / _questionsList.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    String formattedTime = _formatTime(_elapsedSeconds);

    return Scaffold(
      appBar: AppBar(
        title: Text('Persönlichkeitstest'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Visibility(
              visible: _settings.get("timerOn"),
              child: Align(
                alignment: Alignment.topRight,
                child: Text(
                  'Time: $formattedTime',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _questionsList.length,
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (index == 0)
                      TextField(
                        controller: findname,
                        decoration: InputDecoration(hintText: "Enter Name"),   // enter name at the very start of quizz
                      ),
                      if (index ==0) SizedBox(height: 40),
                      Text(
                        _questionsList[index].question,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: _questionsList[index].options.map((option) {
                          return Row(
                            children: [
                              Radio(
                                value: option,
                                groupValue: _answers[index],
                                onChanged: (value) {
                                  setState(() {
                                    _answers[index] = value;
                                    updateProgress();
                                  });
                                },
                              ),
                              Text(option),
                            ],
                          );
                        }).toList(),
                      ),
                      SizedBox(height: 20),
                    ],
                  );
                },
              ),
            ),
            Visibility(
              visible: _progressValue == 1.0,
              child: ElevatedButton(
                onPressed: _submitAnswers,
                child: Text('Submit'),
              ),
            ),
            SizedBox(height: 10),
            LinearProgressIndicator(
              value: _progressValue,
              backgroundColor: Colors.grey,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    String minutesStr = (minutes % 60).toString().padLeft(2, '0');
    String secondsStr = remainingSeconds.toString().padLeft(2, '0');
    return '$minutesStr:$secondsStr';
  }

  //TODO:
  void _submitAnswers() async{

    DateTime now = DateTime.now();
    String date = now.toString();
    String outcome = "On the "+ date + ',\n' + findname.text;
    outcome = outcome + " took the " + Allquiz().quizzes["quizzes"][0]["name"] + " test and got the following result:\n";
    int i = 0;
    num score = 0;

    for (var question in Allquiz().quizzes["quizzes"][0]["questions"]){
      for (var option in question["choices"]){
        if (_answers[i] == option["answer"]){
          score = score + option["points"];
        }
      }
      i++;
    }

  for (var result in Allquiz().quizzes["quizzes"][0]["results"]){
    if (score <= result["maxpoints"]){
      outcome = outcome + result["text"];
    }
  }

  Box submit = await Hive.openBox<History>("history");
  submit.add(History(findname.text,outcome));

    // Add your logic to process the answers and navigate to results page
  }
}
