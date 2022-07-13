import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Inherited Demo",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inherited Widget'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          ScopedModel(model: MyModelState(), child: AppRootWidget()),
        ],
      ),
    );
  }
}

class AppRootWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Column(
        children: [
          Text(
            '(Root Widget)',
            style: null,
          ),
          Text(
            '0',
            style: null,
          ),
          SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Counter(),
              Counter(),
            ],
          )
        ],
      ),
    );
  }
}

class Counter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MyModelState>(rebuildOnChange: true, builder: (context, child, model) =>
      Card(
          margin: EdgeInsets.all(4).copyWith(bottom: 32),
          color: Colors.yellowAccent,
          child: Column(
            children: [
              Text('(Child Widget)'),
              Text(
                '${model.counter}',
                style: null,
              ),
              ButtonBar(
                children: [
                  IconButton(
                    onPressed: () => model._decrementCounter(),
                    icon: Icon(Icons.remove),
                    color: Colors.red,
                  ),
                  IconButton(
                    onPressed: () => model._incrementCounter(),
                    icon: Icon(Icons.add),
                    color: Colors.green,
                  )
                ],
              ),
            ],
          ),
        ),);
  }
}

class MyModelState extends Model {
  int _counter = 0;

  int get counter => this._counter;

  void _incrementCounter() {
    _counter++;
    notifyListeners();
  }

  void _decrementCounter() {
    _counter--;
    notifyListeners();
  }
}