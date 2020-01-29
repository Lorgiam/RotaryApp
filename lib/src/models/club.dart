// To parse this JSON data, do
//
//     final club = clubFromJson(jsonString);

import 'dart:convert';

List<Club> clubFromJson(String str) => List<Club>.from(json.decode(str).map((x) => Club.fromJson(x)));

String clubToJson(List<Club> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Club {
    int idClub;
    String nombreClub;

    Club({
        this.idClub,
        this.nombreClub,
    });

    Club copyWith({
        int idClub,
        String nombreClub,
    }) => 
        Club(
            idClub: idClub ?? this.idClub,
            nombreClub: nombreClub ?? this.nombreClub,
        );

    factory Club.fromJson(Map<String, dynamic> json) => Club(
        idClub: json["idClub"] == null ? null : json["idClub"],
        nombreClub: json["nombreClub"] == null ? null : json["nombreClub"],
    );

    Map<String, dynamic> toJson() => {
        "idClub": idClub == null ? null : idClub,
        "nombreClub": nombreClub == null ? null : nombreClub,
    };
}
