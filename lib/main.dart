// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(BodyListView());

class BodyListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Building List View"),
        ),
        body: _myListView(),
      ),
    );
  }
}

Widget _myListView() {
  final List<ListItem> items = List<ListItem>.generate(
      10000,
      (int index) => index % 6 == 0
          ? HeadingItem('Heading $index')
          : MessageItem('Sender $index', "Message body"));

  return ListView.builder(
    itemCount: items.length,
    itemBuilder: (BuildContext context, int index) {
      final item = items[index];
      if (item is HeadingItem) {
        return ListTile(
          title:
              Text(item.heading, style: Theme.of(context).textTheme.headline6),
        );
      } else if (item is MessageItem) {
        return ListTile(
          title: Text(
            item.sender,
          ),
          subtitle: Text(item.body),
          leading: Icon(
            Icons.insert_photo,
            color: Colors.red,
          ),
          trailing: Icon(Icons.keyboard_arrow_right),
        );
      }
      return ListTile(
        title: Text(
          "null",
        ),
      );
      // return Card(
      //   child: ListTile(
      //     title: Text("${items[index]}"),
      //     leading: Icon(
      //       Icons.insert_photo,
      //       color: Colors.red,
      //     ),
      //     trailing: Icon(Icons.keyboard_arrow_right),
      //   ),
    },
  );
}

abstract class ListItem {}

class HeadingItem implements ListItem {
  final String heading;

  HeadingItem(this.heading);
}

class MessageItem implements ListItem {
  final String sender;
  final String body;

  MessageItem(this.sender, this.body);
}
