import 'package:flutter/material.dart';
import 'package:flutter_application_5_practice/Widgets/TaskWidget.dart';
import 'package:flutter_application_5_practice/models/Task.dart';

class IncompletedTasksPage extends StatelessWidget {
  List<Task> tasks;
  Function delete;
  Function toggle;

  IncompletedTasksPage(this.tasks, this.delete, this.toggle);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: tasks.where((element) => !element.isCompleted).length,
        itemBuilder: (context, index) {
          return TaskWidget(
              tasks.where((element) => !element.isCompleted).toList()[index],
              delete,
              toggle);
        },
      ),
    );
  }
}
