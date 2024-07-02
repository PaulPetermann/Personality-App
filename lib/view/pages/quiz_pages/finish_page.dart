import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:personality_app/model/endquiz_handler.dart';
import 'package:personality_app/view/pages/quiz_pages/personality_test_page.dart';

class ReviewPage extends StatelessWidget{
  const ReviewPage({super.key, required this.result});
  final String result;
  @override
  Widget build(BuildContext context){

    return Center(
      child: ListView(
        children: [
          SizedBox(height: 20,),
          Text("Your results!",style: TextStyle(fontSize: 22),),
          SizedBox(height: 15,),
          Text(result),
          SizedBox(height: 10,),
        ],
      ),
    );
  }
}