// To parse this JSON data, do
//
//     final hipoClient = hipoClientFromMap(jsonString);

import 'dart:convert';

HipoClient hipoClientFromMap(String str) => HipoClient.fromMap(json.decode(str));

String hipoClientToMap(HipoClient data) => json.encode(data.toMap());

class HipoClient {
    HipoClient({
        required this.name,
        required this.age,
        required this.location,
        required this.github,
        required this.hipo,
    });

    final String name;
    final int age;
    final String location;
    final String github;
    final Hipo hipo;

    factory HipoClient.fromMap(Map<String, dynamic> json) => HipoClient(
        name: json["name"],
        age: json["age"],
        location: json["location"],
        github: json["github"],
        hipo: Hipo.fromMap(json["hipo"]),
    );

    Map<String, dynamic> toMap() => {
        "name": name,
        "age": age,
        "location": location,
        "github": github,
        "hipo": hipo.toMap(),
    };
}

class Hipo {
    Hipo({
        required this.position,
        required this.yearsInHipo,
    });

    final String position;
    final int yearsInHipo;

    factory Hipo.fromMap(Map<String, dynamic> json) => Hipo(
        position: json["position"],
        yearsInHipo: json["years_in_hipo"],
    );

    Map<String, dynamic> toMap() => {
        "position": position,
        "years_in_hipo": yearsInHipo,
    };
}


