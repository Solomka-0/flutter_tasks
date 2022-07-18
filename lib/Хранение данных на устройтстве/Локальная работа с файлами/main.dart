import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ReadWriteFileExample(),
    );
  }
}

class ReadWriteFileExample extends StatefulWidget {
  @override
  _ReadWriteFileExampleState createState() => _ReadWriteFileExampleState();
}

class _ReadWriteFileExampleState extends State<ReadWriteFileExample> {
  TextEditingController _textController = TextEditingController();
  TextStyle _h1 = TextStyle(
    fontSize: 20,
    color: Colors.grey[900],
  );

  TextStyle _h2 = TextStyle(
    fontSize: 16,
    color: Colors.grey[600],
  );

  static const String localFileName = "demo_local_file.txt";
  String _localFileContent = '';
  String _localFilePath = localFileName;


  @override
  void initState() {
    super.initState();
    this._readTextFromLocalFile();
    this._getLocalFile.then((file) => setState(() => this._localFilePath = file.path));
  }

  @override
  Widget build(BuildContext context) {
    FocusNode textFieldFocusNode = FocusNode();

    return Scaffold(
        appBar: AppBar(
          title: Text("Local file read/write demo"),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Write to local file",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey[700],
                ),
              ),
              TextField(
                focusNode: textFieldFocusNode,
                controller: _textController,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () async {
                        this._readTextFromLocalFile();
                        this._textController.text = this._localFileContent;
                        FocusScope.of(context).requestFocus(textFieldFocusNode);
                      },
                      child: Text(
                        "Load",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      )),
                  TextButton(
                      onPressed: () async {
                        await this._writeTextToLocalFile(this._textController.text);
                        this._textController.clear();
                        await this._readTextFromLocalFile();
                      },
                      child: Text(
                        "Save",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      )),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "Local file path",
                style: _h1,
              ),
              Text(
                this._localFilePath,
                style: _h2,
              ),
              SizedBox(height: 20),
              Text(
                "Local file content",
                style: _h1,
              ),
              Text(
                this._localFileContent,
                style: _h2,
              ),
            ],
          ),
        ));
  }

  Future<String> get _getLocalPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _getLocalFile async {
    final path = await _getLocalPath;
    return File("$path/$localFileName");
  }

  Future<File> _writeTextToLocalFile(String text) async {
    final file = await _getLocalFile;
    return file.writeAsString(text);
  }

  Future _readTextFromLocalFile() async {
    String content;
    try {
      final file = _getLocalFile;
      content = await file.then((value) => value.readAsString());
    } catch(e) {
      content = "Ошибка загрузки файла: $e";
    }

    setState(() {
      this._localFileContent = content;
    });
  }
}
