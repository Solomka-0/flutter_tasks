import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'offices.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    getOfficesList();
    return MaterialApp(
      title: "Зависимости",
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<OfficesList>? officesList;

  @override
  void initState() {
    super.initState();
    officesList = getOfficesList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MyApp"),
        centerTitle: true,),
      body: FutureBuilder<OfficesList>(
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  title: Text('${snapshot.data?.offices![index].name}'),
                  subtitle: Text('${snapshot.data?.offices![index].address}'),
                  leading: Image.network('${snapshot.data?.offices![index].image}'),
                  isThreeLine: true,
                ),
              );
            },
              itemCount: snapshot.data?.offices?.length);
          } else if (snapshot.hasError) {
            return Text('Error');
          }
          return Text("Something");
        },
        future: officesList,
      ),
    );
  }

}

Future<http.Response> getData() async {
  Uri url = Uri.https("about.google", "/static/data/locations.json");
  return await http.get(url);
}

void loadData() {
  getData().then((responce) {
    if (responce.statusCode == 200) {
      print(responce.body);
    } else {
      print(responce.statusCode);
    }
  }).catchError((error) {
    print(error);
  });
  print("some text");
}
