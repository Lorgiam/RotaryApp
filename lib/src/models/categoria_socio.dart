// To parse this JSON data, do
//
//     final categoriaSocio = categoriaSocioFromJson(jsonString);

import 'dart:convert';

List<CategoriaSocio> categoriaSocioFromJson(String str) => List<CategoriaSocio>.from(json.decode(str).map((x) => CategoriaSocio.fromJson(x)));

String categoriaSocioToJson(List<CategoriaSocio> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CategoriaSocio {
    int idSocio;
    int idCategoria;

    CategoriaSocio({
        this.idSocio,
        this.idCategoria,
    });

    CategoriaSocio copyWith({
        int idSocio,
        int idCategoria,
    }) => 
        CategoriaSocio(
            idSocio: idSocio ?? this.idSocio,
            idCategoria: idCategoria ?? this.idCategoria,
        );

    factory CategoriaSocio.fromJson(Map<String, dynamic> json) => CategoriaSocio(
        idSocio: json["idSocio"] == null ? null : json["idSocio"],
        idCategoria: json["idCategoria"] == null ? null : json["idCategoria"],
    );

    Map<String, dynamic> toJson() => {
        "idSocio": idSocio == null ? null : idSocio,
        "idCategoria": idCategoria == null ? null : idCategoria,
    };
}
