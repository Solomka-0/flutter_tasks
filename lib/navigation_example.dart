import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Routring and Navigation"),
          centerTitle: true,
        ),
        body: HomePage(),
      ),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/home':
            return MaterialPageRoute(builder: (context) => HomePage());
          case '/page2':
            User my_user = settings.arguments as User;
            return MaterialPageRoute(builder: (context) => Page2(user: my_user));

        }
      },
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: RaisedButton(
        onPressed: () {
          User user = User("Maximus", 20);
          Navigator.pushNamed(context, "/page2", arguments: user);
        },
        child: Text("Перейти на страницу 2"),
      ),
    );
  }
}

class Page2 extends StatelessWidget {
  final User? user;

  Page2({this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${user?.name}:${user?.age}"),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("Вернуться назад"),
        ),
      ),
    );
  }
}

class User {
  final String name;
  final int age;

  User(this.name, this.age);
}
