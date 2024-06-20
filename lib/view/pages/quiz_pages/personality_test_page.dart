import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:personality_app/model/answer_model.dart';
import 'package:personality_app/model/question.dart';

class PersonalityTestPage extends StatefulWidget {
  @override
  _PersonalityTestPageState createState() => _PersonalityTestPageState();
}

class _PersonalityTestPageState extends State<PersonalityTestPage> {
  double _progressValue = 0.0;
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
  void _submitAnswers() {
    // For now, just print the answers
    print('User answers: $_answers');
    // Add your logic to process the answers and navigate to results page
  }
}
