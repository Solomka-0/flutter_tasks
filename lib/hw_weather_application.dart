import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(WeatherApplication());

class WeatherApplication extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.red,
        appBar: AppBar(
          title: Text(
            "Weather Forecast",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
        ),
        body: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Chip(
                backgroundColor: Colors.redAccent,
                label: TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintStyle: TextStyle(
                      color: Colors.white,
                    ),
                    hintText: "Enter city name",
                    icon: Icon(
                      Icons.search,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),
              ),
              Divider(height: 20),
              _cityDetail(),
              Divider(height: 20),
              _temperatureDatail(),
              Divider(height: 20),
              _extraWeatherDetail(),
              Divider(height: 100),
              Text(
                "7-DAY WEATHER FORECAST",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w300),
              ),
              Divider(height: 10),
              Container(
                height: 100,
                child: _weatherForecastDetail(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Column _cityDetail() {
  return Column(
    children: [
      Text(
        "Voronezh region, RU",
        style: TextStyle(
          color: Colors.white,
          fontSize: 30,
          fontWeight: FontWeight.w300,
        ),
      ),
      Divider(height: 10),
      Text(
        "Friday, May 20, 2020",
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w300,
        ),
      ),
    ],
  );
}

Row _temperatureDatail() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Icon(
        Icons.wb_sunny,
        color: Colors.white,
        size: 60,
      ),
      VerticalDivider(),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "23 °C",
            style: TextStyle(
              color: Colors.white,
              fontSize: 40,
              fontWeight: FontWeight.w200,
            ),
          ),
          Text(
            "SUNNY",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    ],
  );
}

Row _extraWeatherDetail() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      _weatherDetail("4", "km/h"),
      _weatherDetail("3", "%"),
      _weatherDetail("20", "%"),
    ],
  );
}

Column _weatherDetail(String parameter, String subscription) {
  return Column(
    children: [
      Icon(
        Icons.ac_unit,
        size: 30,
        color: Colors.white,
      ),
      Text(
        parameter,
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
      Text(
        subscription,
        style: TextStyle(
          color: Colors.white,
          fontSize: 12,
        ),
      ),
    ],
  );
}

Widget _weatherForecastDetail() {
  Map<String, int> forecast = {
    "Monday": 21,
    "Tuesday": 19,
    "Wednesday": 20,
    "Thursday": 22,
    "Friday": 18,
    "Saturday": 20,
    "Sunday": 17,
  };

  return ListView.builder(
    scrollDirection: Axis.horizontal,
    itemCount: forecast.length,
    itemExtent: 160,
    itemBuilder: (BuildContext context, int index) {
      return Container(
        height: 200,
        margin: EdgeInsets.all(3),
        decoration: BoxDecoration(
            color: Colors.grey.shade400.withOpacity(0.4),

            borderRadius: BorderRadius.circular(10)),
        child: ListTile(
          title: Text(
            forecast.keys.toList()[index],
            style: TextStyle(
                color: Colors.white, fontSize: 23, fontWeight: FontWeight.w300),
          ),
          subtitle: Container(
            height: 70,
            child: Row(
              children: [
                Text(
                  "${forecast.values.toList()[index]} °C",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.w300),
                ),
                Expanded(child: Icon(
                  Icons.sunny,
                  color: Colors.white,
                ),)
              ],
            ),
          ),
        ),
      );
    },
  );
}
