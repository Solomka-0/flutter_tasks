// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AssetsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: "IndieFlower",
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Adding assets"),
        ),
        body: Center(
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image(image: AssetImage("assets/images/015 bg.jpg")),
              Image.asset('assets/icons/015 icon.png'),
              Positioned(
                top: 16,
                left: 100,
                child: Text("IndieFlower-Regular",
                style: TextStyle(
                  // fontFamily: "IndieFlower",
                  fontSize: 30,
                  color: Colors.green,
                ),

              ),),
            ],
          ),
        ),
      ),
    );
  }
}

void main() => runApp(AssetsApp());
