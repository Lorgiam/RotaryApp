// To parse this JSON data, do
//
//     final categoriaSocio = categoriaSocioFromJson(jsonString);

import 'dart:convert';

CategoriaSocioDto categoriaSocioFromJson(String str) => CategoriaSocioDto.fromJson(json.decode(str));

String categoriaSocioToJson(CategoriaSocioDto data) => json.encode(data.toJson());

class CategoriaSocioDto {
    int idCategoria;
    int idSocio;

    CategoriaSocioDto({
        this.idCategoria,
        this.idSocio,
    });

    CategoriaSocioDto copyWith({
        int idCategoria,
        int idSocio,
    }) => 
        CategoriaSocioDto(
            idCategoria: idCategoria ?? this.idCategoria,
            idSocio: idSocio ?? this.idSocio,
        );

    factory CategoriaSocioDto.fromJson(Map<String, dynamic> json) => CategoriaSocioDto(
        idCategoria: json["idCategoria"] == null ? null : json["idCategoria"],
        idSocio: json["idSocio"] == null ? null : json["idSocio"],
    );

    Map<String, dynamic> toJson() => {
        "idCategoria": idCategoria == null ? null : idCategoria,
        "idSocio": idSocio == null ? null : idSocio,
    };
}
