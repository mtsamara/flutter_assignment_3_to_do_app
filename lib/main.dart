import 'package:flutter/material.dart';
import 'package:flutter_application_5_practice/data/Repository.dart';
import 'package:flutter_application_5_practice/models/Task.dart';
import 'package:flutter_application_5_practice/pages/AllTasksPage.dart';
import 'package:flutter_application_5_practice/pages/CompletedTasksPage.dart';
import 'package:flutter_application_5_practice/pages/IncompletedTasksPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App 5 Practice',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  int index = 0;
  TabController controller;
  @override
  void initState() {
    controller = TabController(length: 3, vsync: this);
  }

  deleteTask(Task task) {
    Repository.tasks.remove(task);
    setState(() {});
  }

  toggleTask(Task task) {
    task.isCompleted = !task.isCompleted;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                child: Text(
                  'M',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              accountName: Text('Mohammed Samara'),
              accountEmail: Text('mtsamara@gmail.com'),
            ),
            ListTile(
              onTap: () {
                index = 0;
                controller.animateTo(index);
                Navigator.pop(context);
              },
              title: Text('All'),
              subtitle: Text('go to All'),
              leading: Icon(Icons.list),
              trailing: Icon(Icons.arrow_forward),
            ),
            ListTile(
              onTap: () {
                index = 1;
                controller.animateTo(index);
                Navigator.pop(context);
              },
              title: Text('Done'),
              subtitle: Text('go to Done'),
              leading: Icon(Icons.done),
              trailing: Icon(Icons.arrow_forward),
            ),
            ListTile(
              onTap: () {
                index = 2;
                controller.animateTo(index);
                Navigator.pop(context);
              },
              title: Text('Incomplete'),
              subtitle: Text('go to Incomplete'),
              leading: Icon(Icons.close),
              trailing: Icon(Icons.arrow_forward),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('To-Do App'),
        /*bottom: TabBar(
          //physics: NeverScrollableScrollPhysics,
          controller: controller,
          tabs: [
            Tab(
              //text: 'All',
              icon: Icon(Icons.list),
            ),
            Tab(
              //text: 'Done',
              icon: Icon(Icons.done),
            ),
            Tab(
              //text: 'Incomplete',
              icon: Icon(Icons.close),
            )
          ],
        ),*/
      ),
      body: TabBarView(controller: controller, children: [
        AllTasksPage(Repository.tasks, deleteTask, toggleTask),
        CompletedTasksPage(Repository.tasks, deleteTask, toggleTask),
        IncompletedTasksPage(Repository.tasks, deleteTask, toggleTask)
      ]),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add new To-Do item',
        child: Icon(Icons.add),
        onPressed: () {
          //controller.animateTo(0);
          Task newTask = Task(
              id: '${Repository.tasks.length}',
              title: 'New To-Do Item',
              description: 'A dynamically created new To-Do item!!',
              isCompleted: false);
          Repository.tasks.add(newTask);
          setState(() {});
          print(newTask);
        },
      ),
      bottomNavigationBar: Container(
        color: Colors.blue,
        child: TabBar(
          labelStyle: TextStyle(fontSize: 12),
          indicatorColor: Colors.white,
          controller: controller,
          tabs: [
            Tab(
              text: 'All',
              icon: Icon(Icons.list),
            ),
            Tab(
              text: 'Done',
              icon: Icon(Icons.done),
            ),
            Tab(
              text: 'Incomplete',
              icon: Icon(Icons.close),
            )
          ],
        ),
      ),
    );
  }
}
