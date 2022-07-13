import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider<SwitchProvider>.value(value: SwitchProvider()),
        ],
        child: HomePage(),
      ),

    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SwitchProvider _state = Provider.of<SwitchProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Homework Provider"),
        centerTitle: true,
        foregroundColor: _state._titleColor,
        backgroundColor: Colors.black,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: AnimatedContainer(
              height: 200,
              width: 200,
              duration: Duration(milliseconds: 500),
              color: _state._containerColor,
            ),
          ),
          Switch(value: _state.value, onChanged: (value) {
            _state.change();
          })
        ],
      ),
    );
  }
}

class SwitchProvider extends ChangeNotifier {
  Color? _titleColor = Colors.deepPurple[300];
  Color? _containerColor = Colors.deepPurple;
  bool _value = true;

  bool get value => _value;
  Color? get titleColor => _titleColor;
  Color? get containerColor => _containerColor;

  void change() {
    _value = !_value;
    _titleColor = _getRandomColor();
    _containerColor = _getRandomColor();
    notifyListeners();
  }

  Color _getRandomColor() => Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
}
