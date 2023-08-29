// To parse this JSON data, do
//
//     final countryModel = countryModelFromMap(jsonString);

import 'dart:convert';

import '../providers/constant.dart';

class CountryModel {
  String? typename;
  Data? data;

  CountryModel({
    this.typename,
    this.data,
  });

  factory CountryModel.fromJson(String str) => CountryModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CountryModel.fromMap(Map<String, dynamic> json) => CountryModel(
        typename: json["__typename"],
        data: Data.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "__typename": typename,
        "data": data!.toMap(),
      };
}

class Data {
  List<Continent>? continents;

  Data({
    this.continents,
  });

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        continents: List<Continent>.from(json["continents"].map((x) => Continent.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "continents": List<dynamic>.from(continents!.map((x) => x.toMap())),
      };
}

class Continent {
  String? typename;
  String? name;
  String? code;

  Continent({
    this.typename,
    this.name,
    this.code,
  });

  factory Continent.fromJson(String str) => Continent.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Continent.fromMap(Map<String, dynamic> json) => Continent(
        typename: json["__typename"],
        name: json["name"],
        code: json["code"],
      );

  Map<String, dynamic> toMap() => {
        "__typename": typename,
        "name": name,
        "code": code,
      };
}

class GraphQLResponseModel {
  int? _statusCode;
  String? _message;
  dynamic _data;

  int? get statusCode => _statusCode;

  String? get message => _message;

  dynamic get data => _data;

  GraphQLResponseModel({int? statusCode, String? message, int? error, dynamic data}) {
    _statusCode = statusCode;
    _message = message;
    _data = data;
  }

  GraphQLResponseModel.fromJson(dynamic json) {
    _statusCode = json["status"];
    _message = json["message"];
    _data = json["data"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["status"] = _statusCode;
    map["message"] = _message;
    map["data"] = _data;
    return map;
  }

  bool isSuccessful() => (_statusCode == STATUS_CODE_200 || _statusCode == STATUS_CODE_201);
}
