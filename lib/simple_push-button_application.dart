import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() => runApp(PushButtonApplication());

class PushButtonApplication extends StatelessWidget {
  TextStyle standartTextStyle = const TextStyle(
    fontSize: 16,
    color: Colors.white70,
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.indigo,
        appBar: AppBar(
          title: Text("Push button application"),
          backgroundColor: Colors.black54,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Tap "-" to decrement',
                style: standartTextStyle,
              ),
              CounterWidget(),
              Text(
                'Tap "+" to increment',
                style: standartTextStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CounterWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CounterWidgetState();
}

class CounterWidgetState extends State<CounterWidget> {
  int _counter = 0;
  double _width = 140;

  TextStyle standartTextStyle = const TextStyle(
    fontSize: 16,
    color: Colors.white70,
  );

  setWidth() {
    _width = 140 + (_counter.toString().length - 1 ).toDouble() * 20;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(7),
      decoration: BoxDecoration(
        color: Colors.white70,
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      constraints: BoxConstraints.loose(Size(_width, 50)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {
              setState(() {
                _counter--;
                setWidth();
              });
            },
            icon: Icon(
              Icons.remove,
              size: 35,
              color: Colors.black,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              '$_counter',
              style: TextStyle(
                fontSize: 30,
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                _counter++;
                setWidth();
              });
            },
            icon: Icon(
              Icons.add,
              size: 35,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
