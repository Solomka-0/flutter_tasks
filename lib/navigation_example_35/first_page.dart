import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'second_page.dart';

class FirstScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  String text = 'Some Text';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FirstScreen"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: TextStyle(
                fontSize: 24,
              ),
            ),
            TextButton(
              child: Text("Перейти на вторую страницу"),
              onPressed: () => _returnDataSecondScreen(context),
            )
          ],
        ),
      ),
    );
  }

  void _returnDataSecondScreen(BuildContext context) async {
    Route route = MaterialPageRoute(builder: (context) => SecondScreen());
    final result = await Navigator.push(context, route);

    setState(() {
      text = result;
    });
  }
}
