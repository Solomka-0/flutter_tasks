import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_app/%D0%A5%D1%80%D0%B0%D0%BD%D0%B5%D0%BD%D0%B8%D0%B5%20%D0%B4%D0%B0%D0%BD%D0%BD%D1%8B%D1%85%20%D0%BD%D0%B0%20%D1%83%D1%81%D1%82%D1%80%D0%BE%D0%B9%D1%82%D1%81%D1%82%D0%B2%D0%B5/SQLite%20CRUD/db/database.dart';

import 'model/student.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "SQLite CRUD Demo",
      home: StudentPage(),
    );
  }
}

class StudentPage extends StatefulWidget {
  @override
  _StudentPageState createState() => _StudentPageState();
}

class _StudentPageState extends State<StudentPage> {
  final GlobalKey<FormState> _formStateKey = GlobalKey<FormState>();
  final _studentNameController = TextEditingController();

  late Future<List<Student>> _studentList;
  String _studentName = "None";
  bool isUpdate = false;
  int? studentIdForUpdate;

  @override
  void initState() {
    super.initState();
    updateStudentList();
  }

  void updateStudentList() {
    setState(() {
      _studentList = DBProvider.db.getStudents();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SQLite CRUD Demo"),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Form(
              key: _formStateKey,
              child: TextFormField(
              controller: _studentNameController,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.people,
                  color: Colors.black87,
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onSaved: (value) {
                _studentName = value ?? 'None';
              },
            ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RaisedButton(
                  onPressed: () {
                    if (isUpdate) {
                      _formStateKey.currentState?.save();
                      DBProvider.db
                          .updateStudent(
                          Student(studentIdForUpdate!, _studentName))
                          .then((data) {
                        setState(() {
                          isUpdate = false;
                        });
                      });
                    } else {
                      _formStateKey.currentState?.save();
                      DBProvider.db.insertStudent(Student(null, _studentName));
                    }
                    _studentNameController.text = '';
                    updateStudentList();
                  },
                  child: Text(
                    (isUpdate ? 'UPDATE' : 'ADD'),
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  color: Colors.green[500],
                ),
                SizedBox(width: 20),
                RaisedButton(
                  onPressed: () {
                    _studentNameController.text = '';
                    setState(() {
                      isUpdate = false;
                      studentIdForUpdate = null;
                    });
                  },
                  child: Text(
                    (isUpdate ? 'CANCEL UPDATE' : 'CLEAR'),
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  color: Colors.red[500],
                )
              ],
            ),
            Divider(height: 5),
            Expanded(
              child: FutureBuilder(
                  future: _studentList,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return generateList(snapshot.data as List<Student>);
                    }
                    if (snapshot.data == null || snapshot.data == 0) {
                      return Text('No Data found');
                    }
                    return CircularProgressIndicator();
                  }),
            ),
          ],
        ),
      ),
    );
  }

  SingleChildScrollView generateList(List<Student> students) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SizedBox(
        width: MediaQuery
            .of(context)
            .size
            .width,
        child: DataTable(
          columns: [
            DataColumn(label: Text("NAME")),
            DataColumn(label: Text("DELETE")),
          ],
          rows: students.map(
                (student) =>
                DataRow(cells: [
                  DataCell(Text(student.name), onTap: () {
                    setState(() {
                      isUpdate = true;
                      studentIdForUpdate = student.id;
                    });
                    _studentNameController.text = student.name;
                  }),
                  DataCell(IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      DBProvider.db.deleteStudent(student.id ?? 0);
                      updateStudentList();
                    },
                  ))
                ]),
          ).toList(),
        ),
      ),
    );
  }
}
