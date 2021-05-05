import 'package:flutter/material.dart';
import 'package:flutter_application_5_practice/models/Task.dart';

class TaskWidget extends StatelessWidget {
  Task task;

  Function delete;
  Function toggle;

  TaskWidget(this.task, this.delete, this.toggle);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: task.isCompleted ? Colors.green[100] : Colors.red[100],
          borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        onTap: () {
          //index = 2;
          //controller.animateTo(index);
          Navigator.pop(context);
        },
        title: Text(
          task.title,
          style: TextStyle(
              color: Colors.blueGrey[700],
              fontSize: 14,
              fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          'task.description',
          textAlign: TextAlign.justify,
          style: TextStyle(fontSize: 12),
        ),
        leading: IconButton(
            icon: Icon(
              Icons.delete,
              color: Colors.redAccent,
            ),
            onPressed: () {
              delete(task);
            }),
        trailing: Checkbox(
          activeColor: Colors.green,
          value: task.isCompleted,
          onChanged: (value) {
            //print(value);
            toggle(task);
          },
        ),
      ),
    );
  }
}
