import 'dart:convert';

import 'package:http/http.dart' as http;

class OfficesList {
  List<Office>? offices;

  OfficesList({this.offices});

  factory OfficesList.fromJson(Map<String, dynamic> json) {
    var officesJson = json['offices'] as List;

    List<Office> officesList = officesJson.map((i) => Office.fromJson(i)).toList();

    return OfficesList(
      offices: officesList,
    );
  }
}

class Office {
  final String? name;
  final String? address;
  final String? image;

  Office({this.name, this.address, this.image});

  factory Office.fromJson(Map<String, dynamic> json) {
    return Office(
      name: json['name'],
      address: json['address'],
      image: json['image'],
    );
  }
}

Future<OfficesList> getOfficesList() async {
  Uri url = Uri.https("about.google", "/static/data/locations.json");
  final responce = await http.get(url);

  if(responce.statusCode == 200) {
    print('nice');
    return OfficesList.fromJson(json.decode(responce.body));
  } else {
    throw Exception('Error: ${responce.reasonPhrase}');
  }
}
