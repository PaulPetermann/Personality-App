import 'package:flutter/material.dart';
import 'package:personify/model/create_quiz.dart';
import 'package:personify/model/endquiz_handler.dart';
import 'package:personify/view/pages/quiz_pages/finish_page.dart';
import 'package:personify/view/pages/quiz_pages/personality_test_page.dart';
import 'package:provider/provider.dart';

class QuizSelecterPage extends StatefulWidget{

  @override
  _QuizSelecterPageState createState() => _QuizSelecterPageState();
}

class _QuizSelecterPageState extends State<QuizSelecterPage>{
  int _selected = -1;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Finisher>(
      create: (_) => Finisher(),
      builder: (context, child) {
    var appState = context.watch<Finisher>();

    if (_selected == -1){
      return Center(
        child: ListView(
          children: [
            SizedBox(height: 40,),
            Text("Available tests:",style: TextStyle(fontSize: 22),),
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
      if (!appState.isfinished){
        return PersonalityTestPage(selected: _selected,);
      }else{
        return ListView(
          children:[
            ReviewPage(result:appState.results),
            ElevatedButton(
              onPressed: (){
                appState.isfinished = false;
                setState(() {
                  _selected = -1;
                });
              },
              child: Text("Finish review"))
          ]
        );
      }
    }
  });
  }
}