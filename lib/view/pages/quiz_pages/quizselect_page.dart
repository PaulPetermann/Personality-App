import 'package:flutter/material.dart';
import 'package:personality_app/view/pages/quiz_pages/personality_test_page.dart';
import 'package:personality_app/model/create_quiz.dart';

class QuizSelecterPage extends StatefulWidget{

  @override
  _QuizSelecterPageState createState() => _QuizSelecterPageState();
}

class _QuizSelecterPageState extends State<QuizSelecterPage>{
  int _selected = -1;

  @override
  Widget build(BuildContext context) {

    if (_selected == -1){
      return Center(
        child: Column(
          children: [
            SizedBox(height: 40,),
            for(int i =0; i < Allquiz().quizzes["quizzes"].length; i++)
              ElevatedButton(
                onPressed: (){
                  setState(() {
                    _selected = i;
                  });
                },
                child: Text(Allquiz().quizzes["quizzes"][i]["name"]),
                ),
          ],
        ),
      );
    }else{
      return PersonalityTestPage(selected: _selected,);
    }
  }
}