import 'package:hive/hive.dart';

part 'todo.g.dart';

@HiveType(typeId: 1)
class ToDo extends HiveObject {
  @HiveField(0)
  String todoText;
  @HiveField(1)
  bool isDone;

  ToDo({
    required this.todoText,
    this.isDone = false,
  });
}
