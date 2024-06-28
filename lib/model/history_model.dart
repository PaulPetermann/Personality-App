import 'package:hive_flutter/hive_flutter.dart';
part 'history_model.g.dart';

@HiveType(typeId: 1)
class History extends HiveObject{
  @HiveField(1)
  String playerName;
  @HiveField(3)
  String results;
  History(this.playerName, this.results);
}
