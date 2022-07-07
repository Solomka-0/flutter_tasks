import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(WeatherApp());

class WeatherApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.menu,
              color: Colors.black54,
            ),
          ),
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            "Weather Application",
            style: TextStyle(
              color: Colors.black87,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.settings,
                color: Colors.black54,
              ),
            )
          ],
        ),
        body: _buildBody(),
      ),
    );
  }
}

Widget _buildBody() {
  return SingleChildScrollView(
    child: Column(
      children: [
        _headerImage(),
        SafeArea(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _weatherDescription(),
                Divider(),
                _temperature(),
                Divider(),
                _temperatureForecast(),
                Divider(),
                _footerRatings(),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Image _headerImage() {
  return Image.network(
    "https://s1.1zoom.ru/big3/474/354282-admin.jpg",
  );
}

Column _weatherDescription() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Text(
        "Вторник - 22 мая",
        style: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
        ),
      ),
      Divider(),
      Text(
        "описание погоды бла-бла-бла бла-бла-бла бла-бла-блабла-бла-бла бла-бла-бла бла-бла-бла бла-бла-бла бла-бла-бла ",
        style: TextStyle(
          color: Colors.black54,
          fontSize: 15,
        ),
      ),
    ],
  );
}

Row _temperature() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Column(
        children: [
          Icon(
            Icons.sunny,
            color: Colors.yellow,
          ),
        ],
      ),
      SizedBox(
        width: 16,
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "23° Солнечно",
                style: TextStyle(color: Colors.deepPurple),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                "Воронежская область, Воронеж",
                style: TextStyle(color: Colors.grey),
              )
            ],
          ),
        ],
      ),
    ],
  );
}

Wrap _temperatureForecast() {
  return Wrap(
    spacing: 10,
    children: List.generate(
      8,
      (int index) => Chip(
        label: Text(
          "${Random(index).nextInt(index + 1) + 20}° C",
          style: TextStyle(fontSize: 15),
        ),
        avatar: Icon(
          Icons.cloud,
          color: Colors.blue,
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
            side: BorderSide(color: Colors.grey)),
        backgroundColor: Colors.grey.shade100,
      ),
    ),
  );
}

Row _footerRatings() {
  Row _stars = Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(
        Icons.star,
        size: 20,
        color: Colors.yellow,
      ),
      Icon(
        Icons.star,
        size: 20,
        color: Colors.yellow,
      ),
      Icon(
        Icons.star,
        size: 20,
        color: Colors.yellow,
      ),
      Icon(
        Icons.star,
        size: 20,
        color: Colors.grey.shade700,
      ),
      Icon(
        Icons.star,
        size: 20,
        color: Colors.grey.shade700,
      ),
    ],
  );

  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Text(
        "openweathermap.com",
        style: TextStyle(
          fontSize: 15,
        ),
      ),
      _stars,
    ],
  );
}
