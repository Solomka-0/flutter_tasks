import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SecondScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SecondScreenState();
  }
}

class _SecondScreenState extends State<SecondScreen> {
  TextEditingController textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second screen"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(32),
            child: TextField(
              controller: textFieldController,
              style: TextStyle(
                fontSize: 24,
              ),
            ),
          ),
          TextButton(child: Text("Вернуться"), onPressed: () {
            String textToSendBack = textFieldController.text;
            Navigator.pop(context, textToSendBack);
          }),
        ],
      ),
    );
  }
}
