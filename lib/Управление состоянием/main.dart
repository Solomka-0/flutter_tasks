import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Vanilla Demo",
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _rating = 0;

  @override
  Widget build(BuildContext context) {
    double _size = 50;
    return Scaffold(
      appBar: AppBar(
        title: Text("Vanila Demo"),
        centerTitle: true,
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: IconButton(
                onPressed: () {
                  setState(() {
                    _rating = 1;
                  });
                },
                icon:
                    (_rating >= 1 ? Icon(Icons.star) : Icon(Icons.star_border)),
                iconSize: _size,
                color: Colors.indigo.shade500,
              ),
            ),
            Container(
              child: IconButton(
                onPressed: () {
                  setState(() {
                    _rating = 2;
                  });
                },
                icon:
                (_rating >= 2 ? Icon(Icons.star) : Icon(Icons.star_border)),
                iconSize: _size,
                color: Colors.indigo.shade500,
              ),
            ),
            Container(
              child: IconButton(
                onPressed: () {
                  setState(() {
                    _rating = 3;
                  });
                },
                icon:
                (_rating >= 3 ? Icon(Icons.star) : Icon(Icons.star_border)),
                iconSize: _size,
                color: Colors.indigo.shade500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
