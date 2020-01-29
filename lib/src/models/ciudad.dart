// To parse this JSON data, do
//
//     final ciudad = ciudadFromJson(jsonString);

import 'dart:convert';

List<Ciudad> ciudadFromJson(String str) => List<Ciudad>.from(json.decode(str).map((x) => Ciudad.fromJson(x)));

String ciudadToJson(List<Ciudad> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Ciudad {
    int idCiudad;
    String nombreCiudad;
    int idDepartamento;

    Ciudad({
        this.idCiudad,
        this.nombreCiudad,
        this.idDepartamento,
    });

    Ciudad copyWith({
        int idCiudad,
        String nombreCiudad,
        int idDepartamento,
    }) => 
        Ciudad(
            idCiudad: idCiudad ?? this.idCiudad,
            nombreCiudad: nombreCiudad ?? this.nombreCiudad,
            idDepartamento: idDepartamento ?? this.idDepartamento,
        );

    factory Ciudad.fromJson(Map<String, dynamic> json) => Ciudad(
        idCiudad: json["idCiudad"] == null ? null : json["idCiudad"],
        nombreCiudad: json["nombreCiudad"] == null ? null : json["nombreCiudad"],
        idDepartamento: json["idDepartamento"] == null ? null : json["idDepartamento"],
    );

    Map<String, dynamic> toJson() => {
        "idCiudad": idCiudad == null ? null : idCiudad,
        "nombreCiudad": nombreCiudad == null ? null : nombreCiudad,
        "idDepartamento": idDepartamento == null ? null : idDepartamento,
    };
}
