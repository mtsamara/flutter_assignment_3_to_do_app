import 'dart:io';

import 'package:flutter_application_5_practice/models/Task.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static final String tableName = 'Tasks';
  static final String taskIDColumnName = 'taskID';
  static final String taskTitleColumnName = 'taskTitle';
  static final String taskDescriptionColumnName = 'taskDescription';
  static final String taskIsDoneColumnName = 'taskIsDone';

  //Create private singleton using private constructor to make sure it is created only inside DBHelper
  //Thus, we only have one DB connection instance
  DBHelper._();
  static DBHelper dbHelper = DBHelper._();
  Database database;

  Future<Database> _initDB() async {
    if (database != null) {
      return database;
    } else {
      database = await _connectToDB();
      return database;
    }
  }

  static Future<Database> _connectToDB() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    String dbName = 'tasks.db';
    Database db = await openDatabase(appDocPath + '/' + dbName, version: 1,
        onCreate: (db, version) {
      db.execute('''CREATE TABLE $tableName (
            $taskIDColumnName INTEGER PRIMARY KEY AUTOINCREMENT,
            $taskTitleColumnName TEXT, 
            $taskIsDoneColumnName INTEGER
            )''');
      print('DB created :)');
    }, onOpen: (db) {
      print('DB is open ...');
    });
    return db;
  }

  insertTask(Task task) async {
    //Database db = await connectToDB(); every time CRUD is called will check db connection (app might crash)
    Database db = await _initDB();
    int rowCount = await db.insert(DBHelper.tableName, task.toMap());
    print(rowCount);
  }

  Future<List<Task>> getAllTasks() async {
    Database db = await _initDB();
    List<Map<String, Object>> rows = await db.query(DBHelper.tableName);
    List<Task> tasks = rows.map((e) => Task.fromMap(e)).toList();
    //print(rows);
    return tasks;
  }

  Future<List<Task>> getOneTask(int id) async {
    Database db = await _initDB();
    List<Map<String, Object>> rows = await db.query(DBHelper.tableName,
        where: '${DBHelper.taskIDColumnName}=?', whereArgs: [id]);
    List<Task> tasks = rows.map((e) => Task.fromMap(e)).toList();
    print(rows);
    return tasks;
  }

  Future<int> deleteTask(int id) async {
    Database db = await _initDB();
    int rowsCount = await db.delete(DBHelper.tableName,
        where: '${DBHelper.taskIDColumnName}=?', whereArgs: [id]);
    print(rowsCount);
    return rowsCount;
  }

  Future<int> updateTask(Task task) async {
    Database db = await _initDB();
    task.isCompleted = !task.isCompleted;
    int rowsCount = await db.update(DBHelper.tableName, task.toMap(),
        where: '${DBHelper.taskIDColumnName}=?', whereArgs: [task.id]);
    print(rowsCount);
    return rowsCount;
  }
}
