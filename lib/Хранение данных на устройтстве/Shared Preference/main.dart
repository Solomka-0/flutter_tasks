import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SharedPreferencesExamplePage(),
    );
  }
}

class SharedPreferencesExamplePage extends StatefulWidget {
  @override
  _SharedPreferencesExamplePageState createState() =>
      _SharedPreferencesExamplePageState();
}

class _SharedPreferencesExamplePageState
    extends State<SharedPreferencesExamplePage> {

  late SharedPreferences _prefs;

  static const String _numberPrefKey = 'number_pref';
  static const String _boolPrefKey = 'bool_pref';

  int _numberPref = 0;
  bool _boolPref = false;

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance()
    ..then((prefs) {
      setState(() => this._prefs = prefs);
      _loadNumberPref();
      _loadBoolPref();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shared Preference Demo"),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Number Preference"),
                Text("${this._numberPref}"),
                RaisedButton(
                  onPressed: () async => this._setNuberPref(this._numberPref + 1),
                  child: Text("Increment"),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Boolean Preference"),
                Text("${this._boolPref}"),
                RaisedButton(
                  onPressed: () async => this._setBoolPref(!this._boolPref),
                  child: Text("Toogle"),
                )
              ],
            ),
            Center(
              child: RaisedButton(
                onPressed: () {
                  _resetDataPref();
                },
                child: Text("Reset Data"),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<Null> _setNuberPref(int value) async {
    await _prefs.setInt(_numberPrefKey, value);
    _loadNumberPref();
  }

  Future<Null> _setBoolPref(bool value) async {
    await _prefs.setBool(_boolPrefKey, value);
    _loadBoolPref();
  }

  Future<Null> _resetDataPref() async {
    await this._prefs.remove(_numberPrefKey);
    await this._prefs.remove(_boolPrefKey);
    _loadNumberPref();
    _loadBoolPref();
  }

  void _loadNumberPref() {
    setState(() {
      _numberPref = _prefs.getInt(_numberPrefKey) ?? 0;
    });
  }

  void _loadBoolPref() {
    setState(() {
      _boolPref = _prefs.getBool(_boolPrefKey) ?? false;
    });
  }
}
