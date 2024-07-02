import 'package:hive_flutter/hive_flutter.dart';

part 'question.g.dart';

@HiveType(typeId: 0)
class Question extends HiveObject {
  @HiveField(0)
  String question;
  @HiveField(2)
  final List<String> options;

  Question({required this.question, required this.options});
}
