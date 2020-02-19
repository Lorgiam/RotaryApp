// To parse this JSON data, do
//
//     final storage = storageFromJson(jsonString);

import 'dart:convert';

Storage storageFromJson(String str) => Storage.fromJson(json.decode(str));

String storageToJson(Storage data) => json.encode(data.toJson());

class Storage {
    String tip;
    int usu;
    String nme;

    Storage({
        this.tip,
        this.usu,
        this.nme,
    });

    Storage copyWith({
        String tip,
        int usu,
        String nme,
    }) => 
        Storage(
            tip: tip ?? this.tip,
            usu: usu ?? this.usu,
            nme: nme ?? this.nme,
        );

    factory Storage.fromJson(Map<String, dynamic> json) => Storage(
        tip: json["tip"] == null ? null : json["tip"],
        usu: json["usu"] == null ? null : json["usu"],
        nme: json["nme"] == null ? null : json["nme"],
    );

    Map<String, dynamic> toJson() => {
        "tip": tip == null ? null : tip,
        "usu": usu == null ? null : usu,
        "nme": nme == null ? null : nme,
    };
}
