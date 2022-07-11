import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

import 'package:http/http.dart' as http;

part 'offices.g.dart';

@JsonSerializable()
class OfficesList {
  List<Office>? offices;

  OfficesList({this.offices});

  factory OfficesList.fromJson(Map<String, dynamic> json) => _$OfficesListFromJson(json);

  Map<String, dynamic> toJson() => _$OfficesListToJson(this);

}

@JsonSerializable()
class Office {
  final String? name;
  final String? address;
  final String? image;

  Office({this.name, this.address, this.image});

  factory Office.fromJson(Map<String, dynamic> json) => _$OfficeFromJson(json);

  Map<String, dynamic> toJson() => _$OfficeToJson(this);
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
