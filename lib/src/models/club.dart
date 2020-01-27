// To parse this JSON data, do
//
//     final club = clubFromJson(jsonString);

import 'dart:convert';

List<Club> clubFromJson(String str) =>
    List<Club>.from(json.decode(str).map((x) => Club.fromJson(x)));

String clubToJson(List<Club> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Club {
  int id;
  String nombreClub;

  Club({
    this.id,
    this.nombreClub,
  });

  Club copyWith({
    int id,
    String nombreClub,
  }) =>
      Club(
        id: id ?? this.id,
        nombreClub: nombreClub ?? this.nombreClub,
      );

  factory Club.fromJson(Map<String, dynamic> json) => Club(
        id: json["id"] == null ? null : json["id"],
        nombreClub: json["nombreClub"] == null ? null : json["nombreClub"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "nombreClub": nombreClub == null ? null : nombreClub,
      };
}
