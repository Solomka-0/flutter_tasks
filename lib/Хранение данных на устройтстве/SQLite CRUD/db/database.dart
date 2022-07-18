import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:test_app/%D0%A5%D1%80%D0%B0%D0%BD%D0%B5%D0%BD%D0%B8%D0%B5%20%D0%B4%D0%B0%D0%BD%D0%BD%D1%8B%D1%85%20%D0%BD%D0%B0%20%D1%83%D1%81%D1%82%D1%80%D0%BE%D0%B9%D1%82%D1%81%D1%82%D0%B2%D0%B5/SQLite%20CRUD/model/student.dart';

class DBProvider {
  DBProvider._();


  static final DBProvider db = DBProvider._();

  static Database? _database;
  String studentsTable = 'Students';
  String columnId = 'id';
  String columnName = 'name';

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path + "Student.db";
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  void _createDB(Database db, int version) async {
    await db.execute('CREATE TABLE $studentsTable($columnId INTEGER PRIMARY KEY AUTOINCREMENT, $columnName TEXT)');
  }

  //
  Future<List<Student>> getStudents() async {
    Database db = await this.database;
    final List<Map<String, dynamic>> studentsMapList = await db.query(studentsTable);
    final List<Student> studentsList = [];
    studentsMapList.forEach((studentsMap) {
      studentsList.add(Student.fromMap(studentsMap));
    });

    return studentsList;
  }

  // INSERT
  Future<Student> insertStudent(Student student) async {
    Database db = await this.database;
    student.id = await db.insert(studentsTable, student.toMap());
    return student;
  }

  // UPDATE
  Future<int> updateStudent(Student student) async {
    Database db = await this.database;
    return await db.update(studentsTable, student.toMap(), where: '$columnId = ?', whereArgs: [student.id]);
  }

  // DELETE
  Future<int> deleteStudent(int id) async {
    Database db = await this.database;
    return await db.delete(
      studentsTable,
      where: "$columnId = ?",
      whereArgs: [id],
    );
  }
}

