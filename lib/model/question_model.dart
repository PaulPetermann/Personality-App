import 'package:personality_app/model/answer_model.dart';

class Question {
  Question(
      {required this.question,
      required this.answerType,
      required this.options});
  String question;
  AnswerType answerType;
  final List<String> options;
}
