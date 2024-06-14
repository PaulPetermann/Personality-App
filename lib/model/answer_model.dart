enum AnswerType {
  yesNo,
  slider,
  multipleChoice,
}

class Answer {
  Answer(this.answers);
  List<String> answers;
}
