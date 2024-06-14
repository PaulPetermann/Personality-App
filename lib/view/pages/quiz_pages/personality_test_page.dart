import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:personality_app/model/answer_model.dart';
import 'package:personality_app/model/question_model.dart';

class PersonalityTestPage extends StatefulWidget {
  @override
  _PersonalityTestPageState createState() => _PersonalityTestPageState();
}

class _PersonalityTestPageState extends State<PersonalityTestPage> {
  final _questions = [
    'I enjoy social gatherings.',
    'I prefer detailed planning over spontaneity.',
    'I often think about the meaning of life.',
  ];

  final List<Question> _questionsList = [
    Question(
        question: "I enjoy social gatherings.", answerType: AnswerType.yesNo),
    Question(
        question: "I prefer detailed planning over spontaneity.",
        answerType: AnswerType.yesNo),
    Question(
        question: 'I often think about the meaning of life.',
        answerType: AnswerType.yesNo),
    Question(
        question: "How Important is the Family to you!",
        answerType: AnswerType.yesNo)
  ];

  late List<bool?> _answers = List<bool?>.filled(3, null);
  double _progressValue = 0.0;

  void updateProgress() {
    setState(() {
      int i = 0;
      for (bool? ans in _answers) {
        if (ans != null) {
          i++;
        }
      }
      _progressValue = i / _questions.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Persönlichkeitstest'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _questions.length,
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _questions[index],
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          Radio(
                            value: true,
                            groupValue: _answers[index],
                            onChanged: (value) {
                              setState(() {
                                _answers[index] = value;
                                updateProgress();
                              });
                            },
                          ),
                          Text('Yes'),
                          Radio(
                            value: false,
                            groupValue: _answers[index],
                            onChanged: (value) {
                              setState(() {
                                _answers[index] = value;
                                updateProgress();
                              });
                            },
                          ),
                          Text('No'),
                        ],
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
            LinearProgressIndicator(
              value: _progressValue,
              backgroundColor: Colors.grey,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
          ],
        ),
      ),
    );
  }

  void _submitAnswers() {
    // For now, just print the answers
    print('User answers: $_answers');
    // Add your logic to process the answers and navigate to results page
  }
}
