import 'package:flutter_application_5_practice/data/DB/DBHelper.dart';

class Task {
  int id;
  String title;
  String description;
  bool isCompleted;

  Task({this.id, this.title, this.description, this.isCompleted});

  Task.fromMap(Map map) {
    this.id = map[DBHelper.taskIDColumnName];
    this.title = map[DBHelper.taskTitleColumnName];
    this.isCompleted = map[DBHelper.taskIsDoneColumnName] == 1 ? true : false;
  }

  toMap() {
    return {
      DBHelper.taskTitleColumnName: this.title,
      DBHelper.taskIsDoneColumnName: this.isCompleted ? 1 : 0
    };
  }

  @override
  String toString() {
    return 'ID: $id\nTitle: $title\nDescription: $description\nCompleted: ${isCompleted ? "Yes" : "No"}';
  }
}
