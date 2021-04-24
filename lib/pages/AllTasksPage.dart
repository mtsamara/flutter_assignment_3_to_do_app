import 'package:flutter/material.dart';
import 'package:flutter_application_5_practice/Widgets/TaskWidget.dart';
import 'package:flutter_application_5_practice/models/Task.dart';

class AllTasksPage extends StatelessWidget {
  List<Task> tasks;
  Function delete;
  Function toggle;

  AllTasksPage(this.tasks, this.delete, this.toggle);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return TaskWidget(tasks[index], delete, toggle);
        },
      ),
    );
  }
}
